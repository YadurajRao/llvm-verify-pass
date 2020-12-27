#ifndef PROGRAM_H_
#define PROGRAM_H_

#include <vector>
#include <map>

#include "llvm/IR/Module.h"
#include "z3++.h"

class Program {
public:
  explicit Program(llvm::Module&);

  z3::expr GetVariableExpr(std::string);

private:
  int inst_counter_ = 0;
  z3::context m_context_;
  std::map<std::string, z3::expr> m_global_var_init_map_;
  std::map<std::string, z3::expr> m_variable_expr_map_;
  std::vector<z3::expr> m_inst_exprs_;
  std::vector<std::string> m_inst_lval_operands_;
  std::vector<std::string> m_thread_names_;
  std::vector<std::vector<std::vector<std::pair<int, int> > > > m_thread_graphs_;
  // std::map<std::string, z3::expr> m_inst_expr_map_;
  // std::map<std::string, std::string> m_inst_lval_operand_map_;

  void ParseGlobalVariables(llvm::Module&);
  void ParseThread(llvm::Function&);

  std::string ValueToVariable(const llvm::Value*, std::string scope);
  z3::expr ValueToExpr(const llvm::Value*, std::string scope);

  bool AddVariable(std::string name);
};

#endif
