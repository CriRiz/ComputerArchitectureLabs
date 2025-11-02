.section .data
i: .float 0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0
w: .float 0.5, 0.6, 0.7, 0.8, 0.9, 1.0, 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2.0
b: .word 0xab
m: .word 0x7F800000
y: .space 4 #alloco 4 byte

.section .text
.global _start

_start:
    la x1, i # indirizzo base di i
    la x2, w # indirizzo base di w
    la x3, b # indirizzo di b
    la x16, m # maschera
    la x31, y # output
    lw x5, 0(x16)
    flw f2, 0(x3) # carica b in f2
    li x4, 16 # contatore = 16 elementi
    fmv.s.x f0, x0 # accumulatore x = 0.0

loop:
    beqz x4, endLoop # se contatore == 0 fine
    #beqz x4, endLoop # se contatore == 0 fine

    flw f1, 0(x1) # f1 = i[n]
    flw f3, 0(x2) # f3 = w[n]
    fmul.s f4, f1, f3 # f4 = i * w

    #-----------------------------------ottimizzazione
    addi x1, x1, 4  # incremento indirizzo di i
    addi x2, x2, 4  # incremento indirizzo di w
    addi x4, x4, -1 # decremento contatore loop
    #-----------------------------------

    fadd.s f0, f0, f4 # x += (i*w)

    j loop

endLoop:
    fadd.s f0, f0, f2   # x += b
    
    # qui implemento y = f(x)
    # 1 bit segno| 8 bit esponente| 23 bit mantissa

    fmv.x.w x6, f0      # copio i bits del float in x6
    and x10, x6, x5     # tiro fuori l'esponente
    srli x10, x10, 23   # shift a destra di 23 (dove c'era la mantissa)
    beq x10, x30, if 

    add x11, x0, x10 
    j end

if: # se l'esponente = 0xFF

    addi x11, x0, 0x00000000

end:
    sw x11, 0(x31) # salvo y in memoria
    li a0, 0
    li a7, 93
    ecall


