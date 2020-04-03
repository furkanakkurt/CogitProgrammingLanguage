BOOLEAN true|false
BOOL boolean
INT int
STR string
CH char
DBL double
BEGIN begin
END end
DIGIT [0-9]
LETTER [A-Za-z]
UNION [Uu]
INTERSECT [Nn]
PLUS_OP \+
MINUS_OP \-
MUL_OP \*
DIV_OP \/
ASSIGNMENT \=
REMAINDER_OP \%
DIFF_OP \\
NEW_LINE \n
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
ISEMPTY isempty
EMPTY
SET_INIT \{ \}
SPACE [ ]
INTEGER ({DIGIT})+
DOUBLE {DIGIT}*(\.{DIGIT}+)
IDENTIFIER {LETTER}({LETTER}|{DIGIT})*
STRING \"([^\\\"]|\\\"|\\\n|\\\\)*\"
COMMENT {HASHTAG}([^\n])*\n


%%
{ADD} return ADD;
{DELETE} return DELETE;
{CLEAR} return CLEAR;
{SHOW} return SHOW;
{UNION} return UNION;
{ISEMPTY} return ISEMPTY;
{EMPTY} return EMPTY;
{INTERSECT} return INTERSECT;
{FUNCDEC} return FUNCDEC;
{STARTF} return STARTF;
{INPUT} return INPUT;
{OUTPUT} return OUTPUT;
{END} return END;
{ENDF} return ENDF;
{DIFF_OP} return DIFF_OP;
{LETTER} return LETTER;
{BEGIN} return BEGIN;
{INTEGER} return INTEGER;
{STRING} return STRING;
{CHAR} return CHAR;
{INT} return INT;
{STR} return STR;
{CH} return CH;
{BOOL} return BOOL;
{PLUS_OP} return PLUS_OP;
{MINUS_OP} return MINUS_OP;
{MUL_OP} return MUL_OP;
{DIV_OP} return DIV_OP;
{REMAINDER_OP} return REMAINDER_OP;
{ASSIGNMENT} return ASSIGNMENT;
{NEW_LINE} return NEW_LINE;
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
{COMMA} return COMMA;
"$"{IDENTIFIER} return SET;
{NUMBER} return NUMBER;
{DOUBLE} return DOUBLE;
{IDENTIFIER} return IDENTIFIER;
{NAME} return NAME;
{COMMENT} return COMMENT;


. {printf("%s", yytext);}

%%
int yywrap(void) {
	return 1;
}
int main(void){
	yylex();
	return 0;
}


