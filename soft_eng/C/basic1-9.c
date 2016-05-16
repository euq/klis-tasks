#include <stdio.h>

int fact(int n){
  if(n<=1){
    return 1;
  }else{
    return n * fact(n-1);
  }
}

int main(){
  int i;
  scanf("%d", &i);
  if(i < 0){
    printf("can't compute factrial number for minus number");
  }else{
    printf("%d", fact(i));
  }
}
