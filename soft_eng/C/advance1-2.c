# include <stdio.h>
# include <math.h>


int main(){

  double e = 0.0;
  int i;
  
  for(i=1; i < 100000; i++){
    e += pow(i,-2);
  }

  printf("pi is approximate to %f", sqrt(6*e));
}
