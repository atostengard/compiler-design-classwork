/***
 Purpose: Assign expression values to variables.
 Expressions can either be addition, subtraction,
 multiplication, or division between integers or
 previously assigned variables. The expressions
 should be in a hierarchy that interprets the 
 order of operations correctly. Be able to return
 the stored value of an assigned variable by calling
 the name as a single line command.
**/

%{
#include <iostream>
#include <cstring>
#include <fstream>
#include <vector>

extern "C" int yylex();
extern "C" int yyparse();

void yyerror(const char *s);

%}
%union{
	char* sVal;
}

%token EOL
%token BARPLOT LINEPLOT
%token fileName
%token strExpr

%type<sVal> fileName
%type<sVal> strExpr
%type<sVal> line
%type<sVal> plotcommand

%%
start: prog;

prog: multiline;

multiline: line EOL multiline
	| /* empty*/
	;

line: plotcommand fileName strExpr strExpr strExpr strExpr{
	  std::cout << "in line block" << std::endl;
	  std::ifstream fin($2);
	  std::string dataAsString;
	  std::ofstream outFile;
	  outFile.open("rScript.r");
	  while (fin >> dataAsString) {
	  
		//now write data to string for plotting
		std::cout << "x <- c(" << dataAsString << ")" << std::endl;
		outFile << "x <- c(" << dataAsString << ")" << std::endl;
		
		std::cout << $1 << "(x, main=\"" << $3 << "\", xlab=\"" << $4 << "\", ylab=\"" << $5 << "\", col=\"" << $6 << "\")" << std::endl;
		outFile << $1 << "(x, main=\"" << $3 << "\", xlab=\"" << $4 << "\", ylab=\"" << $5 << "\", col=\"" << $6 << "\")" << std::endl;
		
		std::string plottype($1);
		if (plottype.compare("plot") == 0){
			std::cout << "lines(x, type=\"l\", col=\"" << $6 << "\")" << std::endl;
			outFile << "lines(x, type=\"l\", col=\"" << $6 << "\")" << std::endl;
		}
		
		system("Rscript rScript.r");
		system("xdg-open Rplots.pdf");
	  }
}
;

plotcommand: LINEPLOT {
$$ = (char*)"plot";
}
| BARPLOT {
$$ = (char*)"barplot";
}
;

%%

int main(int argc, char **argv) {
	std::cout << "usage: <plot type: lineplot, barplot> <csv data file> <plot name> <x-axis name> <y-axis name> <color>" << std::endl;
	yyparse();
}

/* Display error messages */
void yyerror(const char *s) {
	printf("ERROR: %s\n", s);
}
