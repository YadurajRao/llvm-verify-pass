#ifndef GLOBAL_VARIABLE_PASS_H_
#define GLOBAL_VARIABLE_PASS_H_

#include "llvm/IR/PassManager.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"

class GlobalVariablePass : public llvm::PassInfoMixin<GlobalVariablePass> {
public:
  GlobalVariablePass(llvm::raw_ostream& _OS) : OS(_OS) {}
  llvm::PreservedAnalyses run(llvm::Module& M, llvm::ModuleAnalysisManager& AM);

private:
  llvm::raw_ostream& OS;
};

#endif
