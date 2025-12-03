/*----------------------------------------------------------------------------
 * Name:    sample.c
 * Purpose: to control led through EINT buttons 
 *        	- key1 switches on LED10 
 *				  - key2 switches off all LEDs 
 *			    - int0 switches on LED 11
 * Note(s): this version supports the LANDTIGER Emulator
 * Author: 	Paolo BERNARDI - PoliTO - last modified 07/12/2020
 *----------------------------------------------------------------------------
 *
 * This software is supplied "AS IS" without warranties of any kind.
 *
 * Copyright (c) 2017 Politecnico di Torino. All rights reserved.
 *----------------------------------------------------------------------------*/
                  
#include <stdio.h>
#include "LPC17xx.H"                    /* LPC17xx definitions                */
#include "led/led.h"
#include "button_EXINT/button.h"

/* Led external variables from funct_led */
extern unsigned char led_value;					/* defined in funct_led								*/
#ifdef SIMULATOR
extern uint8_t ScaleFlag; // <- ScaleFlag needs to visible in order for the emulator to find the symbol (can be placed also inside system_LPC17xx.h but since it is RO, it needs more work)
#endif

/*----------------------------------------------------------------------------
  Main Program
 *----------------------------------------------------------------------------*/
int main (void) {
  
  SystemInit();  												/* System Initialization (i.e., PLL)  */
  LED_init();                           /* LED Initialization                 */
  BUTTON_init();												/* BUTTON Initialization              */
	int i;
	unsigned char current_state = 0b00011101;
	unsigned char taps = 0b00011101;
	unsigned char feedback = 0b00000000;
	while(1){
		int *output_bit; 
		unsigned char state = ((((current_state & 0b00000001)^(current_state >> 2 & 0b00000001))^(current_state >> 3 & 0b00000001))^(current_state >> 4 & 0b00000001));
		*output_bit = current_state & 0b00000001; // bit meno significativo
		current_state = current_state >> 1; // shift di 1
		current_state = current_state | (state << 7); // valore aggiornato
		
		
		
		LED_Out(current_state);
		for (i = 0; i < 100000000; i++); // delay
	}
	
	
	while (1) {                           /* Loop forever                       */	
  }

}
