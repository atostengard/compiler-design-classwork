/***
 From here and forward the lex files included have the
 sole purpose of interpreting tokens to send forward to
 bison. In the bison files, further work is done with
 defined grammar rules comprised of the tokens and
 their data values returned here.
***/

%{
#include <iostream>
#include <cstring>
#include <fstream>
#include <vector>
#include "interpreter.tab.h"
#define YY_DECL extern "C" int yylex()
int lineNum = 0;

%}

%%

[ \t]	;
\n	{return EOL;}
[a-zA-Z0-9]+\.csv {yylval.sVal = strdup(yytext); return fileName;}

"lineplot" {return LINEPLOT;}
"barplot" {return BARPLOT;}

[a-zA-Z0-9]+ {yylval.sVal = strdup(yytext); return strExpr;}

%%
