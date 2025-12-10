#include "button.h"
#include "LPC17xx.h"

#include "../led/led.h"

extern volatile unsigned char current_state;
extern volatile unsigned char taps;
extern int output_bit;

void EINT0_IRQHandler (void)	  
{
	LED_On(0);
  LPC_SC->EXTINT &= (1 << 0);     /* clear pending interrupt         */
}


void EINT1_IRQHandler (void)	  
{
  //LED_On(1);
	
	current_state = lfsr_step(current_state, taps, &output_bit);
	
	LPC_SC->EXTINT = (1 << 1);     /* clear pending interrupt         */
}

void EINT2_IRQHandler (void)	  
{
	LED_Off(0);
	LED_Off(1);
  LPC_SC->EXTINT &= (1 << 2);     /* clear pending interrupt         */    
}


