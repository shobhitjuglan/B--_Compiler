%{
    #include <stdio.h>
    #include<stdlib.h>
    #include <string.h>
    #define YYSTYPE char * // important to convert yylval's value to allow string types also
    extern FILE *yyin;
    int yylex(void);
    void yyerror();
%}

%token NUM FLOAT DOUBLE ERROR DATA DEF DIM END FOR TO STEP NEXT GOSUB GOTO IF THEN LET INPUT PRINT REM RETURN STOP NOTEQUAL SIZE BEQ BNE BGE BLE BGT BLT NOT AND OR XOR EQUAL ADD SUB PRO DIV POWER SEMCOM COMMA OPA CPA FUNC VARINT VARFLOAT VARSTRING VARDOUBLE STRING PRTEXP IGN EOL 

%%

program:
    subprogram {exit(0);}
subprogram:
    stmt subprogram
    |stmt 
    ;
stmt: 
    NUM END EOL {printf("Error : END not at the end\n"); exit(0);}
    | NUM END {printf("========================EXITING================================"); exit(0);}
    | NUM subst EOL
    | NUM subst {printf("Program without END! Error!\n");exit(0);}
    | subst EOL {printf("Error: No Address given\n");exit(0);}
    | subst {printf("Error: No Address given\n");exit(0);}
    ;
subst:
    {printf("Comment!\n");} commentrem
    | data {printf("Data added\n");}
    | returntomain
    | stop
    | let
    | inputvar
    | gotoline
    | {printf("Defining a function!\n");} def
    | {printf("Branch if!\n");} ifthen
    | {printf("Print statement!\n");} print
    | dim
    | {printf("Loop detected!\n");} forloop
    | {printf("Wrong Command Given"); exit(0);}
    ;
commentrem:
    REM ignoreline
    ;
def:
    DEF FUNC VARINT EQUAL equation
    | DEF FUNC VARFLOAT EQUAL equation
    | DEF FUNC VARDOUBLE EQUAL equation
    | DEF FUNC EQUAL equation
    ;
ifthen:
    IF logicalequation THEN NUM
    ;
print:
    PRINT line
    ;
line:
    logicalequation
    | STRING
    | line COMMA logicalequation
    | line COMMA STRING
    ;
logicalequation:
    inequation
    | NOT logicalequation
    | logicalequation AND inequation
    | logicalequation OR inequation
    | logicalequation XOR inequation
    ;
inequation:
    equation
    | equation BEQ equation
    | equation BNE equation
    | equation BGE equation
    | equation BLE equation
    | equation BGT equation
    | equation BLT equation
    ;
equation: {printf("Encountered an equation!\n");}
    factor
    | equation ADD factor
    | equation SUB factor
    ;
factor:
    term
    | factor PRO term
    | factor DIV term
    ;
term:
    num 
    | SUB num
    ;
num:
    number
    | number POWER number
    ;
number:
    value
    | OPA equation CPA
    ;
value:
    NUM 
    | VARINT 
    | VARFLOAT 
    | VARDOUBLE 
    ;
ignoreline:
    IGN ignoreline
    |
    ;
returntomain:
    RETURN    
    {
        printf("Return hit\n");
    }
    ;
stop: 
    STOP 
    {
        printf("Stop hit\n");
        exit(0);
    }
    ;
dim:
    DIM dimb {printf("DIM run!\n");}
    ;
dimb: dimb COMMA VARINT OPA NUM CPA
    | dimb COMMA VARINT OPA NUM COMMA NUM CPA
    | VARINT OPA NUM CPA
    | VARINT OPA NUM COMMA NUM CPA
    ;
let:
    LET VARINT EQUAL NUM {printf("Let Var = num\n")}
    | LET VARFLOAT EQUAL FLOAT {printf("Let Var = float\n")}
    | LET VARSTRING EQUAL STRING {printf("Let Var = string\n")}
    | LET VARDOUBLE EQUAL DOUBLE {printf("Let Var = double\n")}
    | LET leterror
    ;
leterror: VARINT EQUAL varint 
    | VARFLOAT EQUAL varfloat 
    | VARSTRING EQUAL varstring 
    | VARDOUBLE EQUAL vardouble 
    ;
varint: VARINT {printf("Let Varint = Varint");}
    | FLOAT {printf("Error! Unmatching Type!\n"); exit(0);}
    | VARFLOAT {printf("Error! Unmatching Type!\n"); exit(0);}
    | STRING {printf("Error! Unmatching Type!\n"); exit(0);}
    | VARSTRING {printf("Error! Unmatching Type!\n"); exit(0);}
    | DOUBLE {printf("Error! Unmatching Type!\n"); exit(0);}
    | VARDOUBLE {printf("Error! Unmatching Type!\n"); exit(0);}
    ;
varfloat: VARFLOAT {printf("Let Varfloat = Varfloat");}
    | NUM {printf("Error! Unmatching Type!\n"); exit(0);}
    | VARINT {printf("Error! Unmatching Type!\n"); exit(0);}
    | STRING {printf("Error! Unmatching Type!\n"); exit(0);}
    | VARSTRING {printf("Error! Unmatching Type!\n"); exit(0);}
    | DOUBLE {printf("Error! Unmatching Type!\n"); exit(0);}
    | VARDOUBLE {printf("Error! Unmatching Type!\n"); exit(0);}
    ;
varstring: VARSTRING {printf("Let Varstring = Varstring");}
    | FLOAT {printf("Error! Unmatching Type!\n"); exit(0);}
    | VARFLOAT {printf("Error! Unmatching Type!\n"); exit(0);}
    | NUM {printf("Error! Unmatching Type!\n"); exit(0);}
    | VARINT {printf("Error! Unmatching Type!\n"); exit(0);}
    | DOUBLE {printf("Error! Unmatching Type!\n"); exit(0);}
    | VARDOUBLE {printf("Error! Unmatching Type!\n"); exit(0);}
    ;
vardouble: VARDOUBLE {printf("Let Vardouble = Vardouble");}
    | FLOAT {printf("Error! Unmatching Type!\n"); exit(0);}
    | VARFLOAT {printf("Error! Unmatching Type!\n"); exit(0);}
    | STRING {printf("Error! Unmatching Type!\n"); exit(0);}
    | VARSTRING {printf("Error! Unmatching Type!\n"); exit(0);}
    | NUM {printf("Error! Unmatching Type!\n"); exit(0);}
    | VARINT {printf("Error! Unmatching Type!\n"); exit(0);}
    ;
inputvar:
    INPUT varb
    ;
varb: varb COMMA var
    | var
    ;
var: VARINT {printf("Int Input found!\n");}
    | VARFLOAT {printf("Float Input found!\n");}
    | VARDOUBLE {printf("Double Input found!\n");}
    | VARSTRING {printf("String Input found!\n");}
    ;
gotoline:
    GOSUB NUM {printf("Gosub found!\n");} //Push RA to stack, which is next in line to this stmt after jumping to the given address
    | GOTO NUM {printf("Goto found!\n");} //Just jump to this address 
    ;
data:
    data COMMA NUM
    | data COMMA STRING
    | data COMMA FLOAT
    | data COMMA DOUBLE
    | DATA NUM
    | DATA STRING
    | DATA FLOAT
    | DATA DOUBLE
    ;
forloop:
    FOR VARINT EQUAL NUM TO NUM STEP NUM EOL subcode NUM NEXT VARINT
    | FOR VARINT EQUAL NUM TO NUM EOL subcode NUM NEXT VARINT
    | FOR VARINT EQUAL NUM TO NUM EOL NUM NEXT VARINT
    | FOR VARINT EQUAL NUM TO NUM STEP NUM EOL NUM NEXT VARINT
    ;
subcode: subcode stmt
    | stmt
    ;
%%


void yyerror(char *str){
    printf("%s",yylval);
    fprintf(stderr,"Error : %s\n",str);
}

int main(){

    //counting lines in file
    
    char filename[] = "input.txt";
    FILE *fp; int i; int temp= -1;
    fp = fopen(filename,"r");
    yyin = fp;
    yyparse();
    return 0;
}