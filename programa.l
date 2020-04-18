%{
	#include <stdio.h>
	#include <string.h>
	#include <stdlib.h>
	void error(char *s);

%}

%option yylineno

digito [0-9]
letra [a-zA-Z] 
id #({letra}|{digito})+
reservada @if|@while|@else
suma "+"
resta "-"
mult "*"
div "/"
may >
men <
ig =
and &
or "|"
not ~
entero ({digito})+
decimal {digito}*"."{digito}+|{digito}+"."{digito}*

%%
{id}	{printf("Encontre un id: %s\n", yytext);}
{reservada}	{printf("Encontre una palabra reservada: %s\n", yytext);}
{suma}	{printf ("Encontre un op suma: %s\n", yytext);}
{resta}	{printf("Encontre un op resta: %s\n", yytext);}
{mult}	{printf("Encontré un op mult: %s\n", yytext);}
{div}	{printf("Encontre un op div: %s\n", yytext);}
{may}	{printf("Encontré un op mayor que: %s\n", yytext);}
{men}	{printf("Encontré un op menor que: %s\n", yytext);}
{ig}	{printf("Encontré un op de igualdad: %s\n", yytext);}
{and}	{printf("Encontré un op conjuncuiion: %s\n", yytext);}
{or}	{printf("Encontré un op disyuncion: %s\n", yytext);}
{not}	{printf("Encontré un op de negacion: %s\n", yytext);}
{entero}    {printf("Encontre un entero: %s\n", yytext);}
{decimal}	{printf("Encontré un decimal: %s\n", yytext);}
[ \t\n\r] {/* Ignora los espacios en blanco*/}
%%
int yywrap(){
    return 1;
}

void error(char *s){
    printf("Error léxico %s, en la lineea %d : %s\n",s, yylineno);
}

int main(int argc, char **argv){
    FILE *f;
    if(argc<2){
        printf("Falta archivo\n");
        exit(-1);
    }
    f = fopen(argv[1],"r");
    if(!f){
        printf("No se puede abrir el archivo\n");
        exit(-1);
    }
    yyin = f;
    yylex();
    return 0;
}