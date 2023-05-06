%{
    #include <stdio.h>
    #include<stdlib.h>
    #include <string.h>
    #define YYSTYPE char * // important to convert yylval's value to allow string types also
    extern FILE *yyin;
    int yylex(void);
    void yyerror();
%}
%token NUM FLOAT DATA DEF DIM END FOR TO STEP NEXT GOSUB GOTO IF THEN LET INPUT PRINT REM RETURN STOP NOTEQUAL SIZE BEQ BNE BGE BLE BGT BLT NOT AND OR XOR EQUAL ADD SUB PRO DIV POWER SEMCOM COMMA OPA CPA FUNC VAR STRING PRTEXP IGN EOL 

%%

program:
    program subprogram
subprogram:
    subprogram EOL stmt EOL
    | stmt EOL
    ;
stmt:
    NUM subst
    | subst {perror("Invalid Input!");}
    ;
subst:
    data
    | def
    | dim
    | endprog
    | forloop
    | gotoline
    | ifthen
    | let
    | inputvar
    | print
    | commentrem
    | returntomain
    | stop
    | IGN {perror("Invalid Input!");}
    ;
data:
    data COMMA NUM
    | data COMMA STRING
    | NUM
    | STRING
    ;
def:
    DEF FUNC OPA VAR CPA EQUAL equation
    | DEF FUNC EQUAL equation
    ;
dim:
    dim COMMA VAR OPA NUM CPA
    | dim COMMA VAR OPA NUM COMMA NUM CPA
    | VAR OPA NUM CPA
    | VAR OPA NUM COMMA NUM CPA
    ;
endprog:
    END
    ;
forloop:
    FOR VAR EQUAL NUM TO NUM STEP NUM subprogram NEXT NUM
    ;
gotoline:
    GOSUB NUM //Push RA to stack, which is next in line to this stmt after jumping to the given address
    | GOTO NUM //Just jump to this address
    ;
ifthen:
    IF equation THEN NUM //Jump to new NUM which is the address else ignore then
    ;
let:
    LET VAR EQUAL VAR
    | LET VAR EQUAL NUM
    | LET VAR EQUAL FLOAT
    ;
inputvar:
    INPUT VAR
    ;
print:
    PRINT line
    ;
line: 
    equation
    | PRTEXP
    | line COMMA equation
    | line COMMA PRTEXP
    ;
equation:
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
    | VAR
commentrem:
    REM ignoreline 
    ;
ignoreline:
    IGN
returntomain:
    RETURN //pop RA and goto that return address
    ;
stop:
    STOP //End code here
    ;
  
%%



void yyerror(char *str){
    printf("%s",yylval);
    fprintf(stderr,"Error : %s\n",str);
}

int main(){

    //counting lines in file
    
    char filename[] = "input.txt";
    int num_lines = 0;
    FILE *file = fopen(filename, "r");
    char line[1024];

    if (file) {
        while (fgets(line, sizeof(line), file)) {
            num_lines++;
        }
        fclose(file);
    }

    //counting finished

    
    FILE *fp; int i;
    fp = fopen(filename,"r");
    yyin = fp;
    for(i=0;i<num_lines;i++)
        yyparse();
    return 0;
}