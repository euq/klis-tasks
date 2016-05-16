// sample 3-1
#include <stdio.h>
#include <stdlib.h>

struct person {
  char name[30];
  char address[40];
  int birthyear;
};

struct company{
  struct person ceo;
  struct person employees[2];
};

int main(){
  int i;
  struct company my_company;


  printf("What is the name of ceo #%i?\n", i);
  scanf("%s", my_company.ceo.name);
  printf("What is the address of %s?\n", my_company.ceo.name);
  scanf("%s", my_company.ceo.address);

  for(i = 0; i < 2; i++){
    printf("What is the name of employee #%i?\n", i);
    scanf("%s", my_company.employees[i].name);
    printf("What is the address of %s?\n", my_company.employees[i].name);
    scanf("%s", my_company.employees[i].address);
  }



  printf("\n");
  printf("CEO : %s, ", my_company.ceo.name);
  printf("lives in %s\n", my_company.ceo.address);
  for(i = 0; i < 2; i++){
    printf("Employee #%d: %s, ", i, my_company.employees[i].name);
    printf("lives in %s\n", my_company.employees[i].address);
  }
}
