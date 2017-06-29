// Sample 1-5
#include <stdio.h>


double pow(int n, int i){
  int j;
  double m = 1;
  for(j = 0; j < i; j++){
    m *= n;
  }
  return m;
}

int main(){
    int i = 0;
    double arctan1 = 0;
    double d;

    while(i < 10000){
      arctan1 += pow(-1,i) / (i*2 + 1);
      if(i % 100 == 0){
        printf("pi = %f\n", arctan1 * 4);
      }
      i++;
    }
}
