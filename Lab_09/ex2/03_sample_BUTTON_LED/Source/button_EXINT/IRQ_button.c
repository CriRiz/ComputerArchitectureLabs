#include "button.h"
#include "LPC17xx.h"

#include "../led/led.h"
#include "../lfsr.h"

//void EINT0_IRQHandler (void)	  
//{
//	LED_On(0);
//  LPC_SC->EXTINT &= (1 << 0);     /* clear pending interrupt         */
//}
void EINT0_IRQHandler(void) {
    if (edit_mode) {
        tap_mask ^= 0x01;          // toggle bit0
        LED_Out(tap_mask);
    } else {
        tap_mask = 0x00;           // reset
        LED_Out(0x00);
        edit_mode = 1;
    }
    LPC_SC->EXTINT = (1 << 0);
}



//void EINT1_IRQHandler (void)	  
//{
//  LED_On(1);
//	LPC_SC->EXTINT &= (1 << 1);     /* clear pending interrupt         */
//}

/* my code */
//void EINT1_IRQHandler(void) {
//    if (edit_mode) {
//        tap_mask <<= 1;
//        LED_Out(tap_mask);
//    }
//    LPC_SC->EXTINT = (1 << 1);
//}

void EINT1_IRQHandler(void) {
    LPC_SC->EXTINT = (1 << 1);   // clear
		volatile int i = 0;
    for (i; i < 100000; i++);	/* debounce */
    if (!(LPC_GPIO2->FIOPIN & (1 << 11))) {
        if (edit_mode) {
            tap_mask <<= 1;            // shift della maschera
            LED_Out(tap_mask);
        } else {
            // nothing
        }
    }
}

//void EINT2_IRQHandler (void)	  
//{
//	LED_Off(0);
//	LED_Off(1);
//  LPC_SC->EXTINT &= (1 << 2);     /* clear pending interrupt         */    
//}
void EINT2_IRQHandler(void) {
    if (edit_mode) {
        taps = tap_mask;
        unsigned char state = seed;
        int length = 0;

        do {
            state = lfsr_step(state, taps, &output_bit);
            length++;
        } while (state != seed && state != 0);

        LED_Out(length & 0xFF);    // mostra lunghezza (mod 256)
        edit_mode = 0;             // passa in result mode
    }
    LPC_SC->EXTINT = (1 << 2);
}


