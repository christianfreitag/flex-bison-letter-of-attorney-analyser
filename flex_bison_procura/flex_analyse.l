%{
#include <stdio.h>
#include <string.h>
#include "bison_analyse.tab.h"

int erro=0,isparsing=0;
FILE * erros=NULL;
void count();
void showToken(char*,char*);
void lexicalError(char * e);
%}
%option yylineno


ENDERECO "["[a-zA-Z0-9/.," "]+"]"
PROCURACAO_PR "PROCURAÇÃO"
EU_PR "Eu"
NATURALDE_PR "natural de"
RESI_DOMICI_PR "residente e domiciliado(a) em"
DRG_PR "de RG"
ECPF_PR "e CPF"
NOMEIOMEUPROC_PR "nomeio meu(minha) procurador(a) o(a)"
PARAFINS_PR "para fins de"
DE_PR "de"
PRONOME_TRATAMENTO "Sr."|"Sra."|"Dr."|"Dra."
ESTADO_CIVIL "casado"|"solteiro"|"viúvo"|"divorciado"|"complicado"|"colorido"
MES "janeiro "|"fevereiro "|"março "|"abril "|"maio "|"junho "|"julho "|"agosto "|"setembro "|"outubro "|"novembro "|"dezembro "
COMMA ","
FINALPOINT "."

DIA [0-3][0-1]|[0][1-9]|[1-2][0-9]
ANO [0-9][0-9][0-9][0-9]
DATA {DIA} de {MES} de {ANO}
RG [0-9][0-9][0-9]"."[0-9][0-9][0-9]"."[0-9][0-9][0-9]
CPF [0-9][0-9][0-9]"."[0-9][0-9][0-9]"."[0-9][0-9][0-9]"-"[0-9][0-9]
TEXTO [a-zA-Z]+






%%
[ \t] {showToken("SPACE",yytext);return SPACE;}
[ \n] {showToken("LINHA EM BRANCO",yytext); return LINHA_B;}
{PROCURACAO_PR} {showToken("PROCURACAO",yytext);return PROCURACAO_PR;}
{EU_PR} {showToken("EU",yytext);return EU_PR;}
{NATURALDE_PR} {showToken("NATURAL DE",yytext);return NATURALDE_PR;}
{RESI_DOMICI_PR} {showToken("RESIDENTE EM",yytext);return RESI_DOMICI_PR;}
{DRG_PR} {showToken("DE RG",yytext);return DRG_PR;}
{ECPF_PR} {showToken("DE CPF",yytext);return ECPF_PR;}
{NOMEIOMEUPROC_PR} {showToken("NOMEIO",yytext);return NOMEIOMEUPROC_PR;}
{PARAFINS_PR} {showToken("PARA FINS",yytext);return PARAFINS_PR;}
{PRONOME_TRATAMENTO} {showToken("PRONOME TRATAMENTO",yytext);return PRONOME_TRATAMENTO;}
{ESTADO_CIVIL} {showToken("ESTADO CIVIL",yytext);return ESTADO_CIVIL;}
{ENDERECO} {showToken("ENDERECO",yytext);yylval.string = strdup(yytext);return ENDERECO;}
{MES} {showToken("MES",yytext);return MES;}
{DE_PR} {showToken("DE",yytext);return DE_PR;}
{COMMA} {showToken("COMMA",yytext);return COMMA;}
{FINALPOINT} {showToken("FINALPOINT",yytext);return FINALPOINT;}


{DIA} {showToken("DIA",yytext);yylval.integer = atoi(yytext);return DIA;}
{ANO} {showToken("ANO",yytext);yylval.integer = atoi(yytext);return ANO;}
{RG} {showToken("RG",yytext); yylval.string = strdup(yytext);return RG;}
{CPF} {showToken("CPF",yytext);yylval.string = strdup(yytext);return CPF;}
{TEXTO} {showToken("TEXTO",yytext);yylval.string = strdup(yytext);return TEXTO;}
. {lexicalError(yytext);return ERROR;}


%%
int yywrap(){} //tira os espaços
void yyerror(const char * s)
{
    erro=1;
    printf("\nError | Line: %d - %s\n",yylineno,s);
    fprintf(erros,"\nError | Line: %d - %s\n",yylineno,s);
}
void lexicalError(char * e){
    erro =1;
   if(isparsing!=1){printf("\nLexical error | Line: %d on undefined token: %s",yylineno,e);
   
   fprintf(erros,"\nLexical error | Line: %d on undefined token: %s",yylineno,e);
   }
}
void showToken(char*nome, char* text){
    //printf("%s",text);
    
}

void main(int argc,char* argv[]){
    erros = fopen("Errors.txt","w+");

	if(yyin=fopen(argv[1],"r")){
          while(yylex());
          
	}else{
		printf("\nError opening file!! Maybe this file does not exist, check your directory for the correct name.\n");
	}
    yylineno=1;
    if(yyin=fopen(argv[1],"r")){
        isparsing = 1;
        yyparse();   
	}else{
		printf("\nError opening file!! Maybe this file does not exist, check your directory for the correct name.\n");
	}

    if(erro!=1){
        printf("\n Arquivo analisado com sucesso!\n");
    }
    

}





