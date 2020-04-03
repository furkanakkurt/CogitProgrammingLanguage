%{
#include <stdio.h>
#include <stdlib.h>
void yyerror(char* s);
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
%token BEGIN
%token END
%token DIGIT
%token LETTER 
%token UNION
%token INTERSECT
%token PLUS_OP
%token MINUS_OP
%token MUL_OP
%token DIV_OP
%token ASSIGNMENT
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
%token ENDWHILE
%token SET
%token IS_EMPTY
%token SET_INIT
%token CONTAINS

%start program
%right ASSIGNMENTOP

%%

//Program
program : 
	BEGIN stmts END
stmts : 
	stmt
	| stmts
stmt :
	if_stmt end_stmt 
	| nonif_stmt end_stmt
nonif_stmt :
	loop
	| function_call
	| assignment
	| set_functions
	| input_stmt
	| output_stmt
	| var_dec
var_dec :
	int_dec
	| double_dec
	| string_dec
	| boolean_dec
	| char_dec
	| set
int_dec :
	INT IDENTIFIER
double_dec : 
	DBL IDENTIFIER
string_dec : 
	STR IDENTIFIER
boolean_dec :
	BOOL IDENTIFIER
char_dec :
	CH IDENTIFIER
input_stmt :
	INPUT variable		
output_stmt :
	OUTPUT sentence
	|OUTPUT expression
loop : 
	while_stmt
	|dowhile_stmt
while_stmt :
	WHILE LP logical_exp RP THEN stmts ENDWHILE
dowhile_stmt :
	DO LP stmts RP WHILE logical_exp
end_stmt :
	SEMICOLON
assignment :
	SET assignment_op set_exp
	|IDENTIFIER assignment_op arithmetic_exp
	|IDENTIFIER assignment_op numeral
	|IDENTIFIER assignment_op logical_exp
	|IDENTIFIER assignment_op IDENTIFIER
	|IDENTIFIER assignment_op input_stmt
	|assignment arithmetic_op numeral
if_stmt :
	matched_if 
	|unmatched_if
matched_if :
	IF LP logical_exp RP THEN matched_if ELSE matched_if 
	| nonif_stmt
unmatched_if :
	IF LP logical_exp RP THEN if_stmt 
	|IF LP logical_exp RP THEN matched_if ELSE unmatched_if
expression :
	logical_exp 
	|arithmetic_exp
	|set_exp
	|variable
	|IDENTIFIER
arithmetic_exp :
	numeral arithmetic_op numeral
	|numeral arithmetic_op IDENTIFIER
	|IDENTIFIER arithmetic_op IDENTIFIER
	|arithmetic_exp arithmetic_op NUMERAL 
	|arithmetic_exp arithmetic_op IDENTIFIER
logical_exp :
	expression logic_op expression
	| SET logic_op SET
function_dec :	
    FUNCDEC func_name LP function_parameters RP STARTF stmts RETURN stmt ENDF
function_call :
	func_name LP function_parameters RP
function_parameters :
	function_parameter 
	| function_parameters COMMA funtion_parameter
function_parameter :
	SET
	|numeral
	|STRING
	|EMPTY
func_name :
	IDENTIFIER
variable :
	SET
	|STRING
	|INTIGER
	|BOOLEAN
	|DOUBLE
	|CHAR
arithmetic_op :
	PLUS_OP
	|MINUS_OP
	|DIV_OP
	|MUL_OP
	|REMAINDER_OP
logic_op :
	OR_OP
	|AND_OP
	|XOR_OP
	|EQUAL_OP
	|LT_OP
	|GT_OP
	|LTE_OP
	|GTE_OP
	|NOT_OP
	|SUBSET_OP
	|SUPSET_OP
 set_exp : 
	SET_INIT
	|set_union
	|set_intersect
	|set_diff
	|set_cartesian
	|set
set_union :
	SET_INIT UNION set_expression
	| SET UNION set_expression
set_intersect :
	SET_INIT INTERSECT set_expression
	| SET INTERSECT set_expression
set_diff : 
	SET_INIT DIFF_OP set_expression
	|SET DIFF_OP set_expression
set_cartesian : 
	SET_INIT CART_OP set_expression
	|SET CART_OP set_expression
element_list :
	set_element
	|set_element COMMA element_list
	|EMPTY
set_element : 
	SET
	|STRING
	|DOUBLE
	|INTEGER
	|CHAR
	|IDENTIFIER
	|SET_INIT
number :
	DIGIT
	|DIGIT number
numeral : 
	INTEGER
	|DOUBLE
name :
	IDENTIFIER
	|number IDENTIFIER
sentence : 
	EMPTY
	|name
	|sentence name
set_functions :
	represent_set
	|is_empty_set
	|set_addition
	|set_deletion
	|set_contains
set_contains : 
	SET CONTAINS IDENTIFIER
	|SET CONTAINS variable
set_deletion :
	SET DELETE expression
	|SET DELETE SET
	|SET DELETE element_list
set_clear : 
	SET CLEAR
represent_set : 
	SET SHOW
is_empty_set :
	SET ISEMPTY
set_addition : 
	SET ADD expression
	|SET ADD SET
	|SET ADD SET_INIT
	|SET ADD IDENTIFIER
%%
void yyerror(char *s){
fprintf(stdout,"line %d: %s\n", yylineno,s);
}
int main(void)
{
yyparse();
if(yynerrs <1)
{
	printf("Parsing is successful\n";)
}
return 0;
}
