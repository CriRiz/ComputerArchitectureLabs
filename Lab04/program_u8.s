.section .data
i: .float 0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0
w: .float 0.5, 0.6, 0.7, 0.8, 0.9, 1.0, 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2.0
b: .word 0xab
m: .word 0x7F800000
y: .space 2 #alloco 2 byte

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
    li x4, 16
    fmv.s.x f0, x0

loop:
    beqz x4, endLoop

    flw f1, 0(x1)
    flw f3, 0(x2)
    fmul.s f4, f1, f3

    flw f5, 4(x1)
    flw f6, 4(x2)
    fmul.s f7, f5, f6

    flw f8, 8(x1)
    flw f9, 8(x2)
    fmul.s f10, f8, f9

    flw f11, 12(x1)
    flw f12, 12(x2)
    fmul.s f13, f11, f12

    flw f14, 16(x1)
    flw f15, 16(x2)
    fmul.s f16, f14, f15

    flw f17, 20(x1)
    flw f18, 20(x2)
    fmul.s f19, f17, f18

    flw f20, 24(x1)
    flw f21, 24(x2)
    fmul.s f22, f20, f21

    flw f23, 28(x1)
    flw f24, 28(x2)
    fmul.s f25, f23, f24

    addi x1, x1, 32
    addi x2, x2, 32
    addi x4, x4, -8

    fadd.s f26, f4, f7
    fadd.s f27, f10, f13
    fadd.s f28, f16, f19
    fadd.s f29, f22, f25

    fadd.s f30, f26, f27
    fadd.s f31, f28, f29
    fadd.s f6, f30, f31

    fadd.s f0, f0, f6

    j loop

endLoop:
    fadd.s f0, f0, f2

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
