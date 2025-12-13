# 1 "Source/systick/IRQ_systick.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 404 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "Source/systick/IRQ_systick.c" 2
# 1 "Source/systick\\systick.h" 1
# 1 "D:\\programmi_installati\\Keil\\Core\\ARM\\ARMCLANG\\bin\\..\\include\\stdint.h" 1 3
# 56 "D:\\programmi_installati\\Keil\\Core\\ARM\\ARMCLANG\\bin\\..\\include\\stdint.h" 3
typedef signed char int8_t;
typedef signed short int int16_t;
typedef signed int int32_t;
typedef signed long long int int64_t;


typedef unsigned char uint8_t;
typedef unsigned short int uint16_t;
typedef unsigned int uint32_t;
typedef unsigned long long int uint64_t;





typedef signed char int_least8_t;
typedef signed short int int_least16_t;
typedef signed int int_least32_t;
typedef signed long long int int_least64_t;


typedef unsigned char uint_least8_t;
typedef unsigned short int uint_least16_t;
typedef unsigned int uint_least32_t;
typedef unsigned long long int uint_least64_t;




typedef signed int int_fast8_t;
typedef signed int int_fast16_t;
typedef signed int int_fast32_t;
typedef signed long long int int_fast64_t;


typedef unsigned int uint_fast8_t;
typedef unsigned int uint_fast16_t;
typedef unsigned int uint_fast32_t;
typedef unsigned long long int uint_fast64_t;






typedef signed int intptr_t;
typedef unsigned int uintptr_t;



typedef signed long long intmax_t;
typedef unsigned long long uintmax_t;
# 2 "Source/systick\\systick.h" 2

void systick_init(uint32_t TimerInterval);
void SysTick_Handler(void);
# 2 "Source/systick/IRQ_systick.c" 2
# 1 "./Source/led\\led.h" 1
# 11 "./Source/led\\led.h"
extern volatile unsigned char led_value;


void LED_init(void);
void LED_deinit(void);


void LED_On (unsigned int num);
void LED_Off (unsigned int num);
void LED_Out(unsigned int value);
# 3 "Source/systick/IRQ_systick.c" 2

void SysTick_Handler(void)
{
 static int position = 0;
 LED_Off(position);
 if(position == 7)
  position = 2;
 else
  position++;
 LED_On(position);
}
