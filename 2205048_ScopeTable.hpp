#ifndef SCOPE_TABLE_HPP
#define SCOPE_TABLE_HPP

#include "2205048_SymbolInfo.hpp"
#include <iostream>
#include <string>

extern int unique_id;

class ScopeTable {
private:
  unsigned int SDBMHash(std::string str, unsigned int num_buckets) {
    unsigned long hash = 0;
    unsigned int len = str.length();
    for (unsigned int i = 0; i < len; i++) {
      hash = (str[i] + (hash << 6) + (hash << 16) - hash) % num_buckets;
    }
    return hash;
  }

  int id;
  ScopeTable *parent_scope;
  SymbolInfo **table;
  unsigned int size;

public:
  ScopeTable(int n) {
    id = ++unique_id;
    this->parent_scope = NULL;
    table = new SymbolInfo *[n];
    for (int i = 0; i < n; i++) {
      table[i] = NULL;
    }
    size = n;
  }
  ~ScopeTable() {
    for (unsigned int i = 0; i < size; i++) {
      SymbolInfo *curr = table[i];
      while (curr != NULL) {
        SymbolInfo *temp = curr;
        curr = curr->get_next();
        delete temp;
      }
    }
    delete[] table;
  }
  int get_id() { return id; }
  void set_parent_scope(ScopeTable *parent_scope) {
    this->parent_scope = parent_scope;
  }
  ScopeTable *get_parent_scope() { return parent_scope; }

  bool insert(std::string args[], int arg_idx) {
    if (arg_idx < 2) return false;
    std::string name = args[0];
    std::string type_kind = args[1];
    std::string final_type = "";
    if (type_kind == "FUNCTION") {
      final_type = type_kind;
      if (arg_idx > 2) {
        final_type += "," + args[2] + "<==(";
        for (int i = 3; i < arg_idx; i++) {
          final_type += args[i];
          if (i < arg_idx - 1) final_type += ",";
        }
        final_type += ")";
      }
    } else if (type_kind == "STRUCT" || type_kind == "UNION") {
      final_type = type_kind + ",{";
      for (int i = 2; i < arg_idx; i += 2) {
        if (i + 1 < arg_idx) {
          final_type += "(" + args[i] + "," + args[i + 1] + ")";
        }
        if (i + 2 < arg_idx) final_type += ",";
      }
      final_type += "}";
    } else {
      final_type = type_kind;
    }
    SymbolInfo s(name, final_type);

    unsigned int index = SDBMHash(s.get_name(), size);
    SymbolInfo *curr = table[index];
    if (curr == NULL) {
      table[index] = new SymbolInfo(s.get_name(), s.get_type());
      std::cout << "\tInserted in ScopeTable# " << id << " at position "
           << (index + 1) << ", " << 1 << "\n";
      return true;
    }
    int pos = 1;
    while (true) {
      if (curr->get_name() == s.get_name()) {
        std::cout << "\t'" << s.get_name()
             << "' already exists in the current ScopeTable\n";
        return false;
      }
      if (curr->get_next() == NULL)
        break;
      curr = curr->get_next();
      pos++;
    }
    SymbolInfo *new_symbol = new SymbolInfo(s.get_name(), s.get_type());
    curr->set_next(new_symbol);
    std::cout << "\tInserted in ScopeTable# " << id << " at position " << (index + 1)
         << ", " << (pos + 1) << "\n";
    return true;
  }

  SymbolInfo *look_up(std::string name) {
    unsigned int index = SDBMHash(name, size);
    SymbolInfo *curr = table[index];
    int pos = 1;
    while (curr != NULL) {
      if (curr->get_name() == name) {
        std::cout << "\t'" << name << "' found in ScopeTable# " << id
             << " at position " << (index + 1) << ", " << pos << "\n";
        return curr;
      }
      curr = curr->get_next();
      pos++;
    }
    return nullptr;
  }

  bool remove(std::string name) {
    unsigned int index = SDBMHash(name, size);
    SymbolInfo *curr = table[index];
    if (curr == NULL) {
      std::cout << "\tNot found in the current ScopeTable\n";
      return false;
    }
    if (curr->get_name() == name) {
      table[index] = curr->get_next();
      std::cout << "\tDeleted '" << name << "' from ScopeTable# " << id
           << " at position " << (index + 1) << ", " << 1 << "\n";
      delete curr;
      return true;
    }
    int pos = 2;
    while (curr->get_next() != NULL) {
      if (curr->get_next()->get_name() == name) {
        SymbolInfo *temp = curr->get_next();
        curr->set_next(temp->get_next());
        std::cout << "\tDeleted '" << name << "' from ScopeTable# " << id
             << " at position " << (index + 1) << ", " << pos << "\n";
        delete temp;
        return true;
      }
      curr = curr->get_next();
      pos++;
    }
    std::cout << "\tNot found in the current ScopeTable\n";
    return false;
  }

  void print_scope_table(int indent) {
    for (int t = 0; t < indent; t++)
      std::cout << "\t";
    std::cout << "ScopeTable# " << id << "\n";
    for (unsigned int i = 0; i < size; i++) {
      for (int t = 0; t < indent; t++)
        std::cout << "\t";
      std::cout << (i + 1) << "--> ";
      SymbolInfo *curr = table[i];
      while (curr != NULL) {
        std::cout << "<" << curr->get_name() << "," << curr->get_type() << "> ";
        curr = curr->get_next();
      }
      std::cout << "\n";
    }
  }
};

#endif
