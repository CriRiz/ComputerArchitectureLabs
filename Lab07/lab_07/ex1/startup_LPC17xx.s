;/**************************************************************************//**
; * @file     startup_LPC17xx.s
; * @brief    CMSIS Cortex-M3 Core Device Startup File for
; *           NXP LPC17xx Device Series
; * @version  V1.10
; * @date     06. April 2011
; *
; * @note
; * Copyright (C) 2009-2011 ARM Limited. All rights reserved.
; *
; * @par
; * ARM Limited (ARM) is supplying this software for use with Cortex-M
; * processor based microcontrollers.  This file can be freely distributed
; * within development tools that are supporting such ARM based processors.
; *
; * @par
; * THIS SOFTWARE IS PROVIDED "AS IS".  NO WARRANTIES, WHETHER EXPRESS, IMPLIED
; * OR STATUTORY, INCLUDING, BUT NOT LIMITED TO, IMPLIED WARRANTIES OF
; * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE APPLY TO THIS SOFTWARE.
; * ARM SHALL NOT, IN ANY CIRCUMSTANCES, BE LIABLE FOR SPECIAL, INCIDENTAL, OR
; * CONSEQUENTIAL DAMAGES, FOR ANY REASON WHATSOEVER.
; *
; ******************************************************************************/

; *------- <<< Use Configuration Wizard in Context Menu >>> ------------------

; <h> Stack Configuration
;   <o> Stack Size (in Bytes) <0x0-0xFFFFFFFF:8>
; </h>

Stack_Size      EQU     0x00000200

                AREA    STACK, NOINIT, READWRITE, ALIGN=3
Stack_Mem       SPACE   Stack_Size
__initial_sp


; <h> Heap Configuration
;   <o>  Heap Size (in Bytes) <0x0-0xFFFFFFFF:8>
; </h>

Heap_Size       EQU     0x00000000

                AREA    HEAP, NOINIT, READWRITE, ALIGN=3
__heap_base
Heap_Mem        SPACE   Heap_Size
__heap_limit


                PRESERVE8
                THUMB


; Vector Table Mapped to Address 0 at Reset

                AREA    RESET, DATA, READONLY
                EXPORT  __Vectors

__Vectors       DCD     __initial_sp              ; Top of Stack
                DCD     Reset_Handler             ; Reset Handler
                DCD     NMI_Handler               ; NMI Handler
                DCD     HardFault_Handler         ; Hard Fault Handler
                DCD     MemManage_Handler         ; MPU Fault Handler
                DCD     BusFault_Handler          ; Bus Fault Handler
                DCD     UsageFault_Handler        ; Usage Fault Handler
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     SVC_Handler               ; SVCall Handler
                DCD     DebugMon_Handler          ; Debug Monitor Handler
                DCD     0                         ; Reserved
                DCD     PendSV_Handler            ; PendSV Handler
                DCD     SysTick_Handler           ; SysTick Handler

                ; External Interrupts
                DCD     WDT_IRQHandler            ; 16: Watchdog Timer
                DCD     TIMER0_IRQHandler         ; 17: Timer0
                DCD     TIMER1_IRQHandler         ; 18: Timer1
                DCD     TIMER2_IRQHandler         ; 19: Timer2
                DCD     TIMER3_IRQHandler         ; 20: Timer3
                DCD     UART0_IRQHandler          ; 21: UART0
                DCD     UART1_IRQHandler          ; 22: UART1
                DCD     UART2_IRQHandler          ; 23: UART2
                DCD     UART3_IRQHandler          ; 24: UART3
                DCD     PWM1_IRQHandler           ; 25: PWM1
                DCD     I2C0_IRQHandler           ; 26: I2C0
                DCD     I2C1_IRQHandler           ; 27: I2C1
                DCD     I2C2_IRQHandler           ; 28: I2C2
                DCD     SPI_IRQHandler            ; 29: SPI
                DCD     SSP0_IRQHandler           ; 30: SSP0
                DCD     SSP1_IRQHandler           ; 31: SSP1
                DCD     PLL0_IRQHandler           ; 32: PLL0 Lock (Main PLL)
                DCD     RTC_IRQHandler            ; 33: Real Time Clock
                DCD     EINT0_IRQHandler          ; 34: External Interrupt 0
                DCD     EINT1_IRQHandler          ; 35: External Interrupt 1
                DCD     EINT2_IRQHandler          ; 36: External Interrupt 2
                DCD     EINT3_IRQHandler          ; 37: External Interrupt 3
                DCD     ADC_IRQHandler            ; 38: A/D Converter
                DCD     BOD_IRQHandler            ; 39: Brown-Out Detect
                DCD     USB_IRQHandler            ; 40: USB
                DCD     CAN_IRQHandler            ; 41: CAN
                DCD     DMA_IRQHandler            ; 42: General Purpose DMA
                DCD     I2S_IRQHandler            ; 43: I2S
                DCD     ENET_IRQHandler           ; 44: Ethernet
                DCD     RIT_IRQHandler            ; 45: Repetitive Interrupt Timer
                DCD     MCPWM_IRQHandler          ; 46: Motor Control PWM
                DCD     QEI_IRQHandler            ; 47: Quadrature Encoder Interface
                DCD     PLL1_IRQHandler           ; 48: PLL1 Lock (USB PLL)
                DCD     USBActivity_IRQHandler    ; 49: USB Activity interrupt to wakeup
                DCD     CANActivity_IRQHandler    ; 50: CAN Activity interrupt to wakeup


                IF      :LNOT::DEF:NO_CRP
                AREA    |.ARM.__at_0x02FC|, CODE, READONLY
CRP_Key         DCD     0xFFFFFFFF
                ENDIF

				AREA 	|.data|, DATA, READWRITE
					
poor			SPACE	28
good			SPACE	28
mint			SPACE	28					
	
poor_count      DCD     0
good_count      DCD     0
mint_count      DCD     0
							
delta_price		SPACE	112

                AREA    |.text|, CODE, READONLY
					
datas			SPACE 4096
				ALIGN
					
cards			DCD		0x134, 3, 275, 0x2B9, 0xDC, 151, 2087
condition		DCD		2087, 2, 275, 0x0, 308, 0x1, 0xDC, 2, 151, 2, 0x3, 0, 697, 2
purchase_price	DCD		0x3, 2000, 0x113, 2, 151, 9, 0x134, 45, 2087, 17, 220, 5, 697, 350
current_price	DCD		0xDC, 3, 151, 16, 3, 3300, 697, 420, 308, 63, 275, 1, 0x827, 3
n_cards			DCB		7

final_align		SPACE	4096

; Reset Handler

Reset_Handler   PROC
                EXPORT  Reset_Handler             [WEAK]
;                LDR     R0, =Reset_Handler

				MOV		r7, #0	;indexes
				MOV		r8, #0
				MOV		r11, #0
				
loop1			CMP		r7, #14
				BGE		next_step
				
				LDR		r5, =current_price	;address
				LDR		r6, =purchase_price
				
				LDR		r9, [r5, r7, LSL #2]	;vector[index]
				LDR		r10, [r6, r8, LSL #2]
				
				CMP		r9, r10
				BEQ		loop2
				
				CMP		r8, #14
				ADDLT	r8, #2	; go ahead with vector 2
				B		loop1

loop2			
				;compute delta price and store data(id, dprice) in delta_price
				MOV		r0, r5
				MOV		r1, r6
				MOV		r2, r7
				MOV		r3, r8
				MOV		r4, r11
				BL		difference 
				MOV		r11, r4		; update index of delta_price
				
				MOV		r8, #0
				ADD		r7, #2	; go ahead with vector 1
				B		loop1
				
				
next_step		MOV		r7, #0	; condition index
				LDR		r5, =condition
	
loop3			CMP		r7, #14
				BGE		sort_start
				LDR		r6, [r5, r7, LSL #2]	;id
				ADD		r7, #1
				LDR		r11, [r5, r7, LSL #2]	;condition of corresponding id
				
				;function to populate the 3 vectors
				MOV		r0, r6
				CMP		r11, #1
				BLLT	store_poor
				BLEQ	store_good
				BLGT	store_mint
				
				ADD		r7, #1	;go to next id on condition vector
				B		loop3	



sort_start
				;poor
				LDR     r0, =poor_count
				LDR     r0, [r0]        ;number of elements to sort
				LDR     r1, =poor 
				BL      sort_vector
				
				;good
				LDR     r0, =good_count
				LDR     r0, [r0]
				LDR     r1, =good
				BL      sort_vector

				;mint
				LDR     r0, =mint_count
				LDR     r0, [r0]
				LDR     r1, =mint
				BL      sort_vector

find_max_loss
				PUSH    {r4-r6, r9, lr}
				
				LDR     r9, =delta_price
				LDR     r6, =condition
				
				MOV     r5, #0           ;delta_price index
				MOV     r4, #0           ;max loss
				
				MOV     r11, #0
				MOV     r12, #0

loss_loop
				CMP     r5, r11    
				CMP     r5, #28		;max index of 28
				BGE     loss_done
				
				;load current delta_price
				LDR     r2, [r9, r5, LSL #2]	;id
				ADD     r5, #1
				LDR     r3, [r9, r5, LSL #2]	;delta_price
				
				CMP     r3, r4
				BGE     next_loss_card   ;jump if delta > max loss
				
				MOV     r4, r3           ;new max loss
				MOV     r11, r2          ;save id
				
				PUSH    {r2, r3, r4, r5}
				MOV     r0, r2           ;in r0 the id to find
				BL      get_condition
				MOV     r12, r0          ;in r12 the condition
				POP     {r2, r3, r4, r5}
    
next_loss_card
				ADD     r5, #1           ;go to next id
				B       loss_loop

loss_done
				POP     {r4-r6, r9, lr}
				B       done

done			BX      lr
				ENDP	

;functions

difference		PROC
				PUSH	{lr}
				LDR		r11, =delta_price
				
				LDR		r6, [r0, r2, LSL #2]
				STR		r6, [r11, r4, LSL #2]	;save id
				ADD		r4, #1
				
				ADD		r2, #1
				ADD		r3, #1
				LDR		r5, [r0, r2, LSL #2]
				LDR		r6, [r1, r3, LSL #2]

				SUB		r5, r5, r6	;compute delta_price
				STR		r5, [r11, r4, LSL #2]	;store it
				
				POP		{lr}
				BX		lr
				ENDP
					
					
store_poor		PROC
				PUSH	{lr, r5, r6}
				
				LDR		r5, =poor
				LDR		r6, =poor_count
				LDR		r1, [r6]
				
				STR		r0, [r5, r1, LSL #2]
				ADD		r1, #1
				STR		r1, [r6]	;update counter
				
				POP		{lr, r5, r6}
				BX		lr
				ENDP
					
store_good		PROC
				PUSH	{lr, r5, r6}
				
				LDR		r5, =good
				LDR		r6, =good_count
				LDR		r1, [r6]
				
				STR		r0, [r5, r1, LSL #2]
				ADD		r1, #1
				STR		r1, [r6]	;update counter
				
				POP		{lr, r5, r6}
				BX		lr
				ENDP
					
store_mint		PROC
				PUSH	{lr, r5, r6}
				
				LDR		r5, =mint
				LDR		r6, =mint_count
				LDR		r1, [r6]
				
				STR		r0, [r5, r1, LSL #2]
				ADD		r1, #1
				STR		r1, [r6]	;update counter

				POP		{lr, r5, r6}
				BX		lr
				ENDP
					

get_delta       PROC
                PUSH    {r1-r3, lr}
                
                LDR     r9, =delta_price

                MOV     r1, #0		;search index
                
search_loop
                CMP     r1, #28
                BGE     not_found       
                
                LDR     r2, [r9, r1, LSL #2] ;in r2 id of delta_price
                
                CMP     r2, r0
                BEQ     found_delta
                
                ADD     r1, #2          ; next id
                B       search_loop
                
found_delta
                ADD     r1, #1          ;next element
                LDR     r0, [r9, r1, LSL #2] ;load delta_price
                B       delta_done
                
not_found
                MOV     r0, #0
                
delta_done
                POP     {r1-r3, lr}
                BX      lr
                ENDP
					

sort_vector     PROC
                PUSH    {r4-r10, lr}
                
                MOV     r10, r0         ;count N
                MOV     r2, #0          ;index i
                
outer_loop_s
                CMP     r2, r10         ;i < N
                BGE     sort_done
                
                MOV     r3, r2          ; j = i
                
inner_loop_s
				ADD     r3, #1          ; j = i + 1
                CMP     r3, r10         ; j < N
                BGE     next_i
                
                
                ;id A (r5) = vector[j-1]
                MOV     r4, r3
                SUB     r4, #1          ; r4 = j-1
                LDR     r5, [r1, r4, LSL #2] 

                ;id B (r6) = vector[j]
                LDR     r6, [r1, r3, LSL #2] 

                ;find delta price of A
                MOV     r0, r5
                BL      get_delta
                MOV     r7, r0          ; r7 = Delta A

                ;find delta price of B (r8)
                MOV     r0, r6
                BL      get_delta
                MOV     r8, r0          ; r8 = Delta B
                
                ;compare and swap if A > B
                CMP     r7, r8
                BGT     swap_elements   
                
                B       next_j
                
swap_elements
                ; switch id A and id B
                STR     r6, [r1, r4, LSL #2] ;id b in j-1
                STR     r5, [r1, r3, LSL #2] ;id a in j
                
next_j
                ADD     r3, #1          ; j++
                B       inner_loop_s

next_i
                ADD     r2, #1          ; i++
                B       outer_loop_s

sort_done
                POP     {r4-r10, lr}
                BX      lr
                ENDP
					
					
get_condition   PROC
                PUSH    {r1-r3, r6, lr}
                
                LDR     r6, =condition
                MOV     r1, #0          ;search index
                
cond_search_loop
                CMP     r1, #14         ; 14 elements
                BGE     cond_not_found
                
                LDR     r2, [r6, r1, LSL #2] ;id in condition
                
                CMP     r2, r0
                BEQ     cond_found
                
                ADD     r1, #2          ;next id
                B       cond_search_loop
                
cond_found
                ADD     r1, #1          ; next element
                LDR     r0, [r6, r1, LSL #2] ; in r0 condition value
                B       cond_done
                
cond_not_found
                MOV     r0, #0
                
cond_done
                POP     {r1-r3, r6, lr}
                BX      lr
                ENDP
	

; Dummy Exception Handlers (infinite loops which can be modified)

NMI_Handler     PROC
                EXPORT  NMI_Handler               [WEAK]
                B       .
                ENDP
HardFault_Handler\
                PROC
                EXPORT  HardFault_Handler         [WEAK]
                B       .
                ENDP
MemManage_Handler\
                PROC
                EXPORT  MemManage_Handler         [WEAK]
                B       .
                ENDP
BusFault_Handler\
                PROC
                EXPORT  BusFault_Handler          [WEAK]
                B       .
                ENDP
UsageFault_Handler\
                PROC
                EXPORT  UsageFault_Handler        [WEAK]
                B       .
                ENDP
SVC_Handler     PROC
                EXPORT  SVC_Handler               [WEAK]
                B       .
                ENDP
DebugMon_Handler\
                PROC
                EXPORT  DebugMon_Handler          [WEAK]
                B       .
                ENDP
PendSV_Handler  PROC
                EXPORT  PendSV_Handler            [WEAK]
                B       .
                ENDP
SysTick_Handler PROC
                EXPORT  SysTick_Handler           [WEAK]
                B       .
                ENDP

Default_Handler PROC

                EXPORT  WDT_IRQHandler            [WEAK]
                EXPORT  TIMER0_IRQHandler         [WEAK]
                EXPORT  TIMER1_IRQHandler         [WEAK]
                EXPORT  TIMER2_IRQHandler         [WEAK]
                EXPORT  TIMER3_IRQHandler         [WEAK]
                EXPORT  UART0_IRQHandler          [WEAK]
                EXPORT  UART1_IRQHandler          [WEAK]
                EXPORT  UART2_IRQHandler          [WEAK]
                EXPORT  UART3_IRQHandler          [WEAK]
                EXPORT  PWM1_IRQHandler           [WEAK]
                EXPORT  I2C0_IRQHandler           [WEAK]
                EXPORT  I2C1_IRQHandler           [WEAK]
                EXPORT  I2C2_IRQHandler           [WEAK]
                EXPORT  SPI_IRQHandler            [WEAK]
                EXPORT  SSP0_IRQHandler           [WEAK]
                EXPORT  SSP1_IRQHandler           [WEAK]
                EXPORT  PLL0_IRQHandler           [WEAK]
                EXPORT  RTC_IRQHandler            [WEAK]
                EXPORT  EINT0_IRQHandler          [WEAK]
                EXPORT  EINT1_IRQHandler          [WEAK]
                EXPORT  EINT2_IRQHandler          [WEAK]
                EXPORT  EINT3_IRQHandler          [WEAK]
                EXPORT  ADC_IRQHandler            [WEAK]
                EXPORT  BOD_IRQHandler            [WEAK]
                EXPORT  USB_IRQHandler            [WEAK]
                EXPORT  CAN_IRQHandler            [WEAK]
                EXPORT  DMA_IRQHandler            [WEAK]
                EXPORT  I2S_IRQHandler            [WEAK]
                EXPORT  ENET_IRQHandler           [WEAK]
                EXPORT  RIT_IRQHandler            [WEAK]
                EXPORT  MCPWM_IRQHandler          [WEAK]
                EXPORT  QEI_IRQHandler            [WEAK]
                EXPORT  PLL1_IRQHandler           [WEAK]
                EXPORT  USBActivity_IRQHandler    [WEAK]
                EXPORT  CANActivity_IRQHandler    [WEAK]

WDT_IRQHandler
TIMER0_IRQHandler
TIMER1_IRQHandler
TIMER2_IRQHandler
TIMER3_IRQHandler
UART0_IRQHandler
UART1_IRQHandler
UART2_IRQHandler
UART3_IRQHandler
PWM1_IRQHandler
I2C0_IRQHandler
I2C1_IRQHandler
I2C2_IRQHandler
SPI_IRQHandler
SSP0_IRQHandler
SSP1_IRQHandler
PLL0_IRQHandler
RTC_IRQHandler
EINT0_IRQHandler
EINT1_IRQHandler
EINT2_IRQHandler
EINT3_IRQHandler
ADC_IRQHandler
BOD_IRQHandler
USB_IRQHandler
CAN_IRQHandler
DMA_IRQHandler
I2S_IRQHandler
ENET_IRQHandler
RIT_IRQHandler
MCPWM_IRQHandler
QEI_IRQHandler
PLL1_IRQHandler
USBActivity_IRQHandler
CANActivity_IRQHandler

                B       .

                ENDP


                ALIGN


; User Initial Stack & Heap

                IF      :DEF:__MICROLIB

                EXPORT  __initial_sp
                EXPORT  __heap_base
                EXPORT  __heap_limit

                ELSE

                IMPORT  __use_two_region_memory
                EXPORT  __user_initial_stackheap
__user_initial_stackheap

                LDR     R0, =  Heap_Mem
                LDR     R1, =(Stack_Mem + Stack_Size)
                LDR     R2, = (Heap_Mem +  Heap_Size)
                LDR     R3, = Stack_Mem
                BX      LR

                ALIGN

                ENDIF


                END
