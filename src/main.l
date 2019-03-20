%{

#include <stdio.h>
#include <string.h>
int unicamp=0, valido = 0, feec = 0;
/* Criteiros de desempate:
   1 - Maior match
   2 - Regra que vem antes */
%}




INICIO		([a-zA-Z0-9]+)
UNICAMP		(unicamp)[.](br)
FEEC		(fee)[.](unicamp)[.](br)
INSTITUTO	{INICIO}[.]{UNICAMP}
DEPARTAMENTO	{INICIO}[.]{FEEC}
QUALQUER	{INICIO}([.]{INICIO})*


%%

{INICIO}[@]{UNICAMP}	{valido++; unicamp++;}		
{INICIO}[@]{FEEC}		{valido++; unicamp++; feec++;}
{INICIO}[@]{INSTITUTO}	{valido++;unicamp++;}
{INICIO}[@]{DEPARTAMENTO}	{valido++; unicamp++; feec++;}
{INICIO}[@]{QUALQUER}	{valido++;}


[[:space:]]+ ;
[[:^space:]]+ ;

[\n]* ;


%%

int main() {
  yylex();
  printf("%d %d %d\n", valido, unicamp, feec);
  return 0;
}
