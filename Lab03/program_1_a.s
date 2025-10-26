    .section .data

# 32 numeri float per ciascun vettore
V1: .float 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0, 17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0

V2: .float 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0, 17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0

V3: .float 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0, 17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0

V4: .space 128      # 32 * 4 byte
V5: .space 128
V6: .space 128

	.section .text
	.global _start

_start:
	# Indirizzi di base
	la x1, V1
	la x2, V2
	la x3, V3
	la x4, V4
	la x5, V5
	la x6, V6

	li x7, 32		#indice i del loop
	li x8, 3		#per la condizione dell'if
	li x9, 1		#per la condiziona dell'if
	li x20, 1		#variabile m

loop:
	beqz x7, end        # se x7 == 0, esci

	flw f1, 0(x1)       	# f1 = V1[i]

	rem x10, x7, x8		# x7%x8 = x10; i%3
	beq x10, x9, if		# (i is a multiple of 3)
	j else
if:
	#x28, f28, f29 è la variabile a
	sll x28, x20, x7	# m << i, è il logic shift
	fcvt.s.w f28, x28	# converto in float il numero intermedio x28
	fdiv.s f29, f1, f28	# v1[i]/f28

	#---------------------------------------
	flw f2, 0(x2)       	# f2 = V2[i]
	flw f3, 0(x3)       	# f3 = V3[i]
	#---------------------------------------

	fcvt.w.s x20, f29	# m = (int) a
	j endif


else:
	#x28, f28 è la variabile a
	mul x28, x20, x7	# m*i
	fcvt.s.w f28, x28	# converto in float il numero intermedio x28
	fmul.s f29, f1, f28	# v1[i]*f28

	#---------------------------------------
	flw f2, 0(x2)       	# f2 = V2[i]
	flw f3, 0(x3)       	# f3 = V3[i]
	#---------------------------------------

	fcvt.w.s x20, f29	# m = (int) a

endif:
	# uso il registro f14 come appoggio

	# V4[i] = a*V1[i] - V2[i]
    	fmul.s f14, f28, f1   	# f14 = a * v1

    	#---------------------------------------
    	addi x1, x1, 4		# avanzamento V1
    	addi x2, x2, 4		# avanzamento V2
    	#---------------------------------------

    	fsub.s f4, f14, f2   	# f4 = f4 - v2
    	fsw f4, 0(x4)       	# salva in V4

    	# V5[i] = V4[i]/V3[i] - b
    	fdiv.s f14, f4, f3   	# f5 = v4 / v3

    	#---------------------------------------
    	addi x3, x3, 4		# avanzamento V3
    	addi x4, x4, 4		# avanzamento V4
    	#---------------------------------------

    	fsub.s f5, f14, f31   	# f5 = f5 - b
    	fsw f5, 0(x5)

    	# V6[i] = (V4[i] - V1[i]) * V5[i]
    	fsub.s f14, f4, f1   # f6 = v4 - v1
    	fmul.s f6, f14, f5   # f6 = f6 * v5

    	#---------------------------------------
    	addi x5, x5, 4		# avanzamento V5
    	addi x6, x6, 4		# avanzamento V6
    	#---------------------------------------

    	fsw f6, 0(x6)		# aggiornamento i

    	addi x7, x7, -1
    	j loop


end:
	# exit(0)
	li a0, 0
	li a7, 93
	ecall
