// Sample 1-5
#include <stdio.h>


int fact(int n){
  if(n<=1){
    return 1;
  }else{
    return n * fact(n-1);
  }
}

double mypow(double n, double i){
  int j;
  double m = 1;
  for(j = 0; j < i; j++){
    m *= n;
  }
  return m;
}


double mysin(double x){
  double e = 0.0;
  int i;

  for(i = 0; i < 10; i++){
    e += mypow(-1, i) * mypow(x, 2*i + 1) / fact(2*i + 1);
  }
  return e;
}


double mycos(double x){
  double e = 0.0;
  int i;

  for(i = 0; i < 10; i++){
    e += mypow(-1, i) * mypow(x, 2*i) / fact(2*i);
  }
  return e;
}


int main(){
  printf("sin: %f\n", mysin(3.141592653589 / 4));
  printf("cos: %f\n", mycos(3.141592653589 / 4));
}
