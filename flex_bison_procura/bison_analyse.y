
%{  
#include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  extern int yylex();
  extern int yyparse();
  extern FILE *yyin;
  void yyerror(const char *s);



  
%}


%define parse.lac full
%define parse.error verbose


%union{
    int integer;
    char* string;
    float real;
    char character;
}
%token SPACE "Espaco em branco"
%token PROCURACAO_PR "Titulo 'Procuração' "
%token EU_PR "Token: 'Eu'"
%token NATURALDE_PR "Token: 'Natural de'"
%token RESI_DOMICI_PR "Token: 'Residente e domiciliado'"
%token DRG_PR "Token: 'de RG'"
%token ECPF_PR "Token: 'e CPF'"
%token NOMEIOMEUPROC_PR "Token: 'nomeio meu(minha) procurador(a) o(a)'"
%token PARAFINS_PR "Token: 'Para fins'"
%token COMMA "Virgula"
%token FINALPOINT "Ponto final"
%token DE_PR "Token: 'de'"
%token ERROR "Lexical error"

%token PRONOME_TRATAMENTO "Pronome de Tratamento"
%token ESTADO_CIVIL "Estado civil"
%token MES "Mês"
%token ENDERECO "Endereço"
%token <integer> DIA 
%token <integer> ANO
%token <string> RG 
%token <string> CPF
%token <string> TEXTO
%token LINHA_B "Linha em branco"


%%

prog:
    |blocs
    |ERROR

;
texto:
    TEXTO 
    |TEXTO SPACE texto 
    |SPACE texto 
;

pronome_trata:
    PRONOME_TRATAMENTO
    | 
;

blocs:
    PROCURACAO_PR 
    LINHA_B 
    LINHA_B 
    EU_PR COMMA texto COMMA texto COMMA SPACE NATURALDE_PR texto COMMA SPACE ESTADO_CIVIL
    COMMA SPACE RESI_DOMICI_PR SPACE ENDERECO COMMA SPACE DRG_PR SPACE RG SPACE ECPF_PR SPACE CPF 
    COMMA SPACE NOMEIOMEUPROC_PR SPACE pronome_trata texto COMMA texto COMMA SPACE NATURALDE_PR
    texto COMMA SPACE ESTADO_CIVIL COMMA SPACE RESI_DOMICI_PR SPACE ENDERECO COMMA SPACE DRG_PR SPACE 
    RG SPACE ECPF_PR SPACE CPF COMMA SPACE PARAFINS_PR texto FINALPOINT 
    LINHA_B 
    LINHA_B 
    ENDERECO COMMA SPACE DIA SPACE DE_PR SPACE MES DE_PR SPACE ANO
    LINHA_B
    LINHA_B
    texto
    LINHA_B
    
;


/*grammar rules*/

%%
/*int saveOn(char*text){
    FILE *fp=NULL;
    fp = fopen("textFile.txt" ,"w+");

    if(fp=NULL){
        printf("Erro opening!");return 0;
        
    }
    printf("\n Im here %s\n",text);
    
    fprintf(fp,"%d",2);
    
    return 1;
}*/


