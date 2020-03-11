BOOLEAN true|false
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
EMPTY isempty
SPACE [ ]
NUMBER ({DIGIT})+
FLOATING_POINT {DIGIT}*(\.{DIGIT}+)
IDENTIFIER {LETTER}({LETTER}|{DIGIT})*
NAME {IDENTIFIER}|({NUMBER}{IDENTIFIER})
COMMENT {HASHTAG}([^\n])*\n


%%
{ADD} {printf("ADD ");};
{DELETE} {printf("DELETE ");};
{CLEAR} {printf("CLEAR ");};
{SHOW} {printf("SHOW_CONTENT ");};
{UNION} {printf("UNION ");};
{EMPTY} {printf("IS_EMPTY ");};
{INTERSECT} {printf("INTERSECT ");};
{FUNCDEC} {printf("FUNCDEC ");};
{STARTF} {printf("STARTF ");};
{INPUT} {printf("INPUT ");};
{OUTPUT} {printf("OUTPUT ");};
{END} {printf("END ");}
{ENDF} {printf("ENDF ");};
{DIFF_OP} {printf("DIFF_OP ");};
{LETTER} {printf("IDENTIFIER ");};
{BEGIN} {printf("BEGIN ");}
{BOOLEAN} {printf("BOOLEAN ");}
{PLUS_OP} {printf("PLUS_OP ");}
{MINUS_OP} {printf("MINUS_OP ");}
{MUL_OP} {printf("MUL_OP ");}
{DIV_OP} {printf("DIV_OP ");}
{REMAINDER_OP} {printf("REMAINDER_OP ");}
{ASSIGNMENT} {printf("ASSIGNMENT ");}
{NEW_LINE} {printf("NEW_LINE ");}
{EQUALITY_OP} {printf("EQUALITY_OP ");}
{HASHTAG} {printf("HASHTAG ");}
{IF} {printf("IF ");}
{THEN} {printf("THEN ");}
{ELSE} {printf("ELSE ");}
{DO} {printf("DO ");}
{WHILE} {printf("WHILE ");}
{RETURN} {printf("RETURN ");}
{OR_OP} {printf("OR_OP ");}
{AND_OP} {printf("AND_OP ");}
{XOR_OP} {printf("XOR_OP ");}
{LT_OP} {printf("LT_OP ");}
{GT_OP} {printf("GT_OP ");}
{LTE_OP} {printf("LTE_OP ");}
{GTE_OP} {printf("GTE_OP ");}
{NOT_OP} {printf("NOT_OP ");}
{SUBSET_OP} {printf("SUBSET_OP ");}
{SUPSET_OP} {printf("SUPSET_OP ");}
{SEMICOLON} {printf("SEMICOLON ");}
{DOLLAR_SIGN} {printf("DOLLAR_SIGN ");}
{LCB} {printf("LCB ");}
{RCB} {printf("RCB ");}
{LSB} {printf("LSB ");}
{RSB} {printf("RSB ");}
{LP} {printf("LP ");}
{RP} {printf("RP ");}
{COMMA} {printf("COMMA ");}
"$"{IDENTIFIER} {printf("SET ");}
{NUMBER} {printf("NUMBER ");}
{FLOATING_POINT} {printf("FLOATING_POINT ");}
{IDENTIFIER} {printf("IDENTIFIER ");}
{NAME} {printf("NAME ");}
{COMMENT} {printf("COMMENT ");}


. {printf("%s", yytext);}

%%
int yywrap(void) {
	return 1;
}
int main(void){
	yylex();
	return 0;
}


