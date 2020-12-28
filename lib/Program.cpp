#include "Program.h"

#include <iostream>
#include <map>

#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Module.h"
#include "llvm/Transforms/Utils/ModuleUtils.h"
#include "z3++.h"

#define LOCAL_DEBUG

using namespace llvm;

namespace {

struct BasicBlockGraph {
  bool has_phi = false;
  std::vector<int> inst;
  std::vector<int> branch_inst;
  std::vector<int> branch_target;
  std::vector<int> phi_inst;
  std::vector<int> phi_inc_blocks;
  std::vector<z3::expr> phi_target_expr;
};

}

Program::Program(Module& M) {
  ParseGlobalVariables(M);
  for (Function& Func : M) {
    ParseThread(Func);
  }
}

z3::expr Program::GetVariableExpr(std::string name) {
  std::map<std::string, z3::expr>::iterator iter = variable_expr_map_.find(name);
  assert(iter != variable_expr_map_.end());
  return iter->second;
}

void Program::ParseGlobalVariables(Module& M) {
#ifdef LOCAL_DEBUG
    std::cout << "parsing global variables now" << std::endl;
#endif
  for (GlobalVariable& Gvar : M.globals()) {
    if (const ConstantInt* CI = dyn_cast<ConstantInt>(Gvar.getInitializer())) {
      std::string name = Gvar.getName().str();
      int64_t value = CI->getSExtValue();
#ifdef LOCAL_DEBUG
        std::cout << name << " = " << value << std::endl;
#endif
      z3::expr rexp = context_.int_val(value);
      AddVariable(name);
      global_var_init_map_.insert(std::make_pair(name, rexp));
    }
  }
}

void Program::ParseThread(Function& Func) {                                     // maps block name to its node number
  std::string thread_name = Func.getName().str();
  thread_names_.push_back(thread_name);
  std::map<std::string, int> block_map;
  std::vector<BasicBlockGraph> bb_automata;
#ifdef LOCAL_DEBUG
    std::cout << "parsing function named " << thread_name << " now" << std::endl;
#endif
  for (BasicBlock& BB : Func) {
    std::string block_name = ValueToVariable(&BB, thread_name);
    // raw_string_ostream block_name_stream(block_name);
    // BB.printAsOperand(block_name_stream, false);
    block_map.insert(make_pair(block_name, static_cast<int>(bb_automata.size())));
    bb_automata.emplace_back();
  }

  int cur_block = 0;
  for (BasicBlock& BB : Func) {
    BasicBlockGraph& bb_struct = bb_automata[cur_block++];
#ifdef LOCAL_DEBUG
    std::cout << "Entering Block " << ValueToVariable(&BB, thread_name);
    std::cout << " now" << std::endl;
#endif
    for (Instruction& Inst : BB) {
      switch (Inst.getOpcode()) {
        case Instruction::Call: {
#ifdef LOCAL_DEBUG
          std::cout << "Entered Call Branch instruction: " << std::endl;
          Inst.printAsOperand(llvm::errs(), false);
          std::cout << std::endl;
          for (Use& U : Inst.operands()) {
            Value* v = U.get();
            llvm::errs() << " ";
            v->printAsOperand(llvm::errs(), false);
          }
          std::cout << std::endl;
#endif
          break;
        }
        case Instruction::Br: {
          BranchInst* br_inst = dyn_cast<BranchInst>(&Inst);
          if (br_inst->isUnconditional()) {
            inst_lval_operands_.push_back("assume");
            z3::expr cond_expr = context_.bool_val(true);
            bb_struct.branch_inst.push_back(static_cast<int>(inst_exprs_.size()));
            inst_exprs_.push_back(cond_expr);
            BasicBlock* bb_next = br_inst->getSuccessor(0);
            std::string bb_name =
                         ValueToVariable(dyn_cast<Value>(bb_next), thread_name);
            std::map<std::string, int>::iterator iter = block_map.find(bb_name);
            assert(iter != block_map.end());
            bb_struct.branch_target.push_back(iter->second);
#ifdef LOCAL_DEBUG
            std::cout << "Unconditional Branch Instruction to ";
            std::cout << iter->second << " block" << std::endl;
#endif
          } else {
            inst_lval_operands_.push_back("assume");
            inst_lval_operands_.push_back("assume");
            Value* v_cond = br_inst->getCondition();
            z3::expr cond_expr =
                        ValueToExpr(v_cond, thread_name) != context_.int_val(0);
            bb_struct.branch_inst.push_back(static_cast<int>(inst_exprs_.size()));
            inst_exprs_.push_back(cond_expr);
            BasicBlock* bb_next = br_inst->getSuccessor(0);
            std::string bb_name =
                         ValueToVariable(dyn_cast<Value>(bb_next), thread_name);
            std::map<std::string, int>::iterator iter = block_map.find(bb_name);
            assert(iter != block_map.end());
            bb_struct.branch_target.push_back(iter->second);
#ifdef LOCAL_DEBUG
            std::cout << "Conditional Branch Instruction" << std::endl;
            std::cout << "If " << ValueToVariable(v_cond, thread_name);
            std::cout << " then go to " << iter->second << " block" << std::endl;
#endif
            cond_expr = (cond_expr == context_.bool_val(false));
            bb_struct.branch_inst.push_back(static_cast<int>(inst_exprs_.size()));
            inst_exprs_.push_back(cond_expr);
            bb_next = br_inst->getSuccessor(1);
            bb_name = ValueToVariable(dyn_cast<Value>(bb_next), thread_name);
            iter = block_map.find(bb_name);
            assert(iter != block_map.end());
            bb_struct.branch_target.push_back(iter->second);
#ifdef LOCAL_DEBUG
            std::cout << "If not " << ValueToVariable(v_cond, thread_name);
            std::cout << " then go to " << iter->second << " block";
            std::cout << std::endl;
#endif
          }
          break;
        }
        case Instruction::PHI: {
          bb_struct.has_phi = true;
          std::string lval_operand = ValueToVariable(&Inst, thread_name);
          AddVariable(lval_operand);
#ifdef LOCAL_DEBUG
          std::cout << "Caught a PHI one here: " << std::endl;
          std::cout << lval_operand << std::endl;
#endif
          PHINode* phi_node = dyn_cast<PHINode>(&Inst);
          for (Use& U : phi_node->incoming_values()) {
            Value* v = U.get();
            z3::expr v_expr = ValueToExpr(v, thread_name);
            bb_struct.phi_inst.push_back(static_cast<int>(inst_exprs_.size()));
            bb_struct.phi_target_expr.push_back(v_expr);
            inst_lval_operands_.push_back(lval_operand);
            inst_exprs_.push_back(v_expr);
#ifdef LOCAL_DEBUG
            std::cout << ValueToVariable(v, thread_name) << " ";
#endif
          }
#ifdef LOCAL_DEBUG
          std::cout << std::endl;
#endif
          for (BasicBlock* inc_bb : phi_node->blocks()) {
            std::string bb_name = ValueToVariable(inc_bb, thread_name);
            std::map<std::string, int>::iterator iter = block_map.find(bb_name);
            assert(iter != block_map.end());
            bb_struct.phi_inc_blocks.push_back(iter->second);
#ifdef LOCAL_DEBUG
            std::cout << bb_name << " ";
#endif
          }
#ifdef LOCAL_DEBUG
          std::cout << std::endl;
#endif
          break;
        }
        case Instruction::Load: {
          bb_struct.inst.push_back(static_cast<int>(inst_exprs_.size()));
          std::string lval_operand = ValueToVariable(&Inst, thread_name);
          AddVariable(lval_operand);
          inst_lval_operands_.push_back(lval_operand);
          Value* rf_val = Inst.getOperand(0);
          z3::expr rhs_expr = ValueToExpr(rf_val, thread_name);
          inst_exprs_.push_back(rhs_expr);
#ifdef LOCAL_DEBUG
          std::cout << lval_operand << " = ";
          std::cout << ValueToVariable(rf_val, thread_name) << std::endl;
#endif
          break;
        }
        case Instruction::Store: {
          bb_struct.inst.push_back(static_cast<int>(inst_exprs_.size()));
          Value* lhs = Inst.getOperand(1);
          std::string lval_operand = ValueToVariable(lhs, thread_name);
          AddVariable(lval_operand);
          inst_lval_operands_.push_back(lval_operand);
          Value* rhs = Inst.getOperand(0);
          z3::expr rhs_expr = ValueToExpr(rhs, thread_name);
          inst_exprs_.push_back(rhs_expr);
#ifdef LOCAL_DEBUG
          std::cout << lval_operand << " = ";
          std::cout << ValueToVariable(rhs, thread_name) << std::endl;
#endif
          break;
        }
        case Instruction::Add:
        case Instruction::Sub:
        case Instruction::Mul:
        case Instruction::ICmp: {
          bb_struct.inst.push_back(static_cast<int>(inst_exprs_.size()));
          std::string lval_operand = ValueToVariable(&Inst, thread_name);
          AddVariable(lval_operand);
          inst_lval_operands_.push_back(lval_operand);
          Value* op1 = Inst.getOperand(0);
          Value* op2 = Inst.getOperand(1);
          z3::expr op1_expr = ValueToExpr(op1, thread_name);
          z3::expr op2_expr = ValueToExpr(op2, thread_name);
          z3::expr rhs_expr = op1_expr + op2_expr;
#ifdef LOCAL_DEBUG
          std::cout << lval_operand << " = ";
          std::cout << ValueToVariable(op1, thread_name) << " ";
#endif
          switch (Inst.getOpcode()) {
            case Instruction::Add:
              rhs_expr = op1_expr + op2_expr;
#ifdef LOCAL_DEBUG
              std::cout << "+ ";
#endif
              break;
            case Instruction::Sub:
              rhs_expr = op1_expr - op2_expr;
#ifdef LOCAL_DEBUG
              std::cout << "- ";
#endif
              break;
            case Instruction::Mul:
              rhs_expr = op1_expr * op2_expr;
#ifdef LOCAL_DEBUG
              std::cout << "* ";
#endif
            case Instruction::ICmp: {
              CmpInst* cmpInst = dyn_cast<CmpInst>(&Inst);
              switch (cmpInst->getPredicate()) {
                case CmpInst::ICMP_EQ:
                  rhs_expr = z3::ite(op1_expr == op2_expr, context_.int_val(1), context_.int_val(0));
#ifdef LOCAL_DEBUG
                  std::cout << "== ";
#endif
                  break;
                case CmpInst::ICMP_NE:
                  rhs_expr = z3::ite(op1_expr != op2_expr, context_.int_val(1), context_.int_val(0));
#ifdef LOCAL_DEBUG
                  std::cout << "!= ";
#endif
                  break;
                case CmpInst::ICMP_SGT:
                  rhs_expr = z3::ite(op1_expr > op2_expr, context_.int_val(1), context_.int_val(0));
#ifdef LOCAL_DEBUG
                  std::cout << "> ";
#endif
                  break;
                case CmpInst::ICMP_SGE:
                  rhs_expr = z3::ite(op1_expr >= op2_expr, context_.int_val(1), context_.int_val(0));
#ifdef LOCAL_DEBUG
                  std::cout << ">= ";
#endif
                  break;
                case CmpInst::ICMP_SLT:
                  rhs_expr = z3::ite(op1_expr < op2_expr, context_.int_val(1), context_.int_val(0));
#ifdef LOCAL_DEBUG
                  std::cout << "< ";
#endif
                  break;
                case CmpInst::ICMP_SLE:
                  rhs_expr = z3::ite(op1_expr <= op2_expr, context_.int_val(1), context_.int_val(0));
#ifdef LOCAL_DEBUG
                  std::cout << "<= ";
#endif
                  break;
                default:
#ifdef LOCAL_DEBUG
                  std::cout << "Error: ICmp predicte: ";
                  std::cout << cmpInst->getPredicate() << " not handled";
                  std::cout << std::endl;
#endif
                  assert(false);
              }
            }
          }
          inst_exprs_.push_back(rhs_expr);
#ifdef LOCAL_DEBUG
          std::cout << ValueToVariable(op2, thread_name) << std::endl;
#endif
          break;
        }
        default: {
#ifdef LOCAL_DEBUG
          std::cout << Inst.getOpcodeName() << std::endl;
#endif
        }
      }
    }
  }
}

std::string Program::ValueToVariable(const Value* v, std::string scope) {
  std::string name;
  raw_string_ostream name_stream(name);
  v->printAsOperand(name_stream, false);
  if (name[0] == '@') {                                                         // a global variable
    return name.substr(1, name.size() - 1);
  } else if (name[0] == '%') {
    return scope + "::" + name.substr(1, name.size() - 1);
  } else {
    return name;
  }
}

z3::expr Program::ValueToExpr(const Value* v, std::string scope) {
  if (const ConstantInt* CI = dyn_cast<ConstantInt>(v)) {
    int64_t val = CI->getSExtValue();
    return context_.int_val(val);
  } else {
    std::string name = ValueToVariable(v, scope);
    return GetVariableExpr(name);
  }
}

bool Program::AddVariable(std::string name) {
  if (variable_expr_map_.find(name) != variable_expr_map_.end()) {
    return false;
  } else {
    z3::expr exp = context_.int_const(name.c_str());
    variable_expr_map_.insert(std::make_pair(name, exp));
    return true;
  }
}
