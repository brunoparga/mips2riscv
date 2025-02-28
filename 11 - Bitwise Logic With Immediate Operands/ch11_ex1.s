## Mysterious vanishing pattern
## 
        .text
        .globl  main

main:
        lui     t0, 0x2BAD          # put a pattern into t0
        lui	t1, 0xF3C5
        xor     t0, t0, t1          # mess it up with a xor
        xor     t0, t0, t1          # what immediate operand will 
                                    # restore the original pattern in t0 ?
                                 
exit:
	li	a7, 10
	ecall
