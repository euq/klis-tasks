// Prob 1-5
#include <stdio.h>
#include <math.h>
main(){
    int i = 1;
    int fact = 1;
    double e = 1.0;
    while(i < 10){
      fact *= i;
      e += 1.0 / fact;
      printf("e = %f\n", e);
      i++;
    }
}
