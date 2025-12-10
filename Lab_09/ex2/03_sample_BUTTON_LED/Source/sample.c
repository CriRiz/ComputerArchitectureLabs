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

/* my code */
/* LFSR variables */
unsigned char tap_mask = 0x00;   // editor dei taps
unsigned char taps     = 0x00;   // maschera effettiva
unsigned char seed     = 0xAA;   // seed fisso
int output_bit         = 0;
volatile int edit_mode = 1;


/* Prototipo della funzione assembly */
extern unsigned char lfsr_step(unsigned char current_state,
                               unsigned char taps,
                               int *output_bit);



/*----------------------------------------------------------------------------
  Main Program
 *----------------------------------------------------------------------------*/
int main(void) {
    SystemInit();
    LED_init();
    LED_Out(0x00);   // mostra tap_mask iniziale
    BUTTON_init();

    while (1) {
    }
}

