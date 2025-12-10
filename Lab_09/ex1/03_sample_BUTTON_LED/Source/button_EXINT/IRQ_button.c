#include "button.h"
#include "LPC17xx.h"

#include "../led/led.h"

void EINT0_IRQHandler (void)	  
{
	LED_On(0);
  LPC_SC->EXTINT &= (1 << 0);     /* clear pending interrupt         */
}


//void EINT1_IRQHandler (void)	  
//{
//  LED_On(1);
//	LPC_SC->EXTINT &= (1 << 1);     /* clear pending interrupt         */
//}

/* my code */
#include "../lfsr.h"
void EINT1_IRQHandler (void) {
    lfsr_state = lfsr_step(lfsr_state, taps, &output_bit);
    /* Mostra nuovo stato sui LED */
    LED_Out(lfsr_state);
    LPC_SC->EXTINT &= (1 << 1);
}


void EINT2_IRQHandler (void)	  
{
	LED_Off(0);
	LED_Off(1);
  LPC_SC->EXTINT &= (1 << 2);     /* clear pending interrupt         */    
}


