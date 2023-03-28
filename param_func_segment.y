%token EOL
%token <char> OPEN_BRACKET
%token <char> CLOSE_BRACKET
%token <char> COMMA 
%token <token_int_value> NUMBER
%token <token_str_value> IDENTIFIER
%token <token_str_value> PARAMS_FUNC_SEGMENT

%{
	#include <stdio.h>
	#include <string.h>
	#include "param_func_segment.common.h"

	void yyerror(char *);
	int yylex(void);
	int sym[256];
	struct command_tree res;
%}

%union {
	int token_int_value; // from lexer
	const char *token_str_value; // from lexer
	struct val_value the_val_value;
	struct element_list the_elementlist;
	struct command_tree the_command_tree;
}

%type <the_val_value> val
%type <the_elementlist> elementlist
%type <the_elementlist> segment
%type <the_command_tree> statement

%%
program:
    program statement EOL {
        res = $2;
    }
    |
    ;

statement:
	PARAMS_FUNC_SEGMENT segment {        
        strcpy(&$$.command, "segment");
        $$.list = $2;
		printf("Parsed: statement\n");
	}
	;
	
segment:
	OPEN_BRACKET elementlist CLOSE_BRACKET {
		$$ = $2;
		printf("Parsed: segment\n");
	}
    ;

elementlist:
    elementlist COMMA val {
		//struct elementlist_node* p = malloc(sizeof(struct elementlist_node));
		$$.values[$$.len] = $3;
		$$.len += 1;
	}
	| val {
		//struct elementlist_node* p = malloc(sizeof(struct elementlist_node));
		$$.values[0] = $1;
		$$.len = 1;
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
        strcpy(&$$.identifier, $1);
		//$$.identifier = $1;
	}
	;
%%
void yyerror(char *s) {
	fprintf(stderr, "%s\n", s);
}

int main(void) {
	yyparse();
	
	FILE * pFile;
	pFile = fopen ("res.bin", "wb");
    fwrite (&res, sizeof(struct command_tree), 1, pFile);
    fclose (pFile);
            
	return 0;
}
