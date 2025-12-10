#ifndef LFSR_H
#define LFSR_H

extern unsigned char lfsr_state;
extern unsigned char taps;
extern int output_bit;

extern unsigned char lfsr_step(unsigned char current_state,
                               unsigned char taps,
                               int *output_bit);

#endif
