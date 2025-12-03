		AREA |.text|, CODE, READONLY
		
		EXPORT lfsr_step

;unsigned char lfsr_step(unsigned char current_state, unsigned char taps, int *output_bit) r0, r1, r2
lfsr_step
	MOV r3, #0
	MOV r4, #0
loop	

	CMP r3, #8
	BEQ end_l		;contatore i
	
	LSR r5, r1, r3	;shifto a dx il tab per trovare quali bit devo considerare
	AND r5, r5, #1
	CMP r5, #0
	BEQ next		;se il bit è a 0 allora salto
	
	LSR r5, r0, r3	;faccio shift a dx di current_state per avere il bit richiesto al LSB
	AND r5, r5, #1	;maschera per avere solo LSB
	EOR r4, r4, r5
	
next
	ADD r3, r3, #1	;incremento contatore i
	B loop	
	

end_l

	STR r4, [r2]	;salva risultato dello store nell'indirizzo output_bit
	LSL r4, r4, #7
	LSR r0, r0, #1
	ORR r0, r0, r4
	
	BX lr
		END