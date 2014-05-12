
/* description: Parses end executes mathematical expressions. */

/* lexical grammar */
%lex
%%

\s+                   /* skip whitespace */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
"*"                   return '*'
"/"                   return '/'
"-"                   return '-'
"+"                   return '+'
"^"                   return '^'
"!"                   return '!'
"%"                   return '%'
"("                   return '('
")"                   return ')'
"PI"                  return 'PI'
"E"                   return 'E'
<<EOF>>               return 'EOF'
"="					  return '='
"=="	  			  return '=='
[a-z]+\b			  return 'ID'
.                     return 'INVALID'

/lex

/* operator associations and precedence */

%right '='
%left '=='
%left '+' '-'
%left '*' '/'
%left '^'
%right '!'
%right '%'
%left UMINUS

%start expressions

%% /* language grammar */

expressions
    : e EOF
        { typeof console !== 'undefined' ? console.log($1) : print($1);
          return $1; }
    ;

e
    : e '+' e
        {$$ = $1 + $3 + '+' + ' ';}
    | e '-' e
        {$$ = $1 + $3 + '-' + ' ';}
    | e '*' e
        {$$ = $1 + $3 + '*' + ' ';}
    | e '/' e
        {$$ = $1 + $3 + '/' + ' ';}
    | e '^' e
        {$$ = $1 + $3 + '^' + ' ';}
    | e '!'
        {$$ = $1 + '!' + ' ';}
    | e '%'
        {$$ = $1 + '%' + ' ';}
    | '-' e %prec UMINUS
        {$$ = $2 + '-' + ' ';}
    | '(' e ')'
        {$$ = $2;}
    | NUMBER
    | E
        {$$ = 'E';}
    | PI
        {$$ = 'PI';}
	| ID '=' e
		{$$ = '&' + $1 + $3 + '=' + ' ';}
	| ID
	 {$$ = $1;}
	
	| e '==' e
	{$$ = $1 + $3 + '==' + ' ';}
    ;

