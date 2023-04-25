%{
    #include<stdio.h>
%}
%token NUMBER TOKHEAT STATE TOKTARGET TOKTEMPERATURE

%%

commands:
        | commands command
command:
        heat_switch
        |
        target_set
        ;
heat_switch:
        TOKHEAT STATE
        {
            printf("\tHeat turned on or off\n");
        }
        ;
target_set:
        TOKTARGET TOKTEMPERATURE NUMBER
        {
            printf("\Temperature set\n");
        }
        ;

%%

void yyerror(const char *str){
    fprintf(stderr,"error : %s\n",str);
}

int yywrap(){
    return 1;
}

int main(){
    yyparse();
    return 0;
}