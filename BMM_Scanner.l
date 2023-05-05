%{
#include<stdio.h>
#include "BMM_Parser.tab.h"

%}

%%

[0-9]+         { yylval=atoi(yytext); return ADDR; }
[A-Z]+         { yylval = strdup(yytext); return KEYWORD;}
[A-Z0-9]+     { yylval = strdup(yytext); return EXPRESSION;}
[ \t]          ;
[\n] return 0;

%%

int yywrap(){
    return 1;
}