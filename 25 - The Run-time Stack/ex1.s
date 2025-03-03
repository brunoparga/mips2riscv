# Write a program to evaluate 3ab - 2bc - 5a + 20ac - 16

# Prompt the user for the values a, b, and c. Try to use a small number of registers. Use the stack to hold intermediate values. Write the final value to the monitor.

	.text
	.globl	main

main:
	la	a0, prompt_a
	li	a7, 4		# print string ecall
	ecall

	li	a7, 5		# read an int (we'll do float later)
	ecall

	mv	t0, a0		# t0 = a


	.data
prompt_a:	.asciiz	"Enter the value for a: "
prompt_b:	.asciiz	"Enter the value for b: "
prompt_c:	.asciiz	"Enter the value for c: "