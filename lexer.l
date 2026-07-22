%option noyywrap;

%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <iostream>
  #include <fstream>
  #include "2205048_SymbolTable.hpp"
  using namespace std;
  ofstream logout;
  FILE *tokenout;
  int line_count=1;
  int N=7;
  SymbolTable st;
%}

%%
[ \t\v\r]+ {}
\n {line_count++;}
"if" {fprintf(tokenout,"<IF> "); fprintf(logout,"Line No. %d: Token <IF> Lexeme %s found\n", line_count, yytext);}
"else" {fprintf(tokenout,"<ELSE> "); fprintf(logout,"Line No. %d: Token <ELSE> Lexeme %s found\n", line_count, yytext);}
"for" {fprintf(tokenout,"<FOR> "); fprintf(logout,"Line No. %d: Token <FOR> Lexeme %s found\n", line_count, yytext);}
"while" {fprintf(tokenout,"<WHILE> "); fprintf(logout,"Line No. %d: Token <WHILE> Lexeme %s found\n", line_count, yytext);}
"do" {fprintf(tokenout,"<DO> "); fprintf(logout,"Line No. %d: Token <DO> Lexeme %s found\n", line_count, yytext);}
"break" {fprintf(tokenout,"<BREAK> "); fprintf(logout,"Line No. %d: Token <BREAK> Lexeme %s found\n", line_count, yytext);}
"int" {fprintf(tokenout,"<INT> "); fprintf(logout,"Line No. %d: Token <INT> Lexeme %s found\n", line_count, yytext);}
"char" {fprintf(tokenout,"<CHAR> "); fprintf(logout,"Line No. %d: Token <CHAR> Lexeme %s found\n", line_count, yytext);}
"float" {fprintf(tokenout,"<FLOAT> "); fprintf(logout,"Line No. %d: Token <FLOAT> Lexeme %s found\n", line_count, yytext);}
"double" {fprintf(tokenout,"<DOUBLE> "); fprintf(logout,"Line No. %d: Token <DOUBLE> Lexeme %s found\n", line_count, yytext);}
"void" {fprintf(tokenout,"<VOID> "); fprintf(logout,"Line No. %d: Token <VOID> Lexeme %s found\n", line_count, yytext);}
"return" {fprintf(tokenout,"<RETURN> "); fprintf(logout,"Line No. %d: Token <RETURN> Lexeme %s found\n", line_count, yytext);}
"switch" {fprintf(tokenout,"<SWITCH> "); fprintf(logout,"Line No. %d: Token <SWITCH> Lexeme %s found\n", line_count, yytext);}
"case" {fprintf(tokenout,"<CASE> "); fprintf(logout,"Line No. %d: Token <CASE> Lexeme %s found\n", line_count, yytext);}
"default" {fprintf(tokenout,"<DEFAULT> "); fprintf(logout,"Line No. %d: Token <DEFAULT> Lexeme %s found\n", line_count, yytext);}
"continue" {fprintf(tokenout,"<CONTINUE> "); fprintf(logout,"Line No. %d: Token <CONTINUE> Lexeme %s found\n", line_count, yytext);}
"goto" {fprintf(tokenout,"<GOTO> "); fprintf(logout,"Line No. %d: Token <GOTO> Lexeme %s found\n", line_count, yytext);}
"long" {fprintf(tokenout,"<LONG> "); fprintf(logout,"Line No. %d: Token <LONG> Lexeme %s found\n", line_count, yytext);}
"short" {fprintf(tokenout,"<SHORT> "); fprintf(logout,"Line No. %d: Token <SHORT> Lexeme %s found\n", line_count, yytext);}
"static" {fprintf(tokenout,"<STATIC> "); fprintf(logout,"Line No. %d: Token <STATIC> Lexeme %s found\n", line_count, yytext);}
"unsigned" {fprintf(tokenout,"<UNSIGNED> "); fprintf(logout,"Line No. %d: Token <UNSIGNED> Lexeme %s found\n", line_count, yytext);}
"++"|"--" {fprintf(tokenout,"<INCOP,%s> ",yytext );fprintf(logout,"Line No. %d: Token <INCOP,%s> Lexeme %s found\n", line_count, yytext);}
"+"|"-" {fprintf(tokenout,"<ADDOP,%s> ",yytext);fprintf(logout,"Line No. %d: Token <ADDOP> Lexeme %s found\n",line_count,yytext);}
"*"|"/"|"%" {fprintf(tokenout,"<MULOP,%s> ",yytext);fprintf(logout,"Line No. %d: Token <MULOP> Lexeme %s found\n",line_count,yytext);}
"<="|"<"|">="|">"|"=="|"!=" {fprintf(tokenout,"<RELOP,%s> ",yytext);fprintf(logout,"Line No. %d: Token <RELOP> Lexeme %s found\n",line_count,yytext);}
"=" {fprintf(tokenout,"<ASSIGNOP,%s> ",yytext);fprintf(logout,"Line No. %d: Token <ASSIGNOP> Lexeme %s found\n",line_count,yytext);}
"&&"|"||" {fprintf(tokenout,"<LOGICOP,%s> ",yytext);fprintf(logout,"Line No. %d: Token <LOGICOP> Lexeme %s found\n",line_count,yytext);}
"!" {fprintf(tokenout,"<NOT,%s> ",yytext);fprintf(logout,"Line No. %d: Token <NOT> Lexeme %s found\n",line_count,yytext);}
"(" {fprintf(tokenout,"<LPAREN,%s> ",yytext);fprintf(logout,"Line No. %d: Token <LPAREN> Lexeme %s found\n",line_count,yytext);}
")" {fprintf(tokenout,"<RPAREN,%s> ",yytext);fprintf(logout,"Line No. %d: Token <RPAREN> Lexeme %s found\n",line_count,yytext);}
"[" {fprintf(tokenout,"<LTHIRD,%s> ",yytext);fprintf(logout,"Line No. %d: Token <LTHIRD> Lexeme %s found\n",line_count,yytext);}
"]" {fprintf(tokenout,"<RTHIRD,%s> ",yytext);fprintf(logout,"Line No. %d: Token <RTHIRD> Lexeme %s found\n",line_count,yytext);}
"{" {fprintf(tokenout,"<LCURL,%s> ",yytext);fprintf(logout,"Line No. %d: Token <LCURL> Lexeme %s found\n",line_count,yytext);st.enter_scope();}
"}" {fprintf(tokenout,"<RCURL,%s> ",yytext);fprintf(logout,"Line No. %d: Token <RCURL> Lexeme %s found\n",line_count,yytext);st.exit_scope();}
"," {fprintf(tokenout,"<COMMA,%s> ",yytext);fprintf(logout,"Line No. %d: Token <COMMA> Lexeme %s found\n",line_count,yytext);}
";" {fprintf(tokenout,"<SEMICOLON,%s> ",yytext);fprintf(logout,"Line No. %d: Token <SEMICOLON> Lexeme %s found\n",line_count,yytext);}
[a-zA-Z_][a-zA-Z0-9_]* {fprintf(tokenout,"<ID,%s> ",yytext);fprintf(logout,"Line No. %d: Token <ID> Lexeme %s found\n",line_count,yytext); string args[] = {string(yytext), "ID"};
        if (st.insert(args, 2)) {
            st.print_symbol_table();
        }}
[0-9]+ {fprintf(tokenout,"<CONST_INT,%s> ",yytext);fprintf(logout,"Line No. %d: Token <CONST_INT> Lexeme %s found\n",line_count,yytext); string args[] = {string(yytext), "CONST_INT"};
        if (st.insert(args, 2)) {
            st.print_symbol_table();
        }}
([0-9]*\.[0-9]+|[0-9]+\.)([eE][+-]?[0-9]+)?|[0-9]+[eE][+-]?[0-9]+ {fprintf(tokenout,"<CONST_FLOAT,%s> ",yytext);fprintf(logout,"Line No. %d: Token <CONST_FLOAT> Lexeme %s found\n",line_count,yytext); string args[] = {string(yytext), "CONST_FLOAT"};
        if (st.insert(args, 2)) {
            st.print_symbol_table();
        }}
'([^'\n\\]|\\[nt\\'afrbv0])' {                                                                    
        char actual_char;                                                                             
        if (yytext[1] == '\\') {                                                                      
            // It's an escape sequence                                                                
            switch(yytext[2]) {                                                                       
                case 'n': actual_char = '\n'; break;                                                  
                case 't': actual_char = '\t'; break;                                                  
                case '\\': actual_char = '\\'; break;                                                 
                case '\'': actual_char = '\''; break;                                                 
                case 'a': actual_char = '\a'; break;                                                  
                case 'f': actual_char = '\f'; break;                                                  
                case 'r': actual_char = '\r'; break;                                                  
                case 'b': actual_char = '\b'; break;                                                  
                case 'v': actual_char = '\v'; break;                                                  
                case '0': actual_char = '\0'; break;                                                  
            }                                                                                         
        } else {                                                                                      
            // It's a normal character like 'a'                                                       
            actual_char = yytext[1];                                                                  
        }                                                                                             
  
        fprintf(tokenout, "<CONST_CHAR,%c> ", actual_char);
        logout << "Line No. " << line_count << ": Token <CONST_CHAR> Lexeme " << yytext << " found\n";
        
        // Convert character to string for insertion
        std::string char_str(1, actual_char);
        std::string args[] = {char_str, "CONST_CHAR"};
        if (st.insert(args, 2)) {
            st.print_symbol_table();
        }
    }
%%

int main(int argc, char* argv[]){
    FILE* fp;
    streambuf *cout_buf = cout.rdbuf();
    cout.rdbuf(logout.rdbuf());
    if(argc!=2){
        printf("Usage: %s <filename>\n", argv[0]);
        return 1;
    }

    fp=fopen(argv[1],"r");
    tokenout=fopen("2205048_token.txt","w");
    logout.open("2205048_log.txt");
    if(fp==NULL){
        printf("Error opening the file\n");
        return 1;
    }
    yyin=fp;
    st.enter_scope();
    yylex();

    fclose(fp);
    fclose(tokenout);
    
    
    return 0;
}
