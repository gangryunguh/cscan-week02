%{
/******************/
/* C decl section */
/******************/
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

/*******************************/
/* regular definition  section */
/*******************************/


%%
/**************************/
/* regular rules  section */
/**************************/




%%

/*********************************/
/* C/C++ code definition section */
/*********************************/

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