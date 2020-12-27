#include "Program.h"

#include <iostream>
#include <map>

#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Module.h"
#include "llvm/Transforms/Utils/ModuleUtils.h"
#include "llvm/Support/raw_ostream.h"
#include "z3++.h"

#define LOCAL_DEBUG

using namespace llvm;

void printTab(int n);

Program::Program(Module& M) {
  ParseGlobalVariables(M);
  for (Function& Func : M) {
    ParseThread(Func);
  }
}

z3::expr Program::GetVariableExpr(std::string name) {
  std::map<std::string, z3::expr>::iterator iter = m_variable_expr_map_.find(name);
  assert(iter != m_variable_expr_map_.end());
  return iter->second;
}

void Program::ParseGlobalVariables(Module& M) {
  #ifdef LOCAL_DEBUG
    std::cout << "parsing global variables now" << std::endl;
  #endif
  for (GlobalVariable& Gvar : M.globals()) {
    #ifdef LOCAL_DEBUG
      printTab(1);
    #endif
    if (const ConstantInt* CI = dyn_cast<ConstantInt>(Gvar.getInitializer())) {
      std::string name = Gvar.getName().str();
      int64_t value = CI->getSExtValue();
      #ifdef LOCAL_DEBUG
        std::cout << name << " = " << value << std::endl;
      #endif
      z3::expr rexp = m_context_.int_val(value);
      AddVariable(name);
      m_global_var_init_map_.insert(std::make_pair(name, rexp));
    }
  }
}

void Program::ParseThread(Function& Func) {
  std::map<std::string, int> block_map;                                         // maps block name to its node number
  std::vector<std::vector<std::pair<int, int> > > automata_graph;
  std::string thread_name = Func.getName().str();
  m_thread_names_.push_back(thread_name);

  #ifdef LOCAL_DEBUG
    std::cout << "parsing function named " << thread_name << " now" << std::endl;
  #endif

  for (BasicBlock& BB : Func) {
    std::string block_name;
    raw_string_ostream block_name_stream(block_name);
    BB.printAsOperand(block_name_stream, false);
    #ifdef LOCAL_DEBUG
      printTab(1);
      std::cout << block_name << std::endl;
    #endif
    block_map.insert(make_pair(block_name, (int) automata_graph.size()));
    automata_graph.push_back(std::vector<std::pair<int, int> > ());
    for (Instruction& Inst : BB) {
      #ifdef LOCAL_DEBUG
        printTab(2);
      #endif
      switch (Inst.getOpcode()) {
        case Instruction::Alloca:
          break;
        case Instruction::Load: {
          Value* lhs = dyn_cast<Value>(&Inst);
          std::string lval_operand = ValueToVariable(lhs, thread_name);
          AddVariable(lval_operand);
          m_inst_lval_operands_.push_back(lval_operand);
          Value* rf_val = Inst.getOperand(0);
          z3::expr rh_exp = ValueToExpr(rf_val, thread_name);
          m_inst_exprs_.push_back(rh_exp);
          #ifdef LOCAL_DEBUG
            std::cout << lval_operand << " = ";
            std::cout << ValueToVariable(rf_val, thread_name) << std::endl;
          #endif
          break;
        }
        case Instruction::Store: {
          Value* lhs = Inst.getOperand(1);
          std::string lval_operand = ValueToVariable(lhs, thread_name);
          AddVariable(lval_operand);
          m_inst_lval_operands_.push_back(lval_operand);
          Value* rhs = Inst.getOperand(0);
          z3::expr rh_exp = ValueToExpr(rhs, thread_name);
          m_inst_exprs_.push_back(rh_exp);
          #ifdef LOCAL_DEBUG
            std::cout << lval_operand << " = ";
            std::cout << ValueToVariable(rhs, thread_name) << std::endl;
          #endif
          break;
        }
        case Instruction::Add: {
          break;
        }
        case Instruction::ICmp: {
          break;
        }
        default: {
          #ifdef LOCAL_DEBUG
            std::cout << std::endl;
          #endif
        }
          // OS << Inst.getOpcodeName() << " ";
          // Inst.printAsOperand(OS, false);
          // for (Use& U : Inst.operands()) {
          //   Value* v = U.get();
          //   OS << " ";
          //   v->printAsOperand(OS, false);
          // }
      }
    }
  }
}

std::string Program::ValueToVariable(const Value* v, std::string scope) {
  std::string name;
  raw_string_ostream name_stream(name);
  v->printAsOperand(name_stream, false);
  if (name[0] == '@') {                                                   // a global variable
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
    return m_context_.int_val(val);
  } else {
    std::string name = ValueToVariable(v, scope);
    return GetVariableExpr(name);
  }
}

bool Program::AddVariable(std::string name) {
  if (m_variable_expr_map_.find(name) != m_variable_expr_map_.end()) {
    return false;
  } else {
    z3::expr exp = m_context_.int_const(name.c_str());
    m_variable_expr_map_.insert(std::make_pair(name, exp));
    return true;
  }
}

void printTab(int n) {
  while (n--) {
    std::cout << "  ";
  }
}
