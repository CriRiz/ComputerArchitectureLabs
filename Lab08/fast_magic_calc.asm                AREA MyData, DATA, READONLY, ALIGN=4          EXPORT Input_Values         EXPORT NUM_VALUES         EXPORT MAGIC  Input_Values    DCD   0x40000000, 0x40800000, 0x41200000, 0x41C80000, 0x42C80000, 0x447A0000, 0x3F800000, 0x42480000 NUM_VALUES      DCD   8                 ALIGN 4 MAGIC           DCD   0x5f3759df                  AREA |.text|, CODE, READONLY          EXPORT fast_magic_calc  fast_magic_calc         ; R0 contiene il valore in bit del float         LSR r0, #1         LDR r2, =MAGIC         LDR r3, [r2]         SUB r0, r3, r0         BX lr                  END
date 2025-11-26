                AREA MyData, DATA, READONLY, ALIGN=4

        EXPORT Input_Values
        EXPORT NUM_VALUES
        EXPORT MAGIC

Input_Values    DCD   0x40000000, 0x40800000, 0x41200000, 0x41C80000, 0x42C80000, 0x447A0000, 0x3F800000, 0x42480000
NUM_VALUES      DCD   8
                ALIGN 4
MAGIC           DCD   0x5f3759df

                AREA |.text|, CODE, READONLY

        EXPORT fast_magic_calc

fast_magic_calc
        ; R0 contiene il valore in bit del float
        LSR r0, #1
        LDR r2, =MAGIC
        LDR r3, [r2]
        SUB r0, r3, r0
        BX lr

                END
