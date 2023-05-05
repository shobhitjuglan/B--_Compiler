%{
    #include <stdio.h>
    #include <string.h>
    #define YYSTYPE char * // important to convert yylval's value to allow string types also
    extern FILE *yyin;
    int yylex(void);
    void yyerror();
%}
%token ADDR KEYWORD EXPRESSION

%left '+''-'
%left '*''/'
%left UNARYMINUS
%left '^'
%left '('')'
%right '=' NOTEQUAL '<' '>' 'LESSTHANEQ''GREATERTHANEQ'

%%

stmt: 
    |ADDR keyexpr
        
keyexpr:
    |KEYWORD EXPRESSION
    {
        if(!strcmp($1,"END")) {printf("END!\n");}
        else if(!strcmp($1,"STOP")) {printf("STOP!\n");}
        else if(!strcmp($1,"DATA")) {printf("DATA!\n");}
        else if(!strcmp($1,"DEF")) {}
        else if(!strcmp($1,"DIM")) {}
        else if(!strcmp($1,"FOR")) {}
        else if(!strcmp($1,"GOSUB")) {}
        else if(!strcmp($1,"IF")) {}
        else if(!strcmp($1,"LET")) {}
        else if(!strcmp($1,"INPUT")) {}
        else if(!strcmp($1,"PRINT")) {}
        else if(!strcmp($1,"REM")) {}
        else if(!strcmp($1,"RETURN")) {} 
        printf("%s\n",$2);
    };

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