%{
#include<stdio.h>
#include "BMM_Parser.tab.h"
%}

%%

[0-9]+         { yylval=atoi(yytext); return INTEGER; }
[-+\n]           return *yytext;
[ \t]            ;
.                yyerror("Invalid Character");

%%

int yywrap(){
    return 0;
}