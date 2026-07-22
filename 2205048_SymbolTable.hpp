#ifndef SYMBOL_TABLE_HPP
#define SYMBOL_TABLE_HPP

#include "2205048_ScopeTable.hpp"
#include <iostream>
#include <string>

extern int N;

class SymbolTable {
private:
  ScopeTable *current_scope;

public:
  SymbolTable() { current_scope = NULL; }
  ~SymbolTable() {
    ScopeTable *curr = current_scope;
    while (curr != NULL) {
      ScopeTable *temp = curr;
      curr = curr->get_parent_scope();
      // std::cout << "\tScopeTable# " << temp->get_id() << " removed\n";
      delete temp;
    }
  }
  void enter_scope() {
    ScopeTable *child = new ScopeTable(N);
    child->set_parent_scope(current_scope);
    current_scope = child;
    // std::cout << "\tScopeTable# " << current_scope->get_id() << " created\n";
  }
  void exit_scope() {
    // cannot exit the root scope table
    if (current_scope == NULL || current_scope->get_parent_scope() == NULL) {
      return;
    }
    ScopeTable *temp = current_scope;
    // std::cout << "\tScopeTable# " << temp->get_id() << " removed\n";
    current_scope = current_scope->get_parent_scope();
    delete temp;
  }
  bool insert(std::string args[], int arg_idx) {
    if (current_scope == NULL) {
      current_scope = new ScopeTable(N);
      current_scope->set_parent_scope(NULL);
      // std::cout << "\tScopeTable# " << current_scope->get_id() << " created\n";
    }
    return current_scope->insert(args, arg_idx);
  }
  SymbolInfo *look_up(std::string name) {
    ScopeTable *curr = current_scope;
    while (curr != NULL) {
      SymbolInfo *temp = curr->look_up(name);
      if (temp != NULL) {
        return temp;
      }
      curr = curr->get_parent_scope();
    }
    std::cout << "\t'" << name << "' not found in any of the ScopeTables\n";
    return NULL;
  }
  bool remove(std::string name) {
    if (current_scope == NULL)
      return false;
    return current_scope->remove(name);
  }
  void print_current_scope() {
    if (current_scope != NULL)
      current_scope->print_scope_table();
  }
  void print_symbol_table() {
    ScopeTable *curr = current_scope;
    while (curr != NULL) {
      curr->print_scope_table();
      curr = curr->get_parent_scope();
    }
  }
  ScopeTable *get_current_scope() { return current_scope; }
};

#endif
