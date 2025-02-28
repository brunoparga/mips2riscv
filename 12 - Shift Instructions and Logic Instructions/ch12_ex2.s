# In each register $1 through $7 set the corresponding bit. That is, in register 1 set bit 1 (and clear the rest to zero), in $2 set bit 2 (and clear the rest to zero), and so on. Use only one ori instruction in your program, to set the bit in register $1.

# ori   $1,$0,0x01
# Don't use any ori instructions other than that one. Note: bit 1 of a register is the second from the right, the one that (in unsigned binary) corresponds to the first power of two.

	.text
	.globl	main

main:
	ori	t0, x0, 1
	sll	t1, t0, t0
	sll	t2, t1, t0
	sll	t3, t2, t0
	sll	t4, t3, t0
	sll	t5, t4, t0
	sll	t6, t5, t0
