## Program to add two plus three 
        .text
        .globl  main

main:
	li	t0, 0x2
	li 	t1, 0x3
	add	t2, t0, t1
	
exit:
	li	a7, 10
	ecall

## End of file
