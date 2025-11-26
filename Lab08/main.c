#include <stdio.h>
#include <math.h>

extern unsigned int Input_Values;  
extern unsigned int NUM_VALUES;

extern int fast_magic_calc(int);



int main(void){

	volatile unsigned int* values = &Input_Values;
	volatile unsigned int* num = &NUM_VALUES;
	float vector[*num];
	float ERRORS[*num];
	int i;
	
	for(i=0; i<*num; i++){
		vector[i] = (float) fast_magic_calc((int) values[i]);
		vector[i] = vector[i] * (1.5-((((float)values[i])/2)*vector[i]*vector[i]));
		ERRORS[i] = 1/sqrt((float)values[i]);
		printf("%f\n", ERRORS[i]);
	}
	

		
	while(1);
}
