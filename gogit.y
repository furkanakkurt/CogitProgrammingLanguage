%{
#include <stdio.h>
#include <stdlib.h>
#define YYDEBUG 1
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
%token ENDIF
%start program
%right ASSIGNMENT_OP

%%

//Program
program : 
	BEGINN stmts END {printf("Input program is valid\n"); return 0;} | BEGINN empty END {printf("Input program is valid\n"); return 0;};
stmts : 
	stmt
	|stmts stmt ; 
stmt :
	if_stmt end_stmt 
	| nonif_stmt end_stmt
	| COMMENT;
nonif_stmt :
	loop
	| function_dec
	| function_call
	| assignment
	| set_functions
	| input_stmt
	| output_stmt
	| var_dec;

//decleration statements.
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

//input-output statements.
input_stmt :
	INPUT IDENTIFIER;		
output_stmt :
	OUTPUT IDENTIFIER
	|OUTPUT variable;

//loop statements.
loop : 
	while_stmt
	|dowhile_stmt;
while_stmt :
	WHILE LP logical_exp RP THEN stmts ENDW;
dowhile_stmt :
	DO LP stmts RP WHILE logical_exp;
end_stmt :
	SEMICOLON;

//assignment statements.
assignment :
	SET ASSIGNMENT_OP set_expression
	|IDENTIFIER ASSIGNMENT_OP LP arithmetic_exp RP
	|IDENTIFIER ASSIGNMENT_OP logical_exp
	|IDENTIFIER ASSIGNMENT_OP STRING
	|IDENTIFIER ASSIGNMENT_OP BOOLEAN
	|IDENTIFIER ASSIGNMENT_OP CHAR
	|assignment arithmetic_op numeral;

//conditional statement.
if_stmt :
	IF LP logical_exp RP THEN stmts ENDIF
	|IF LP logical_exp RP THEN stmts ELSE THEN stmts ENDIF;

//arithmetic expression with presedence rule.
arithmetic_exp :
	arithmetic_exp sub_sum_op ar_exp | ar_exp;
ar_exp : 
	ar_exp mult_div_op arit_Exp | arit_Exp;
arit_Exp :
	LP arithmetic_exp RP | IDENTIFIER | numeral;
sub_sum_op :
	PLUS_OP
	|MINUS_OP;
mult_div_op :
	MUL_OP
	|DIV_OP
	|REMAINDER_OP;
arithmetic_op :
	sub_sum_op
	|mult_div_op;

//logical expressions of all kind.	
logical_exp :
	IDENTIFIER logic_op IDENTIFIER
	|IDENTIFIER set_op SET
	|variable set_op SET	
	|SET set_op SET
	|IDENTIFIER logic_op numeral
	|numeral logic_op IDENTIFIER
	|numeral logic_op numeral;

//Function decleration and function call.
function_dec :	
        FUNCDEC func_name LP function_parameters RP STARTF stmts RETURN IDENTIFIER end_stmt ENDF
	|FUNCDEC func_name LP function_parameters RP STARTF stmts RETURN variable end_stmt  ENDF;
function_call :
	func_name LP function_parameters RP;
function_parameters :
	function_parameter 
	| function_parameters COMMA function_parameter;
function_parameter :
	SET
	|numeral
	|CHAR
	|STRING
	|EMPTY
	|IDENTIFIER;
func_name :
	IDENTIFIER;

//variables
variable :
	STRING
	|BOOLEAN
	|numeral
	|CHAR;


//logic operations for set and normal
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

//expression that are unique to sets.
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

//functionalities that we provide for sets.
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

//printing error
int yyerror(char* s){
	fprintf(stderr, "%s on line %d\n",s,yylineno);
	return 1;
}

int main(void)
	{
	#if YYDEBUG 
		yydebug=1;
	#endif
	yyparse();
	return 0;
}
