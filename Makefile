parser: y.tab.c
	gcc -o parser y.tab.c
y.tab.c: gogit.y lex.yy.c
	yacc gogit.y
lex.yy.c: gogit.l
	lex gogit.l
