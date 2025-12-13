#include "button.h"
#include "LPC17xx.h"


#include "../led/led.h"
#include "../timer/timer.h"

extern volatile uint32_t NUMBER;

void EINT0_IRQHandler (void)	  	/* INT0														 */
{
	LED_On(0);
	LPC_SC->EXTINT &= (1 << 0);     /* clear pending interrupt         */
}


void EINT1_IRQHandler (void)	  	/* KEY1														 */
{
  //NUMBER--;
	
	if (NUMBER > 0){ //MIGLIORAMENTO
		NUMBER--;
	}
	
	//DA MODIFICARE
	LPC_SC->EXTINT &= (1 << 1);     /* clear pending interrupt         */
}

void EINT2_IRQHandler (void)	  	/* KEY2														 */
{
	LED_Off(0);
	LED_Off(1);
  LPC_SC->EXTINT &= (1 << 2);     /* clear pending interrupt         */  
	enable_timer(0);  
}


