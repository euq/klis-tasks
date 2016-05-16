# include <stdio.h>
# include <stdlib.h>

int main(){
  int lim = 3;
  int* p = (int *)malloc(sizeof(int)*lim);
  int i;
  int d;

  for(i = 0; i < lim; i++){
    scanf("%d", &d);
    *(p+i) = d;
  }

  for(i = 0; i < lim; i++){
    printf("address: %p, value: %d\n", (p+i), *(p+i));
  }
}
