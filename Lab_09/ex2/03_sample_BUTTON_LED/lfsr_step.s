        AREA lfsr_code, CODE, READONLY
        EXPORT lfsr_step

lfsr_step
        PUSH {r4-r6, lr}

        ; r0 = current_state
        ; r1 = taps
        ; r2 = output_bit (pointer)

        ; salva LSB come output_bit
        AND r3, r0, #1
        STR r3, [r2]

        ; calcola feedback = XOR di tutti i taps
        AND r4, r0, r1      ; r4 = solo i bit dei taps
        MOV r5, #0          ; accumulatore parity

loop_xor
        TST r4, #1          ; controlla bit0
        EORNE r5, r5, #1    ; se 1, flip parity
        MOV r4, r4, LSR #1  ; shift a destra
        CMP r4, #0
        BNE loop_xor

        ; ora r5 contiene il feedback (0 o 1)

        ; shift a destra e inserisci feedback in MSB
        MOV r0, r0, LSR #1
        ORR r0, r0, r5, LSL #7

        POP {r4-r6, pc}
        END
