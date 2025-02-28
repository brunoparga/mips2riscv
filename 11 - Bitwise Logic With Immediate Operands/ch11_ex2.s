## Sixteen bit negative
## 
        .text
        .globl  main

main:
        ori     t0, zero ,0x001     # put a one into a register $11
        ori     t1, zero, 0x009     # put a nine into $10 
        xori    t2, t1,   -1        # reflect the bits        # 0xFFFF is too big; -1 gets sign-extended into all Fs
        add	t2, t2, t0          # add one
        add     t0, t1, t2          # Add positive nine and negative 
