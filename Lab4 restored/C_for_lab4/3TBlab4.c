#include "system.h"
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int i;
//-------------------------------------char test--------------------------------//
char read[5];
char write[5] = {'1', '2', '3', '4', '5'};
char *mem = (char *)SRAM_CONTROLLER_0_BASE;
void test_char(){
for (i=0; i<5; i++){
*mem = write[i];
printf("writing: %c \n", *mem);
mem++;
}
return;
}
//-------------------------------------short test--------------------------------//
short read[5];
short write[5] = {'1', '2', '3', '4', '5'};
short *mem = (char *)SRAM_CONTROLLER_0_BASE;
void test_short(){
for (i=0; i<5; i++){
*mem = write[i];
printf("writing: %c \n", *mem);
mem++;
}
return;
}
//-------------------------------------int test--------------------------------//
int read[5];
int write[5] = {'1', '2', '3', '4', '5'};
int *mem = (char *)SRAM_CONTROLLER_0_BASE;
void test_int(){
for (i=0; i<5; i++){
*mem = write[i];
printf("writing: %c \n", *mem);
mem++;
}
return;
}
