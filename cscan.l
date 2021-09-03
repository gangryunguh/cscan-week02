%{
   /* C decl section */

#include <stdio.h>
#include <ctype.h>
#include <string.h>

typedef struct token_freq {
   int freq;
   char *token;
} TOKEN_FREQ;

TOKEN_FREQ tokenfreq[] = {
   {0,"number"},
   {0,"ident"},
   {0,"char"},
   {0,"string"},
   {0,"("},
   {0,")"},
   {0,"{"},
   {0,"}"},
   {0,";"},
   {-1, ""}
};

void insert_update(char *);
%}

  /* regular definition  section */
quote \'
back  \\
ditto \"
octal [0-7]
octch ({back}{octal}|{back}{octal}{octal}|{back}{octal}{octal})
digit [0-9]
alpha [a-zA-Z_]
schar [^'\"\n\\]
char  ({back}?({schar}|{ditto})|{back}{back}|{back}{quote}|{octch})
str   {back}?({schar}|{quote})|{back}{back}|{back}{ditto}|{octch}

%%
  /* regular rules  section */

[ \t]*                      ;
{digit}+                    { /* number token */
                              insert_update("number");
                              printf("%s\n", yytext);
                            }

{alpha}({alpha}|{digit})*   { /* ident token */
                              insert_update("ident");
                              printf("%s\n", yytext);
                            }
{quote}{char}{quote}        { /* char token */
                              insert_update("char");
                              printf("%s\n", yytext);
                            }
.                           ;

%%
  /* C/C++ code definition section */

int
main() {
   yylex();
   return 0;
}

int
yywrap() {
   int i;

   printf("       token       token freq \n");
   printf("------------------------------\n");
   for (i=0; tokenfreq[i].freq != -1; i++) {
       if (tokenfreq[i].freq)
          printf("%21s    %5d\n", tokenfreq[i].token, tokenfreq[i].freq);
   }
   return 1;
}

void
insert_update(char *name) {
   int i;
   for (i=0; tokenfreq[i].freq != -1; i++) {
      if (!strcmp(name,tokenfreq[i].token)) {
         tokenfreq[i].freq++;
      }
   }
}