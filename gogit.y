%{
#include <stdio.h>
#include <stdlib.h>
%}
%token BOOLEAN
%token BOOL
%token INT
%token STR
%token DBL
%token CH
%token STRING
%token DOUBLE
%token CHAR
%token INTEGER
%token BEGINN
%token END
%token DIGIT
%token LETTER 
%token UNION
%token INTERSECT
%token PLUS_OP
%token MINUS_OP
%token MUL_OP
%token DIV_OP
%token ASSIGNMENT_OP
%token REMAINDER_OP
%token HASHTAG
%token IF
%token THEN
%token ELSE
%token DO 
%token WHILE
%token INPUT
%token OUTPUT
%token FUNCDEC
%token STARTF
%token ENDF
%token RETURN
%token OR_OP
%token AND_OP
%token XOR_OP
%token LT_OP
%token GT_OP
%token LTE_OP
%token GTE_OP
%token NOT_OP
%token SUBSET_OP
%token SUPSET_OP
%token SEMICOLON
%token SIGN
%token DOLLAR_SIGN
%token LCB
%token RCB
%token LSB
%token RSB
%token LP
%token RP
%token COMMA
%token ADD
%token DELETE
%token CLEAR
%token SHOW
%token EMPTY
%token SPACE
%token NUMBER
%token IDENTIFIER
%token NAME
%token COMMENT
%token ENDW
%token SET
%token IS_EMPTY
%token CONTAINS
%token EQUALITY_OP
%token DIFF_OP
%token CART_OP
%token NEW_LINE

%start program
%right ASSIGNMENT_OP

%%

//Program
program : 
	BEGINN stmts END {printf("Input program is valid\n"); return 0;} | BEGINN empty END {printf("Input program is valid\n"); return 0;};
stmts : 
	stmt
	|stmt stmts ; 
stmt :
	if_stmt end_stmt 
	| nonif_stmt end_stmt;
nonif_stmt :
	loop
	| function_dec
	| function_call
	| assignment
	| set_functions
	| input_stmt
	| output_stmt
	| var_dec;
var_dec :
	int_dec
	| double_dec
	| string_dec
	| boolean_dec
	| char_dec
	| SET;
int_dec :
	INT IDENTIFIER;
double_dec : 
	DBL IDENTIFIER;
string_dec : 
	STR IDENTIFIER;
boolean_dec :
	BOOL IDENTIFIER;
char_dec :
	CH IDENTIFIER;
input_stmt :
	INPUT variable;		
output_stmt :
	OUTPUT IDENTIFIER
	|OUTPUT variable;
loop : 
	while_stmt
	|dowhile_stmt;
while_stmt :
	WHILE LP logical_exp RP THEN stmts ENDW;
dowhile_stmt :
	DO LP stmts RP WHILE logical_exp;
end_stmt :
	SEMICOLON;
assignment :
	SET ASSIGNMENT_OP set_expression
	|IDENTIFIER ASSIGNMENT_OP LP arithmetic_exp RP
	|IDENTIFIER ASSIGNMENT_OP logical_exp
	|IDENTIFIER ASSIGNMENT_OP input_stmt
	|assignment arithmetic_op numeral;
if_stmt :
	matched_if 
	|unmatched_if;
matched_if :
	IF LP logical_exp RP THEN matched_if ELSE matched_if; 
unmatched_if :
	IF LP logical_exp RP THEN if_stmt 
	|IF LP logical_exp RP THEN matched_if ELSE unmatched_if
	|IF LP logical_exp RP THEN nonif_stmt ELSE unmatched_if;
arithmetic_exp :
	arithmetic_exp arithmetic_op numeral 
	|arithmetic_exp arithmetic_op IDENTIFIER
	|IDENTIFIER
	|variable;
logical_exp :
	IDENTIFIER logic_op IDENTIFIER
	IDENTIFIER set_op SET
	variable set_op SET	
	SET set_op SET;
function_dec :	
    FUNCDEC func_name LP function_parameters RP STARTF stmts RETURN stmt ENDF;
function_call :
	func_name LP function_parameters RP;
function_parameters :
	function_parameter 
	| function_parameters COMMA function_parameter;
function_parameter :
	SET
	|numeral
	|STRING
	|EMPTY;
func_name :
	IDENTIFIER;
variable :
	STRING
	|BOOLEAN
	|numeral
	|CHAR;
arithmetic_op :
	PLUS_OP
	|MINUS_OP
	|DIV_OP
	|MUL_OP
	|REMAINDER_OP;
set_op : 
	SUBSET_OP
	|SUPSET_OP;
logic_op :
	OR_OP
	|AND_OP
	|XOR_OP
	|EQUALITY_OP
	|LT_OP
	|GT_OP
	|LTE_OP
	|GTE_OP
	|NOT_OP;
 set_expression : 
	set_init
	|set_union
	|set_intersect
	|set_diff
	|set_cartesian
	|SET;
set_union :
	set_init UNION set_expression
	| SET UNION set_expression;
set_intersect :
	set_init INTERSECT set_expression
	| SET INTERSECT set_expression;
set_diff : 
	set_init DIFF_OP set_expression
	|SET DIFF_OP set_expression;
set_cartesian : 
	set_init CART_OP set_expression
	|SET CART_OP set_expression;
element_list :
	set_element
	|set_element COMMA element_list
	|EMPTY;
set_element : 
	SET
	|variable
	|IDENTIFIER
	|set_init;
numeral : 
	INTEGER
	|DOUBLE;
set_functions :
	represent_set
	|is_empty_set
	|set_addition
	|set_deletion
	|set_clear;
set_deletion :
	SET DELETE variable
	|SET DELETE IDENTIFIER
	|SET DELETE SET;	
set_clear : 
	SET CLEAR;
represent_set : 
	SET SHOW;
is_empty_set :
	SET IS_EMPTY;
set_addition : 
	SET ADD variable
	|SET ADD IDENTIFIER
	|SET ADD SET;	
set_init : 
 	LCB element_list RCB;
empty : ;  
%%
#include "lex.yy.c"

void yyerror(char *s){
	fprintf(stdout,"line %d: %s\n", yylineno,s);
}

int main(void)
	{
	yyparse();
	return 0;
}
