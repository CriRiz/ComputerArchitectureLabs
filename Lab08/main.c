#include <math.h>
#include <stdint.h>

extern unsigned int Input_Values[8];  
extern unsigned int NUM_VALUES;

extern int fast_magic_calc(int);



int main(void){

	volatile unsigned int num = NUM_VALUES;
	float values[num],vector[num];
	float ERRORS[num];
	int i;
	
	for(i=0; i<num; i++){
		
		union { uint32_t u; float f; } conv;	 //converte i numeri 32 bit in float correttamente
		
		// Converto da 32 bit in float dentro values il vettore Input_Values preso dal file asm
		conv.u = Input_Values[i];
		values[i] = conv.f;
		
		// Con questo metodo di conversione il numero in R0 non viene tradotto erroneamente in float
		conv.u = fast_magic_calc(Input_Values[i]);
		vector[i] = conv.f;
	
		vector[i] = vector[i] * (1.5-values[i]*0.5*vector[i]*vector[i]);
		ERRORS[i] = vector[i]-1/sqrt(values[i]);

	}
	

		
	while(1);
}