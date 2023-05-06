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
     stmt subprogram {printf("This is 4\n");}
    |stmt {printf("This is 3\n");}
    ;
stmt: 
    NUM subst EOL {printf("This is stmt with EOL\n");}
    | NUM subst {printf("This is stmt without EOL\n");}
    | subst EOL {printf("Error: No Address given\n");exit(0);}
    | subst {printf("Error: No Address given\n");exit(0);}
    ;
subst:
    commentrem
    | data {printf("Data added\n");}
    | returntomain
    | stop
    | let
    | inputvar
    | gotoline
    | endprog
    | {printf("Wrong Command Given"); exit(0);}
    ;
commentrem:
    REM {printf("Rem found!\n");} ignoreline 
    ;
ignoreline:
    IGN
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
endprog: 
    END 
    {
        printf("End hit\n");
        exit(0); 
    }
    ;
// dim: dim COMMA VARINT OPA NUM CPA
//     | dim COMMA VARINT OPA NUM COMMA NUM CPA
//     | DIM VARINT OPA NUM CPA
//     | DIM VARINT OPA NUM COMMA NUM CPA
//     ;
let:
    LET VARINT EQUAL NUM {printf("Var = num\n")}
    | LET VARFLOAT EQUAL FLOAT {printf("Var = float\n")}
    | LET VARSTRING EQUAL STRING {printf("Var = string\n")}
    | LET VARDOUBLE EQUAL DOUBLE {printf("Var = double\n")}
    | LET leterror
    ;
leterror: VARINT EQUAL varint 
    | VARFLOAT EQUAL varfloat 
    | VARSTRING EQUAL varstring 
    | VARDOUBLE EQUAL vardouble 
    ;
varint: VARINT {printf("Varint = Varint");}
    | FLOAT {printf("Error! Unmatching Type!\n"); exit(0);}
    | VARFLOAT {printf("Error! Unmatching Type!\n"); exit(0);}
    | STRING {printf("Error! Unmatching Type!\n"); exit(0);}
    | VARSTRING {printf("Error! Unmatching Type!\n"); exit(0);}
    | DOUBLE {printf("Error! Unmatching Type!\n"); exit(0);}
    | VARDOUBLE {printf("Error! Unmatching Type!\n"); exit(0);}
    ;
varfloat: VARFLOAT {printf("Varfloat = Varfloat");}
    | NUM {printf("Error! Unmatching Type!\n"); exit(0);}
    | VARINT {printf("Error! Unmatching Type!\n"); exit(0);}
    | STRING {printf("Error! Unmatching Type!\n"); exit(0);}
    | VARSTRING {printf("Error! Unmatching Type!\n"); exit(0);}
    | DOUBLE {printf("Error! Unmatching Type!\n"); exit(0);}
    | VARDOUBLE {printf("Error! Unmatching Type!\n"); exit(0);}
    ;
varstring: VARSTRING {printf("Varstring = Varstring");}
    | FLOAT {printf("Error! Unmatching Type!\n"); exit(0);}
    | VARFLOAT {printf("Error! Unmatching Type!\n"); exit(0);}
    | NUM {printf("Error! Unmatching Type!\n"); exit(0);}
    | VARINT {printf("Error! Unmatching Type!\n"); exit(0);}
    | DOUBLE {printf("Error! Unmatching Type!\n"); exit(0);}
    | VARDOUBLE {printf("Error! Unmatching Type!\n"); exit(0);}
    ;
vardouble: VARDOUBLE {printf("Vardouble = Vardouble");}
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
    data COMMA NUM {printf("%d ", $3);}
    | data COMMA STRING {printf("%s ", $3);}
    | data COMMA FLOAT {printf("%f ", $3);}
    | data COMMA DOUBLE {printf("%lf ", $3);}
    | DATA NUM {printf("%d ", $2);}
    | DATA STRING {printf("%s ", $2);}
    | DATA FLOAT {printf("%f ", $2);}
    | DATA DOUBLE {printf("%lf ", $2);}
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

    if (file){
        while (fgets(line, sizeof(line), file)){
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
