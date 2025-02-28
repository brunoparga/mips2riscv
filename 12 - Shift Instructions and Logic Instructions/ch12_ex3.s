# Start a program with the instruction that puts a single one-bit into register one:

# ori   x1, x0, 1
# Now, by using only shift instructions and register to register logic instructions, put the pattern 0xFFFFFFFF into register $1. Don't use another ori after the first. You will need to use more registers than $1. See how few instructions you can do this in. My program has 11 instructions.

        .text
        .globl  main

main:
        ori     x1, x0, 1       # x1 = 0b0001           # CONSTANT ONE
        sll     x2, x1, x1      # x2 = 0b0010 = 2       # n; shift amount
        or      x3, x2, x1      # x3 = 0b0011           # 2n ones

        sll     x4, x3, x2      # x4 = 0b1100
        sll     x2, x2, x1      # x2 = 4
        or      x3, x4, x3      # x3 = 0b1111

        sll     x4, x3, x2      # x4 = 0b1111_0000
        sll     x2, x2, x1      # x2 = 8
        or      x3, x4, x3      # x3 = 0b1111_1111

        sll     x4, x3, x2      # x4 = 0b1111_1111_0000_0000
        sll     x2, x2, x1      # x2 = 16
        or      x3, x4, x3      # x3 = 0b1111_1111_1111_1111

        sll     x4, x3, x2      # x4 = 0b1111_1111_1111_1111_0000_0000_0000_0000
        or      x1, x4, x3      # x1 = 0b1111_1111_1111_1111_1111_1111_1111_1111
        sll     x0, x0, x0      # nop to see the result in the simulator

# Note: in MIPS, sll takes an immediate as the third operand; sllv is the
# instruction to use a register as the shift amount. RISC-V maintains
# consistency with operations like add/addi and or/ori, and has the slli
# instruction take an immediate, while sll takes # two registers. Using slli
# one can reproduce the 11-instruction MIPS code.

# A bug in MIPS that allowed to solve this problem in two instructions –
# including the original ori – was patched in RISC-V.
