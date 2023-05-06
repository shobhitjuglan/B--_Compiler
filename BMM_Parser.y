%{
    #include <stdio.h>
    #include<stdlib.h>
    #include <string.h>
    #define YYSTYPE char * // important to convert yylval's value to allow string types also
    extern FILE *yyin;
    int yylex(void);
    void yyerror();
    int intx;
    float floatx;
    double doublex;
    char* stringx;
    int f;
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
    | returntomain {printf("This is returntomain\n");}
    | stop {printf("This is stop\n");}
    | let {printf("Let set\n");}
    | inputvar {printf("Input put\n");}
    | gotoline
    | endprog
    | {printf("Wrong Command Given"); exit(0);}
    ;
commentrem:
    REM ignoreline {printf("Rem found!\n");}  
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
        printf("stop hit\n"); 
        exit(0);
    }
    ;
endprog: 
    END 
    {
        printf("end hit\n"); 
        exit(0);
    }
    ;
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
varint: VARINT {printf("Var = Var");}
    | FLOAT {printf("Error! Unmatching Type!\n"); exit(0);}
    | VARFLOAT {printf("Error! Unmatching Type!\n"); exit(0);}
    | STRING {printf("Error! Unmatching Type!\n"); exit(0);}
    | VARSTRING {printf("Error! Unmatching Type!\n"); exit(0);}
    | DOUBLE {printf("Error! Unmatching Type!\n"); exit(0);}
    | VARDOUBLE {printf("Error! Unmatching Type!\n"); exit(0);}
    ;
varfloat: VARFLOAT {printf("Var = Var");}
    | NUM {printf("Error! Unmatching Type!\n"); exit(0);}
    | VARINT {printf("Error! Unmatching Type!\n"); exit(0);}
    | STRING {printf("Error! Unmatching Type!\n"); exit(0);}
    | VARSTRING {printf("Error! Unmatching Type!\n"); exit(0);}
    | DOUBLE {printf("Error! Unmatching Type!\n"); exit(0);}
    | VARDOUBLE {printf("Error! Unmatching Type!\n"); exit(0);}
    ;
varstring: VARSTRING {printf("Var = Var");}
    | FLOAT {printf("Error! Unmatching Type!\n"); exit(0);}
    | VARFLOAT {printf("Error! Unmatching Type!\n"); exit(0);}
    | NUM {printf("Error! Unmatching Type!\n"); exit(0);}
    | VARINT {printf("Error! Unmatching Type!\n"); exit(0);}
    | DOUBLE {printf("Error! Unmatching Type!\n"); exit(0);}
    | VARDOUBLE {printf("Error! Unmatching Type!\n"); exit(0);}
    ;
vardouble: VARDOUBLE {printf("Var = Var");}
    | FLOAT {printf("Error! Unmatching Type!\n"); exit(0);}
    | VARFLOAT {printf("Error! Unmatching Type!\n"); exit(0);}
    | STRING {printf("Error! Unmatching Type!\n"); exit(0);}
    | VARSTRING {printf("Error! Unmatching Type!\n"); exit(0);}
    | NUM {printf("Error! Unmatching Type!\n"); exit(0);}
    | VARINT {printf("Error! Unmatching Type!\n"); exit(0);}
    ;
inputvar:
    INPUT {printf("Input something\n");} var
    ;
var: VARINT {f=scanf("%d", &intx);}
    | VARFLOAT {f=scanf("%f", &floatx);}
    | VARDOUBLE {f=scanf("%lf", &doublex);}
    | VARSTRING {f=scanf("%s", &stringx);}
    ;
gotoline:
    GOSUB NUM {printf("Gosub found!\n");} //Push RA to stack, which is next in line to this stmt after jumping to the given address
    | GOTO NUM {printf("Goto found!\n");} //Just jump to this address 
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
