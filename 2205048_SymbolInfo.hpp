#ifndef SYMBOL_INFO_HPP
#define SYMBOL_INFO_HPP

#include <string>

class SymbolInfo {
private:
  std::string name;
  std::string type;
public:
  SymbolInfo *next;
  SymbolInfo(std::string name, std::string type) {
    this->name = name;
    this->type = type;
    this->next = NULL;
  }
  void set_name(std::string name) { this->name = name; }
  void set_type(std::string type) { this->type = type; }
  void set_next(SymbolInfo *next) { this->next = next; }
  std::string get_name() { return name; }
  std::string get_type() { return type; }
  SymbolInfo *get_next() { return next; }
};

#endif
