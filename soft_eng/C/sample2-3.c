#include <stdio.h>
#include <stdlib.h>

int main(){

  int size = 10;
  char* p = (char *)malloc(sizeof(char)*size);

  char input[10];

  scanf("%s", &input);
  printf("%s", input);

  *p = 'a';
  *(p+1) = 'b';

  int i;
  for (i = 0; i < size; i++){
    *(p+i) = 'a';
  }

  // printf("%p", *p);
  // printf("%s", p);

  // printf("%p", *s);



  return 0;
}
