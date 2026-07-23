%option noyywrap

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
  string str_buf = "";     // Will hold the processed string (with real newlines)                   
  string str_lexeme = "";  // Will hold the raw exact text from the file                            
  int string_start_line = 0;
  int error_count = 0;
%}
%x STRING_STATE  
%x SINGLE_COMMENT_STATE                                                                           
%x MULTI_COMMENT_STATE                                                                                   
%%
[ \t\v\r]+ {}
\n {line_count++;}
"if" {fprintf(tokenout,"<IF> "); logout << "Line no " << line_count << ": Token <IF> Lexeme " << yytext << " found\n\n";}
"else" {fprintf(tokenout,"<ELSE> "); logout << "Line no " << line_count << ": Token <ELSE> Lexeme " << yytext << " found\n\n";}
"for" {fprintf(tokenout,"<FOR> "); logout << "Line no " << line_count << ": Token <FOR> Lexeme " << yytext << " found\n\n";}
"while" {fprintf(tokenout,"<WHILE> "); logout << "Line no " << line_count << ": Token <WHILE> Lexeme " << yytext << " found\n\n";}
"do" {fprintf(tokenout,"<DO> "); logout << "Line no " << line_count << ": Token <DO> Lexeme " << yytext << " found\n\n";}
"break" {fprintf(tokenout,"<BREAK> "); logout << "Line no " << line_count << ": Token <BREAK> Lexeme " << yytext << " found\n\n";}
"int" {fprintf(tokenout,"<INT> "); logout << "Line no " << line_count << ": Token <INT> Lexeme " << yytext << " found\n\n";}
"char" {fprintf(tokenout,"<CHAR> "); logout << "Line no " << line_count << ": Token <CHAR> Lexeme " << yytext << " found\n\n";}
"float" {fprintf(tokenout,"<FLOAT> "); logout << "Line no " << line_count << ": Token <FLOAT> Lexeme " << yytext << " found\n\n";}
"double" {fprintf(tokenout,"<DOUBLE> "); logout << "Line no " << line_count << ": Token <DOUBLE> Lexeme " << yytext << " found\n\n";}
"void" {fprintf(tokenout,"<VOID> "); logout << "Line no " << line_count << ": Token <VOID> Lexeme " << yytext << " found\n\n";}
"return" {fprintf(tokenout,"<RETURN> "); logout << "Line no " << line_count << ": Token <RETURN> Lexeme " << yytext << " found\n\n";}
"switch" {fprintf(tokenout,"<SWITCH> "); logout << "Line no " << line_count << ": Token <SWITCH> Lexeme " << yytext << " found\n\n";}
"case" {fprintf(tokenout,"<CASE> "); logout << "Line no " << line_count << ": Token <CASE> Lexeme " << yytext << " found\n\n";}
"default" {fprintf(tokenout,"<DEFAULT> "); logout << "Line no " << line_count << ": Token <DEFAULT> Lexeme " << yytext << " found\n\n";}
"continue" {fprintf(tokenout,"<CONTINUE> "); logout << "Line no " << line_count << ": Token <CONTINUE> Lexeme " << yytext << " found\n\n";}
"goto" {fprintf(tokenout,"<GOTO> "); logout << "Line no " << line_count << ": Token <GOTO> Lexeme " << yytext << " found\n\n";}
"long" {fprintf(tokenout,"<LONG> "); logout << "Line no " << line_count << ": Token <LONG> Lexeme " << yytext << " found\n\n";}
"short" {fprintf(tokenout,"<SHORT> "); logout << "Line no " << line_count << ": Token <SHORT> Lexeme " << yytext << " found\n\n";}
"static" {fprintf(tokenout,"<STATIC> "); logout << "Line no " << line_count << ": Token <STATIC> Lexeme " << yytext << " found\n\n";}
"unsigned" {fprintf(tokenout,"<UNSIGNED> "); logout << "Line no " << line_count << ": Token <UNSIGNED> Lexeme " << yytext << " found\n\n";}
"++"|"--" {fprintf(tokenout,"<INCOP, %s> ",yytext ); logout << "Line no " << line_count << ": Token <INCOP> Lexeme " << yytext << " found\n\n";}
"+"|"-" {fprintf(tokenout,"<ADDOP, %s> ",yytext); logout << "Line no " << line_count << ": Token <ADDOP> Lexeme " << yytext << " found\n\n";}
"*"|"/"|"%" {fprintf(tokenout,"<MULOP, %s> ",yytext); logout << "Line no " << line_count << ": Token <MULOP> Lexeme " << yytext << " found\n\n";}
"<="|"<"|">="|">"|"=="|"!=" {fprintf(tokenout,"<RELOP, %s> ",yytext); logout << "Line no " << line_count << ": Token <RELOP> Lexeme " << yytext << " found\n\n";}
"=" {fprintf(tokenout,"<ASSIGNOP, %s> ",yytext); logout << "Line no " << line_count << ": Token <ASSIGNOP> Lexeme " << yytext << " found\n\n";}
"&&"|"||" {fprintf(tokenout,"<LOGICOP, %s> ",yytext); logout << "Line no " << line_count << ": Token <LOGICOP> Lexeme " << yytext << " found\n\n";}
"!" {fprintf(tokenout,"<NOT, %s> ",yytext); logout << "Line no " << line_count << ": Token <NOT> Lexeme " << yytext << " found\n\n";}
"(" {fprintf(tokenout,"<LPAREN, %s> ",yytext); logout << "Line no " << line_count << ": Token <LPAREN> Lexeme " << yytext << " found\n\n";}
")" {fprintf(tokenout,"<RPAREN, %s> ",yytext); logout << "Line no " << line_count << ": Token <RPAREN> Lexeme " << yytext << " found\n\n";}
"[" {fprintf(tokenout,"<LTHIRD, %s> ",yytext); logout << "Line no " << line_count << ": Token <LTHIRD> Lexeme " << yytext << " found\n\n";}
"]" {fprintf(tokenout,"<RTHIRD, %s> ",yytext); logout << "Line no " << line_count << ": Token <RTHIRD> Lexeme " << yytext << " found\n\n";}
"{" {fprintf(tokenout,"<LCURL, %s> ",yytext); logout << "Line no " << line_count << ": Token <LCURL> Lexeme " << yytext << " found\n\n"; st.enter_scope();}
"}" {fprintf(tokenout,"<RCURL, %s> ",yytext); logout << "Line no " << line_count << ": Token <RCURL> Lexeme " << yytext << " found\n\n"; st.exit_scope();}
"," {fprintf(tokenout,"<COMMA, %s> ",yytext); logout << "Line no " << line_count << ": Token <COMMA> Lexeme " << yytext << " found\n\n";}
";" {fprintf(tokenout,"<SEMICOLON, %s> ",yytext); logout << "Line no " << line_count << ": Token <SEMICOLON> Lexeme " << yytext << " found\n\n";}
[a-zA-Z_][a-zA-Z0-9_]* {fprintf(tokenout,"<ID, %s> ",yytext); logout << "Line no " << line_count << ": Token <ID> Lexeme " << yytext << " found\n\n"; string args[] = {string(yytext), "ID"};
        if (st.insert(args, 2)) {
            st.print_symbol_table();
        }}
[0-9]+ {fprintf(tokenout,"<CONST_INT, %s> ",yytext); logout << "Line no " << line_count << ": Token <CONST_INT> Lexeme " << yytext << " found\n\n"; string args[] = {string(yytext), "CONST_INT"};
        if (st.insert(args, 2)) {
            st.print_symbol_table();
        }}
([0-9]*\.[0-9]+|[0-9]+\.)([eE][+-]?[0-9]+)?|[0-9]+[eE][+-]?[0-9]+ {fprintf(tokenout,"<CONST_FLOAT, %s> ",yytext); logout << "Line no " << line_count << ": Token <CONST_FLOAT> Lexeme " << yytext << " found\n\n"; string args[] = {string(yytext), "CONST_FLOAT"};
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
  
        fprintf(tokenout, "<CONST_CHAR, %c> ", actual_char);
        logout << "Line no " << line_count << ": Token <CONST_CHAR> Lexeme " << yytext << " found --> <CONST_CHAR, " << actual_char << ">\n\n";
        
        // Convert character to string for insertion
        std::string args[] = {string(yytext), "CONST_CHAR"};
        if (st.insert(args, 2)) {
            st.print_symbol_table();
        }
    }
\" {                                                                                              
        BEGIN(STRING_STATE); // Switch to STRING_STATE                                                
        str_buf = "";        // Clear buffers                                                         
        str_lexeme = "\"";                                                                            
        string_start_line = line_count;                                                               
    }
<STRING_STATE>\" {                                                                                
        str_lexeme += "\"";                                                                           
        // We reached the end of the string!                                                          
        fprintf(tokenout, "<STRING, %s> ", str_buf.c_str());                                           
        logout << "Line no " << line_count << ": Token <STRING> Lexeme " << str_lexeme << " found --> <STRING, " << str_buf << ">\n\n";                                                                                           
        BEGIN(INITIAL); // Switch back to normal state                                                
    }
<STRING_STATE>\\[nt\\'"afrbv0] {                                                                   
        str_lexeme += yytext;                                                                         
        switch (yytext[1]) { 
    case 'n': str_buf += '\n'; break; 
    case 't': str_buf += '\t'; break; 
    case '\\': str_buf += '\\'; break; 
    case '\'': str_buf += '\''; break; 
    case '"': str_buf += '"'; break; 
    case 'a': str_buf += '\a'; break; 
    case 'f': str_buf += '\f'; break; 
    case 'r': str_buf += '\r'; break; 
    case 'b': str_buf += '\b'; break; 
    case 'v': str_buf += '\v'; break; 
    case '0': str_buf += '\0'; break; 
}                                     
    } 
<STRING_STATE>\\\r?\n {                                                                           
        // This is a line continuation (a backslash followed by a newline)                            
        str_lexeme += yytext;                                                                         
        line_count++;                                                                                 
        // Notice we do NOT add anything to str_buf because the \ ignores the newline                 
    }          
<STRING_STATE>. {
        // Any other normal character
        str_lexeme += yytext;
        str_buf += yytext;
    }
"//" {                                                                                            
        BEGIN(SINGLE_COMMENT_STATE);                                                                  
        str_lexeme = "//";                                                                            
        string_start_line = line_count;                                                               
    }                                                                                                 
                                                                                                       
<SINGLE_COMMENT_STATE>\\\r?\n {                                                                   
        // A backslash at the end of the line continues the comment                                   
        str_lexeme += yytext;                                                                         
        line_count++;                                                                                 
    }                                                                                                 
                                                                                                       
<SINGLE_COMMENT_STATE>\n {                                                                        
        // A normal newline ends the single-line comment                                              
        logout << "Line no " << line_count << ": Token <COMMENT> Lexeme " << str_lexeme << " found\n\n";                                                                                           
        line_count++;                                                                                 
        BEGIN(INITIAL);                                                                               
    }                                                                                                 
                                                                                                       
<SINGLE_COMMENT_STATE>. {                                                                         
        str_lexeme += yytext;                                                                         
    }
"/*" {                                                                                            
        BEGIN(MULTI_COMMENT_STATE);
        str_lexeme = "/*";
        string_start_line = line_count;
    }
  
<MULTI_COMMENT_STATE>"*/" {
        str_lexeme += "*/";
        logout << "Line no " << line_count << ": Token <COMMENT> Lexeme " << str_lexeme << " found\n\n";
        BEGIN(INITIAL);
    }
  
<MULTI_COMMENT_STATE>\n {
        str_lexeme += yytext;
        line_count++;
    }
  
<MULTI_COMMENT_STATE>. {
        str_lexeme += yytext;
    }
[0-9]*\.[0-9]+(\.[0-9]*)+ {                                                                   
            error_count++;                                                                            
            logout << "Error at line no " << line_count << ": Too many decimal points " << yytext << "\n\n\n";                                                                                           
        }
[0-9]*(\.[0-9]+)?[eE][+-]?[0-9]*\.[0-9]* {                                                    
            error_count++;                                                                            
            logout << "Error at line no " << line_count << ": Ill formed number " << yytext << "\n\n\n";  
        }
[0-9]+[a-zA-Z_][a-zA-Z0-9_]* {                                                                
            error_count++;                                                                            
            logout << "Error at line no " << line_count << ": Invalid prefix on ID or invalid suffix on Number " << yytext << "\n\n";                                                                  
        }
'([^'\n\\]|\\[nt\\'afrbv0])+' {                                                               
            error_count++;                                                                            
            logout << "Error at line no " << line_count << ": Multi character constant error " << yytext << "\n\n\n";                                                                                 
        }               
'' {                                                                                                                                                                    
            error_count++;                                                                                                                                                      
            logout << "Error at line no " << line_count << ": Empty character constant error " << yytext << "\n\n\n";                                                               
        }
'([^'\n\\]|\\[nt\\'afrbv0])* {                                                                                                                                          
            error_count++;                                                                                                                                                      
            logout << "Error at line no " << line_count << ": Unterminated character " << yytext << "\n\n\n";                                                                         
        }
<STRING_STATE>\n {                                                                                                                                                      
            error_count++;                                                                                                                                                      
            logout << "Error at line no " << string_start_line << ": Unterminated string " << str_lexeme << "\n\n";
            line_count++;
            BEGIN(INITIAL);
        }
<STRING_STATE><<EOF>> {
            error_count++;
            logout << "Error at line no " << string_start_line << ": Unterminated string " << str_lexeme << "\n\n";
            BEGIN(INITIAL);
        }
<MULTI_COMMENT_STATE><<EOF>> {
            error_count++;
            logout << "Error at line no " << string_start_line << ": Unterminated comment " << str_lexeme << "\n\n";
            BEGIN(INITIAL);
        }
. {
            error_count++;
            logout << "Error at line no " << line_count << ": Unrecognized character " << yytext << "\n\n";
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
    st.print_symbol_table();

    fclose(fp);
    fclose(tokenout);
    logout << "Total lines: " << line_count << "\n";
    logout << "Total errors: " << error_count << "\n";
    
    return 0;
}
