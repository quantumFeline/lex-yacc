%token <char> OPEN_BRACKET
%token <char> CLOSE_BRACKET
%token <char> COMMA 
%token <int> NUMBER
%token <char const *> IDENTIFIER
%token <char const *> PARAMS_FUNC_SEGMENT

%{
	#include <stdio.h>

	void yyerror(char *);
	int yylex(void);
	int sym[256];
%}

%%
program:
	program statement '\n'
	|
	;

statement:
	 | PARAMS_FUNC_SEGMENT segment { printf("Parsed expression: %d\n", $1); }
	 ;
	
segment:
    | OPEN_BRACKET elementlist CLOSE_BRACKET { printf("(%s)", $2); }
    ;

elementlist:
    | val COMMA val { printf("[%s, %s]", $1, $3); }
    | val
    ;

val:
	| NUMBER { printf("int=%d\n", $1); }
	| IDENTIFIER { printf("var=%S\n", $1); }
	;
%%
void yyerror(char *s) {
	fprintf(stderr, "%s\n", s);
}

int main(void) {
	yyparse();
	return 0;
}
