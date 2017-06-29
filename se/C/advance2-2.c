#include <stdio.h>

int main(void)
{
  FILE *fp;
  char *fname = "english.txt";
  char s[100];

  fp = fopen( fname, "r" );
  
  while( fgets( s, 100, fp ) != NULL ){
    printf( "%s", s );
  }

  fclose( fp );
}
