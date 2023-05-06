%{
    #include<stdio.h>
    #include<string.h>
    #include<stdlib.h>
    #include "toptemp.tab.h"
%}

%%

[0-9]+                                   { yylval=atoi(yytext); return NUM; }
[0-9]+\.[0-9]+                           { yylval=atoi(yytext); return FLOAT; }
"DATA"                                   { return DATA;}
"DEF"                                    { return DEF;}
"DIM"                                    { return DIM;}
"END"                                    { return END;}
"FOR"                                    { return FOR;}
"TO"                                     { return TO;}
"STEP"                                   { return STEP;}
"NEXT"                                   { return NEXT;}
"GOSUB"                                  { return GOSUB;}
"GOTO"                                   { return GOTO;}
"IF"                                     { return IF;}
"THEN"                                   { return THEN;}
"LET"                                    { return LET;}
"INPUT"                                  { return INPUT;}
"PRINT"                                  { return PRINT;}
"REM"                                    { return REM;}
"RETURN"                                 { return RETURN;}
"STOP"                                   { return STOP;}
"=="                                     { return BEQ; } 
"<>"                                     { return BNE; } 
">="                                     { return BGE; } 
"<="                                     { return BLE; } 
">"                                      { return BGT; } 
"<"                                      { return BLT; } 
"NOT"                                    { return NOT; } 
"AND"                                    { return AND; } 
"OR"                                     { return OR; } 
"XOR"                                    { return XOR; } 
"="                                      { return EQUAL; }
"+"                                      { return ADD; }
"-"                                      { return SUB; }
"*"                                      { return PRO; }
"/"                                      { return DIV; }
"^"                                      { return POWER; }
";"                                      { return SEMCOM; }
","                                      { return COMMA; }
"("                                      { return OPA; }
")"                                      { return CPA; }
FN[A-Z]\([A-Z]\)?                         { return FUNC; }
[A-Z][0-9]?[\#|\$|\!]?                   { return VAR;}
\"[A-Z0-9]+\"                            { yytext[strlen(yytext)-1]='\0'; yytext+=1; yylval = strdup(yytext); return STRING; }
\"[A-Z0-9\s\!\+\-\*\/]+\"                { yytext[strlen(yytext)-1]='\0'; yytext+=1; yylval = strdup(yytext); return PRTEXP; }
[A-Z0-9\s\!\+\-\*\/]*                    { yylval = strdup(yytext); return IGN; }
[\n]                                     { return EOL;}
[ \t]                                    ;

%%

int yywrap(){
    return 1;
}