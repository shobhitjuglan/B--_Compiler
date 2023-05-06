%{
    #include <stdio.h>
    #include<stdlib.h>
    #include <string.h>
    #define YYSTYPE char * // important to convert yylval's value to allow string types also
    extern FILE *yyin;
    int yylex(void);
    void yyerror();
    int addr_arr[500];
%}
%token NUM FLOAT DATA DEF DIM END FOR TO STEP NEXT GOSUB GOTO IF THEN LET INPUT PRINT REM RETURN STOP NOTEQUAL SIZE BEQ BNE BGE BLE BGT BLT NOT AND OR XOR EQUAL ADD SUB PRO DIV POWER SEMCOM COMMA OPA CPA FUNC VAR STRING PRTEXP IGN EOL 

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
    commentrem {printf("This is commentrem\n");}
    | returntomain {printf("This is returntomain\n");}
    | stop {printf("This is stop\n");}
    | {printf("Wrong Command Given"); exit(0);}
    ;
commentrem:
    REM ignoreline
    {
        printf("Here comes a REM line\n");
    } 
    ;
ignoreline:
    IGN
    {
        printf("%s This was ignored\n",$1);
    }
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
    }
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

    
    FILE *fp; 
    fp = fopen(filename,"r");
    yyin = fp;
    for(int i=0;i<num_lines;i++)
        yyparse();

    return 0;
}