# include <stdio.h>
# include <stdlib.h>
# include <string.h>

struct station {
	char name[30];
	/* char arrivalTime[10]; */
	/* char departureTime[10]; */
	struct station* next;
};

int main(){
	char name1[] = "tsukuba";
  char name2[] = "akihabara";

  struct station station1;
  strcpy(station1.name, name1);
  struct station station2;
  strcpy(station2.name, name2);

  station2.next = NULL;
  station1.next = &station2;

  

  printf("%s\n", station1.name);
  printf("%s\n", (*station1.next).name);
}
