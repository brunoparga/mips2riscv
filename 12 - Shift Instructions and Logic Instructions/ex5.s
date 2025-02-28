# Put the bit pattern 0x0000FACE into register $1. This is just an example pattern; assume that $1 can start out with any pattern at all in the low 16 bits (but assume that the high 16 bits are all zero).

# Now, using only register-to-register logic and shift instructions, rearrange the bit pattern so that register $2 gets the bit pattern 0x0000CAFE.

# Write this program so that after the low 16 bits of $1 have been set up with any bit pattern, no matter what bit pattern it is, the nibbles in $2 are the same rearrangement of the nibbles of $1 shown with the example pattern. For example, if $1 starts out with 0x00003210 it will end up with the pattern 0x00001230

# A. Moderately Easy program: do this using ori instructions to create masks, then use and and or instructions to mask in and mask out the various nibbles. You will also need shift instructions.

# B. Somewhat Harder program: Use only and, or, and shift instructions.

        .text
        .globl  main

main:
        # MIPS divides its bits 16:16; RISC divides 20:12. So to load the
        # pattern 0xFACE into a register we need several more instructions with
        # RISC-V than MIPS.
        lui     t2, 0xF
        ori     t1, x0, 0x567   # The largest (signed) immediate that can be
                                # used here is 0x7FF, or 0b1010_1100_1110.
        slli    t1, t1, 1       # So we load it shifted by one to the right
                                # and manually unshift it here.
        or      t0, t2, t1      # t0 = 0xFACE

        # We're doing this with maximum effort; so we're using only and, or and
        # shift instructions (slli and friends)
        slli    t2, t2, 16      # t2 = 0xF000_0000
        srai    t2, t2, 28      # t2 = 0xFFFF_FFFF

        srli    t3, t2, 28      # t3 = 0xF    -> mask for the first nybble
        slli    t4, t3, 4       # t4 = 0xF0   -> mask for the second nybble
        slli    t5, t4, 4       # t5 = 0xF00  -> mask for the third nybble
        slli    t6, t5, 4       # t4 = 0xF000 -> mask for the fourth nybble

        and     t1, zero, zero
        and     t2, zero, zero  # zero the registers t1 and t2 to work with

        and     t1, t0, t3      # set the unchanged first nybble from t0

        and     t2, t0, t4      # pick only the second nybble
        slli    t2, t2, 8       # old second nybble is now fourth
        or      t1, t1, t2      # t1 has the first and fourth nybbles correct

        and     t2, t0, t5      # pick only the third nybble
        or      t1, t1, t2      # t1 has nybbles 1, 3 and 4

        and     t2, t0, t6      # pick the fourth nybble
        srli    t2, t2, 8       # old fourth nybble is now second
        or      t1, t1, t2      # t1 has all nybbles correct

        or      t0, zero, t1    # copy the transformed pattern into t0, the
                                # source register

exit:
        li      a0, 10          # The Venus simulator takes the code for the
        ecall                   # environment call from register a0; 10 = exit.
