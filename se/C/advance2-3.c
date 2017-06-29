# include <stdio.h>
# include <string.h>

int main(void)
{
  FILE *fp;
  char *fname = "english.txt";
  char s[100];
  char query[] = "the";
  int ans = 0;

  fp = fopen( fname, "r" );
  
  while( fgets( s, 100, fp ) != NULL ){
    int i;
    for(i=0; i<strlen(s); i++){
      if(s[i] == 't' && s[i+1] == 'h' && s[i+2] == 'e'){
        ans++;
      }
    }
  }

  printf("出現回数: %d", ans);
  fclose( fp );
}
