%{
#include<stdio.h>
// #include <string.h>
#include "BMM_Parser.tab.h"
// void yyerror();
%}

%%

[0-9]+         { yylval=atoi(yytext); return ADDR; }
[A-Z]+          { yylval = strdup(yytext); return KEYWORD;}
[A-Z0-9\s]+            { yylval = strdup(yytext); return EXPRESSION;}
[ \t]            ;


%%

int yywrap(){
    return 1;
}