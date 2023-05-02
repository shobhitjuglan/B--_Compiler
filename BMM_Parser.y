%{
    #include<stdio.h>
    int yylex(void);
    void yyerror();
%}
%token INTEGER

%%

program:
        program expr '\n' {printf("%d\n",$2); }
        |
        ;
expr:
        INTEGER         {$$=$1;}
        |       
        expr '+' expr   {$$=$1+$3;}
        |
        expr '-' expr   {$$=$1-$3;}
        ;


%%



void yyerror(char *str){
    fprintf(stderr,"Error : %s\n",str);
}

int main(){
    yyparse();
    return 0;
}