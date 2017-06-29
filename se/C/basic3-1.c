// sample 3-1
#include <stdio.h>
#include <stdlib.h>

struct goods {
  char code[10];
  char name[40];
  int price;
};

int main(){
  int i;
  struct goods goods_list[3];

  for(i = 0; i < 3; i++){
    scanf("%s", goods_list[i].code);
    scanf("%s", goods_list[i].name);
    scanf("%d", &goods_list[i].price);
  }
    for(i = 0; i < 3; i++){
    printf("商品コード %s\n", goods_list[i].code);
    printf("商品名 %s\n", goods_list[i].name);
    printf("値段: %d\n", goods_list[i].price);
    printf("\n");
  }
}
