// Sample 1-6
#include <stdio.h>

int getSmallestFactor(int a){
  int i = 2;
  while(i*i <= a){
    if(a % i == 0){
       return i;
    }
    i++;
  }
  return 0;
}

int main(){
  int in, fact;
  printf("Type in a number: ");
  scanf("%d", &in);
  while(in > 0){
    if(in == 1){ printf("1 is not a prime number.\n"); return 0;}
    fact = getSmallestFactor(in);
    if(fact == 0){break;}
    printf("%d*", fact);
    in /= fact;
  }
  if(in == 0){
    printf("\n");
  }else{
    printf("%d\n", in);
  }
}

