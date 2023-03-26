%token <char> OPEN_BRACKET
%token <char> CLOSE_BRACKET
%token <char> COMMA 
%token <token_int_value> NUMBER
%token <token_str_value> IDENTIFIER
%token <token_str_value> PARAMS_FUNC_SEGMENT

%{
	#include <stdio.h>
	#include "param_func_segment.common.h"

	void yyerror(char *);
	int yylex(void);
	int sym[256];
%}

%union {
	int token_int_value; // from lexer
	const char *token_str_value; // from lexer
	struct val_value the_val_value;
	struct elementlist_value the_elementlist_value;
}

%type <the_val_value> val
%type <the_elementlist_value> elementlist
%type <the_elementlist_value> segment

%%
program:
	program statement '\n'
	|
	;

statement:
	PARAMS_FUNC_SEGMENT segment {
		printf("Parsed: statement for %s\n", $1);
	}
	;
	
segment:
	OPEN_BRACKET elementlist CLOSE_BRACKET {
		$$ = $2;
		printf("Pased: segment\n");
	}
    ;

elementlist:
	val {
		struct elementlist_node* p = malloc(sizeof(struct elementlist_node));
		p->the_val = $1;
		$$.first = p;
		$$.last = p;
	}
	| elementlist COMMA val {
		struct elementlist_node* p = malloc(sizeof(struct elementlist_node));
		p->the_val = $3;
		$$.last->next = p;
		$$.last = p;
	}
	;

val:
	NUMBER {
		printf("val: int=%d\n", $1);
		$$.is_identifier = 0;
		$$.number = $1;
	}
	| IDENTIFIER {
		printf("val: var=%s\n", $1);
		$$.is_identifier = 1;
		$$.identifier = $1;
	}
	;
%%
void yyerror(char *s) {
	fprintf(stderr, "%s\n", s);
}

int main(void) {
	yyparse();
	return 0;
}
