.section .data
i: .float 0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0
w: .float 0.5, 0.6, 0.7, 0.8, 0.9, 1.0, 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2.0
b: .word 0xab
m: .word 0x7F800000
y: .space 2

.section .text
.global _start

_start:
    la x1, i
    la x2, w
    la x3, b
    la x16, m
    la x31, y
    lw x5, 0(x16)
    flw f2, 0(x3)
    fmv.s.x f0, x0

    # Caricamento e moltiplicazione
    flw f1, 0(x1)
    flw f2, 0(x2)
    fmul.s f3, f1, f2

    flw f4, 4(x1)
    flw f5, 4(x2)
    fmul.s f6, f4, f5

    flw f7, 8(x1)
    flw f8, 8(x2)
    fmul.s f9, f7, f8

    flw f10, 12(x1)
    flw f11, 12(x2)
    fmul.s f12, f10, f11

    flw f13, 16(x1)
    flw f14, 16(x2)
    fmul.s f15, f13, f14

    flw f16, 20(x1)
    flw f17, 20(x2)
    fmul.s f18, f16, f17

    flw f19, 24(x1)
    flw f20, 24(x2)
    fmul.s f21, f19, f20

    flw f22, 28(x1)
    flw f23, 28(x2)
    fmul.s f24, f22, f23

    flw f25, 32(x1)
    flw f26, 32(x2)
    fmul.s f27, f25, f26

    flw f28, 36(x1)
    flw f29, 36(x2)
    fmul.s f30, f28, f29

    flw f31, 40(x1)
    flw f6, 40(x2)
    fmul.s f7, f31, f6

    flw f8, 44(x1)
    flw f9, 44(x2)
    fmul.s f10, f8, f9

    flw f11, 48(x1)
    flw f12, 48(x2)
    fmul.s f13, f11, f12

    flw f14, 52(x1)
    flw f15, 52(x2)
    fmul.s f16, f14, f15

    flw f17, 56(x1)
    flw f18, 56(x2)
    fmul.s f19, f17, f18

    flw f20, 60(x1)
    flw f21, 60(x2)
    fmul.s f22, f20, f21

    # Somma dei prodotti
    fadd.s f23, f3, f6
    fadd.s f24, f9, f12
    fadd.s f25, f15, f18
    fadd.s f26, f21, f24
    fadd.s f27, f27, f30
    fadd.s f28, f7, f10
    fadd.s f29, f13, f16
    fadd.s f30, f19, f22

    fadd.s f31, f23, f24
    fadd.s f6, f25, f26
    fadd.s f7, f27, f28
    fadd.s f8, f29, f30

    fadd.s f9, f31, f6
    fadd.s f10, f7, f8
    fadd.s f11, f9, f10

    fadd.s f0, f0, f11
    fadd.s f0, f0, f2

    # Conversione finale
    fmv.x.w x6, f0
    and x10, x6, x5
    srli x10, x10, 23
    beq x10, x30, if

    add x11, x0, x10
    j end

if:
    addi x11, x0, 0x00000000

end:
    sw x11, 0(x31)
    li a0, 0
    li a7, 93
    ecall
