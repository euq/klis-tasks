#include <stdio.h>
#include <math.h>

int fact(int n){
  if(n<=1){
    return 1;
  }else{
    return n * fact(n-1);
  }
}

int main(){
  int n = 0;
  float e = 0;
  while(n <= 10){
    e += 1.0 / (float) fact(n);
    n++;
  }
  printf("napier is %f", e);
}
