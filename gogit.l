%option yylineno

BOOLEAN true|false
BOOL boolean
INT int
STR string
CH char
DBL double
BEGINN begin
END end
DIGIT [0-9]
UNION [Uu]
INTERSECT [Nn]
CART_OP xx
PLUS_OP \+
MINUS_OP \-
MUL_OP \*
DIV_OP \/
ASSIGNMENT_OP \=
REMAINDER_OP \%
DIFF_OP \\
NEW_LINE \\n
EQUALITY_OP \=\=
HASHTAG #
IF if 
THEN then    
ELSE else 
DO do
WHILE while
ENDW endwhile
INPUT input
OUTPUT output
FUNCDEC funcdec
STARTF startf
ENDF endf
ENDIF endif
RETURN return
OR_OP	\|\|
AND_OP \&\&
XOR_OP xor
LT_OP \<
GT_OP \>
LTE_OP \<\=
GTE_OP \>\=
NOT_OP !=
SUBSET_OP subset
SUPSET_OP supset
SEMICOLON \;
SIGN [-]
DOLLAR_SIGN \$
LCB \{
RCB \}
LSB \[
RSB \]
LP \(
RP \)
COMMA \,
ADD add
DELETE delete
CLEAR clear
SHOW show
IS_EMPTY isempty 
SPACE [ ]
EMPTY (\"\")?(\(\))?(\{\})? 
CHAR \'[A-Za-z]\'
LETTER [A-Za-z]
INTEGER ({DIGIT})+
DOUBLE {DIGIT}*(\.{DIGIT}+)
IDENTIFIER {LETTER}({LETTER}|{DIGIT})*
STRING \"([^\\\"]|\\\"|\\\n|\\\\)*\"
COMMENT \/\*.*\*\/ 

%%
{ADD} return ADD;
{DELETE} return DELETE;
{CLEAR} return CLEAR;
{SHOW} return SHOW;
{UNION} return UNION;
{CART_OP} return CART_OP;
{IS_EMPTY} return IS_EMPTY;
{INTERSECT} return INTERSECT;
{FUNCDEC} return FUNCDEC;
{STARTF} return STARTF;
{INPUT} return INPUT;
{OUTPUT} return OUTPUT;
{END} return END;
{ENDF} return ENDF;
{ENDIF} return ENDIF;
{LETTER} return IDENTIFIER;
{CHAR} return CHAR;
{DIFF_OP} return DIFF_OP;
{BEGINN} return BEGINN;
{INTEGER} return INTEGER;
{STRING} return STRING;
{INT} return INT;
{STR} return STR;
{CH} return CH;
{BOOL} return BOOL;
{DBL} return DBL;
{PLUS_OP} return PLUS_OP;
{MINUS_OP} return MINUS_OP;
{MUL_OP} return MUL_OP;
{DIV_OP} return DIV_OP;
{REMAINDER_OP} return REMAINDER_OP;
{ASSIGNMENT_OP} return ASSIGNMENT_OP;
{EQUALITY_OP} return EQUALITY_OP;
{HASHTAG} return HASHTAG;
{IF} return IF;
{THEN} return THEN;
{ELSE} return ELSE;
{DO} return DO;
{WHILE} return WHILE;
{ENDW} return ENDW;
{RETURN} return RETURN;
{OR_OP} return OR_OP;
{AND_OP} return AND_OP;
{XOR_OP} return XOR_OP;
{LT_OP} return LT_OP;
{GT_OP} return GT_OP;
{LTE_OP} return LTE_OP;
{GTE_OP} return GTE_OP;
{NOT_OP} return NOT_OP;
{SUBSET_OP} return SUBSET_OP;
{SUPSET_OP} return SUPSET_OP;
{SEMICOLON} return SEMICOLON;
{DOLLAR_SIGN} return DOLLAR_SIGN;
{LCB} return LCB;
{RCB} return RCB;
{LSB} return LSB;
{RSB} return RSB;
{LP} return LP;
{RP} return RP;
{EMPTY} return EMPTY;
{COMMA} return COMMA;
"$"{IDENTIFIER} return SET;
{DOUBLE} return DOUBLE;
{IDENTIFIER} return IDENTIFIER;
{COMMENT} return COMMENT;
{NEW_LINE} ;
[ \t\n] ;

%%
int yywrap(void) {
	return 1;
}


