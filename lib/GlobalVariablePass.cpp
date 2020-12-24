#include "GlobalVariablePass.h"

#include "llvm/IR/IRBuilder.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Transforms/Utils/ModuleUtils.h"

using namespace llvm;

void printTab(int n, raw_ostream& OS) {
  while (n--) {
    OS << "  ";
  }
}

void printLoadInstruction(Instruction& Inst, raw_ostream& OS) {
  Inst.printAsOperand(OS, false);
  OS << " = ";
  Value* rhs = Inst.getOperand(0);
  rhs->printAsOperand(OS, false);
}

void printStoreInstruction(Instruction& Inst, raw_ostream& OS) {
  Value* rhs = Inst.getOperand(0);
  Value* lhs = Inst.getOperand(1);
  lhs->printAsOperand(OS, false);
  OS << " = ";
  rhs->printAsOperand(OS, false);
}

void printAddInstruction(Instruction& Inst, raw_ostream& OS) {
  Value* op1 = Inst.getOperand(0);
  Value* op2 = Inst.getOperand(1);
  Inst.printAsOperand(OS, false);
  OS << " = ";
  op1->printAsOperand(OS, false);
  OS << " + ";
  op2->printAsOperand(OS, false);
}

void printCmpInstruction(Instruction& Inst, raw_ostream& OS) {
  Value* op1 = Inst.getOperand(0);
  Value* op2 = Inst.getOperand(1);
  CmpInst* cmpInst = dyn_cast<CmpInst>(&Inst);
  Inst.printAsOperand(OS, false);
  OS << " = ";
  op1->printAsOperand(OS, false);
  OS << " ";
  switch (cmpInst->getPredicate()) {
    case CmpInst::ICMP_EQ:
      OS << "==";
      break;
    case CmpInst::ICMP_NE:
      OS << "!=";
      break;
    case CmpInst::ICMP_SGT:
      OS << ">";
      break;
    case CmpInst::ICMP_SGE:
      OS << ">=";
      break;
    case CmpInst::ICMP_SLT:
      OS << "<";
      break;
    case CmpInst::ICMP_SLE:
      OS << "<=";
      break;
    default:
      OS << cmpInst->getPredicate();
  }
  OS << " ";
  op2->printAsOperand(OS, false);
}

void getGlobalVariables(Module& M, raw_ostream& OS) {
  OS << "GlobalVariables: \n";
  for (GlobalVariable& Gvar : M.globals()) {
    printTab(1, OS);
    if (const ConstantInt* CI = dyn_cast<ConstantInt>(Gvar.getInitializer())) {
      OS << Gvar.getName() << " = " << CI->getSExtValue() << "\n";
    }
  }
}

void getFunctionGraph(Module& M, raw_ostream& OS) {
  for (Function& Func : M) {
    std::string FuncName = Func.getName().str();
    if (FuncName.substr(0, 3) != "thr") continue;
    printTab(0, OS);
    OS << "Function: " << Func.getName() << "\n";
    //int counter = 0;
    for (BasicBlock& BB : Func) {
      printTab(1, OS);
      OS << "BasicBlock: ";
      BB.printAsOperand(OS, false);
      OS << "\n";
      for (Instruction& Inst : BB) {
        printTab(2, OS);
        switch (Inst.getOpcode()) {
          case Instruction::Alloca:
            break;
          case Instruction::Load:
            printLoadInstruction(Inst, OS);
            break;
          case Instruction::Store:
            printStoreInstruction(Inst, OS);
            break;
          case Instruction::Add:
            printAddInstruction(Inst, OS);
            break;
          case Instruction::ICmp:
            printCmpInstruction(Inst, OS);
            break;
          default:
            OS << Inst.getOpcodeName() << " ";
            Inst.printAsOperand(OS, false);
            for (Use& U : Inst.operands()) {
              Value* v = U.get();
              OS << " ";
              v->printAsOperand(OS, false);
            }
        }
        OS << "\n";
      }
    }
  }
}

PreservedAnalyses GlobalVariablePass::run(Module& M, ModuleAnalysisManager& AM) {
  getGlobalVariables(M, OS);
  getFunctionGraph(M, OS);
  return PreservedAnalyses::all();
}

llvm::PassPluginLibraryInfo getGlobalVariablePassPluginInfo() {
  return {LLVM_PLUGIN_API_VERSION, "GlobalVariablePass", LLVM_VERSION_STRING,
          [](PassBuilder &PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, ModulePassManager &MPM,
                   ArrayRef<PassBuilder::PipelineElement>) {
                  if (Name == "set-global-variables") {
                    MPM.addPass(GlobalVariablePass(llvm::errs()));
                    return true;
                  }
                  return false;
                });
          }};
}

extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return getGlobalVariablePassPluginInfo();
}
