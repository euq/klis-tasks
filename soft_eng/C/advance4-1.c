/* header files */
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

/* main */
int main() {
    FILE *fp;
    FILE *fout;
    char *filename = "goods.txt";
    char *outfile = "goods2.txt";
    int ch;

    fp = fopen(filename, "r");
    fout = fopen(outfile, "w");

    while (( ch = fgetc(fp)) != EOF ) {
      if(isupper(ch)){  
        putc(tolower(ch), fout);
      }else{
        putc(toupper(ch), fout);
      }
    }

    fclose(fp);
    fclose(fout);
}
