    .section .data

# 32 numeri float per ciascun vettore
V1: .float 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0, 17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0
V2: .float 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0, 17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0
V3: .float 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0, 17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0

V4: .space 128
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

    li x7, 32        # contatore elementi totali
    li x8, 3         # per il controllo (i % 3)
    li x9, 1         # confronto per l’if
    li x20, 1        # variabile m

# ============================================================
# LOOP PRINCIPALE (unrolling ×2)
# ============================================================
loop:
    blez x7, end             # se x7 <= 0 esci

    # ========================================================
    # --- ELEMENTO i ---
    # ========================================================

    flw f1, 0(x1)            # f1 = V1[i]

    rem x10, x7, x8          # x10 = i % 3
    beq x10, x9, if_i
    j else_i

if_i:
    # se i % 3 == 1
    sll x28, x20, x7         # x28 = m << i
    fcvt.s.w f28, x28        # f28 = (float) x28
    fdiv.s f29, f1, f28      # f29 = V1[i] / f28
    flw f2, 0(x2)
    flw f3, 0(x3)
    fcvt.w.s x20, f29        # m = (int)a
    j cont_i

else_i:
    mul x28, x20, x7         # x28 = m * i
    fcvt.s.w f28, x28        # f28 = (float) x28
    fmul.s f29, f1, f28      # f29 = V1[i] * f28
    flw f2, 0(x2)
    flw f3, 0(x3)
    fcvt.w.s x20, f29        # m = (int)a

cont_i:
    # V4[i] = a*V1[i] - V2[i]
    fmul.s f14, f28, f1
    fsub.s f4, f14, f2
    fsw f4, 0(x4)

    # V5[i] = V4[i]/V3[i] - b
    fdiv.s f14, f4, f3
    fsub.s f5, f14, f31
    fsw f5, 0(x5)

    # V6[i] = (V4[i] - V1[i]) * V5[i]
    fsub.s f14, f4, f1
    fmul.s f6, f14, f5
    fsw f6, 0(x6)


    # ========================================================
    # --- ELEMENTO i+1 (unrolled) ---
    # ========================================================

    flw f7, 4(x1)            # f7 = V1[i+1]

    addi x11, x7, -1         # x11 = i+1
    rem x12, x11, x8         # x12 = (i+1) % 3
    beq x12, x9, if_i1
    j else_i1

if_i1:
    sll x28, x20, x11
    fcvt.s.w f28, x28
    fdiv.s f29, f7, f28
    flw f2, 4(x2)
    flw f3, 4(x3)
    fcvt.w.s x20, f29
    j cont_i1

else_i1:
    mul x28, x20, x11
    fcvt.s.w f28, x28
    fmul.s f29, f7, f28
    flw f2, 4(x2)
    flw f3, 4(x3)
    fcvt.w.s x20, f29

cont_i1:
    fmul.s f14, f28, f7
    fsub.s f4, f14, f2
    fsw f4, 4(x4)

    fdiv.s f14, f4, f3
    fsub.s f5, f14, f31
    fsw f5, 4(x5)

    fsub.s f14, f4, f7
    fmul.s f6, f14, f5
    fsw f6, 4(x6)

    # ========================================================
    # --- Avanzamento puntatori ---
    # ========================================================

    addi x1, x1, 8      # +2 float
    addi x2, x2, 8
    addi x3, x3, 8
    addi x4, x4, 8
    addi x5, x5, 8
    addi x6, x6, 8

    addi x7, x7, -2     # due elementi processati
    j loop

# ============================================================
# USCITA
# ============================================================
end:
    li a0, 0
    li a7, 93
    ecall
