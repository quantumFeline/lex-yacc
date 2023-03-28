%{
#include <stdio.h>
#include <stdlib.h>

#include "param_func_segment.common.h"
#include "param_func_segment.tab.h"

void yyerror(char *);
%}

%%
segment    {
    return PARAMS_FUNC_SEGMENT;
}
[a-zA-Z_][a-zA-Z0-9_]* {
    if (!strcasecmp(yytext, "segment")) {
        return PARAMS_FUNC_SEGMENT;
    }
	yylval.token_str_value = strdup(yytext);
    return IDENTIFIER;
}
[0-9]+                 {
	yylval.token_int_value = atoi(yytext);
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
[ \t]                ; /* ignore whitespace */
.                      {
    yyerror("invalid char");
}
\n {
    return EOL;
}
%%

int yywrap() {
	return 1;
}

