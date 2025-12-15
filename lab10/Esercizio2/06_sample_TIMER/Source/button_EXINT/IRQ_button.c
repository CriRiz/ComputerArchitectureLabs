#include "button.h"
#include "LPC17xx.h"


#include "../led/led.h"
#include "../timer/timer.h"

extern volatile uint32_t NUMBER;
volatile uint8_t key1_blocked = 0;

void EINT0_IRQHandler (void)	  	/* INT0														 */
{
	LED_On(0);
	LPC_SC->EXTINT &= (1 << 0);     /* clear pending interrupt         */
}


void EINT1_IRQHandler (void)	  	/* KEY1 */
{
	if (!key1_blocked) {
		key1_blocked = 1;    // blocca rimbalzo

		if (NUMBER > 0) {
			NUMBER--;
		}

		reset_timer(1);
		enable_timer(1);     // TIMER3 = debounce
	}

	LPC_SC->EXTINT = (1 << 1);  // clear interrupt
}


void EINT2_IRQHandler (void)	  	/* KEY2														 */
{
	LED_Off(0);
	LED_Off(1);
  LPC_SC->EXTINT &= (1 << 2);     /* clear pending interrupt         */  
	enable_timer(0);  
}


