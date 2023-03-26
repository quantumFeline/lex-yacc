%{
#include <stdio.h>
#include <stdlib.h>

#include "y.tab.h"

void yyerror(char *);
%}

%%
segment    {
    return PARAMS_FUNC_SEGMENT;
}
[a-zA-Z_][a-zA-Z0-9_]* {
	yylval = *yytext;
    return IDENTIFIER;
}
[0-9]+                 {
	yylval = atoi(yytext);
    return NUMBER;
}
\(                      {
    return OPEN_BRACKET;
}
\)                      {
    return CLOSE_BRACKET;
}
\,                      {
    return COMMA;
}
[ \t\n]                ; /* ignore whitespace */
.                      {
    yyerror("invalid char");
}
%%

int yywrap() {
	return 1;
}

