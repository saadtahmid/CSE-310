#!/bin/bash

# Compile the symbol table code
echo "Compiling the project..."
g++ -std=c++17 -Wall 2205048_symbol_table.cpp -o 2205048_symbol_table

# Check if compilation was successful
if [ $? -eq 0 ]; then
    echo "Compilation successful. Executable created: 2205048_symbol_table"
    echo "You can run the program using: ./2205048_symbol_table <input_file> <output_file>"
else
    echo "Compilation failed."
    exit 1
fi
