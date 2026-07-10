#include <iostream>
#include <string>
#include <fstream>
#include <sstream>
#include "2205048_SymbolTable.hpp"

using namespace std;

int unique_id = 0;
int N;

int main(int argc, char *argv[]) {
  if (argc != 3) {
    cout << "Usage: ./symbol_table <input_file> <output_file>\n";
    return 1;
  }
  ifstream fin(argv[1]);
  ofstream fout(argv[2]);
  if (!fin.is_open() || !fout.is_open()) {
    cout << "Error opening files!\n";
    return 1;
  }

  streambuf* cout_buf = cout.rdbuf();
  cout.rdbuf(fout.rdbuf());

  string line;
  if (getline(fin, line)) {
    stringstream ss(line);
    ss >> N;
  }

  {
    SymbolTable st;
    st.enter_scope();

    int cmd_count = 1;
    while (getline(fin, line)) {
      stringstream ss(line);
      string cmd;
      if (!(ss >> cmd)) continue;

      string args[50];
      int arg_idx = 0;
      string token;
      string normalized_cmd = cmd;
      while (ss >> token) {
        if (arg_idx < 50) args[arg_idx++] = token;
        normalized_cmd += " " + token;
      }

      if (cmd == "I") {
        cout << "Cmd " << cmd_count << ": " << normalized_cmd << "\n";
        cmd_count++;
        if (arg_idx < 2) {
          cout << "\tNumber of parameters mismatch for the command I\n";
        } else {
          st.insert(args, arg_idx);
        }
      } else if (cmd == "L") {
        cout << "Cmd " << cmd_count << ": " << normalized_cmd << "\n";
        cmd_count++;
        if (arg_idx != 1) {
          cout << "\tNumber of parameters mismatch for the command L\n";
        } else {
          st.look_up(args[0]);
        }
      } else if (cmd == "D") {
        cout << "Cmd " << cmd_count << ": " << normalized_cmd << "\n";
        cmd_count++;
        if (arg_idx != 1) {
          cout << "\tNumber of parameters mismatch for the command D\n";
        } else {
          st.remove(args[0]);
        }
      } else if (cmd == "P") {
        if (arg_idx != 1 || (args[0] != "A" && args[0] != "C")) continue;
        cout << "Cmd " << cmd_count << ": " << normalized_cmd << "\n";
        cmd_count++;
        if (args[0] == "A") st.print_symbol_table();
        else if (args[0] == "C") st.print_current_scope();
      } else if (cmd == "S") {
        cout << "Cmd " << cmd_count << ": " << normalized_cmd << "\n";
        cmd_count++;
        if (arg_idx != 0) {
          cout << "\tNumber of parameters mismatch for the command S\n";
        } else {
          st.enter_scope();
        }
      } else if (cmd == "E") {
        if (st.get_current_scope() != NULL && st.get_current_scope()->get_parent_scope() == NULL) {
          continue;
        }
        cout << "Cmd " << cmd_count << ": " << normalized_cmd << "\n";
        cmd_count++;
        if (arg_idx != 0) {
          cout << "\tNumber of parameters mismatch for the command E\n";
        } else {
          st.exit_scope();
        }
      } else if (cmd == "Q") {
        cout << "Cmd " << cmd_count << ": " << normalized_cmd << "\n";
        cmd_count++;
        break;
      }
    }
  }

  cout.rdbuf(cout_buf);
  return 0;
}
