# Write a program that computes the sum of the first n terms of this series:

# 1/2 + 1/4 + 1/8 + 1/16 + ... + 1/2n
# Unlike the previous series, this one converges. For large n the sum is very
# close to one. Ask the user for a number of terms to sum, compute the sum and
# print it out.

# As above, there are several ways that this program could be written. Try to
# find a sensible way to do it.



		.data
welcome:	.asciiz		"Welcome to the Zeno's series sum calculator!\n"
prompt:		.asciiz		"How many powers of 1/2 do you want to sum? "
result:		.asciiz		"The sum is "

# Register use
# $s0 -> N, how many terms to sum
# $t1 -> i, the iteration variable (an integer)
# $f0 -> current sum
# $f2 -> current term
# $f4 -> the double 2.0, to generate the next term

		.text
		.globl	main
main:
	# Welcome the user
	li	$v0, 4
	la	$a0, welcome
	syscall

	# Prompt for the number of terms to sum
	li	$v0, 4
	la	$a0, prompt
	syscall

	li	$v0, 5
	syscall

	# Store answer and initialize necessary values
	move	$s0, $v0
	li	$t1, 0
	li.d	$f0, 0.0
	li.d	$f2, 1.0
	li.d	$f4, 2.0

loop:
	beq	$s0, $t1, done
	nop
	div.d	$f2, $f2, $f4
	add.d	$f0, $f0, $f2
	b	loop
	addiu	$t1, 1

done:
	# Print the result
	li	$v0, 4
	la	$a0, result
	syscall

	li	$v0, 3
	mov.d	$f12, $f0
	syscall

	li	$v0, 10
	syscall
