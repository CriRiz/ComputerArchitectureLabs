.section .data
i: .float 0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0
w: .float 0.5, 0.6, 0.7, 0.8, 0.9, 1.0, 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2.0
b: .float 0xab

.section .text
.global _start

_start:
    la t0, i # indirizzo base di i
    la t1, w # indirizzo base di w
    la t2, b # indirizzo di b
    flw f2, 0(t2) # carica b in f2
    li t3, 16 # contatore = 16 elementi
    li t4, 0xFF # valore di confronto
    fmv.s.x f0, x0 # accumulatore y = 0.0

loop:
    beqz t3, end # se contatore == 0 fine
    beq t3, t4, equal # se contatore == 0xFF vai a equal

    flw f1, 0(t0) # f1 = i[n]
    flw f3, 0(t1) # f3 = w[n]
    fmul.s f4, f1, f3 # f4 = i * w
    fadd.s f4, f4, f2 # f4 = i*w + b
    fadd.s f0, f0, f4 # y += (i*w + b)

    addi t0, t0, 4
    addi t1, t1, 4
    addi t3, t3, -1
    j loop

equal:
    fmv.s.x f0, x0 # y = 0.0
    addi t3, t3, -1
    j loop

end:
    li a0, 0
    li a7, 93
    ecall
