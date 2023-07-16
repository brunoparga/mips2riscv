# Write a program that computes the sum of the first n terms of the harmonic
# series by using a loop:

# 1/1 + 1/2 + 1/3 + 1/4 + ... + 1/n

# This sum gets bigger and bigger without limit as more terms are added in. Ask
# the user for the number of terms to sum, compute the sum and print it out. Of
# course, you will need to use floating point division.

# There are several ways that this program could be written. The sensible way is
# to use both an integer loop counter that is incremented by integer 1 and a
# separate floating point divisor that is incremented by 1.0 in each loop
# iteration.

		.data
welcome:	.asciiz		"Welcome to the harmonic series sum calculator!\n"
prompt:		.asciiz		"How many terms do you want to sum? "
result:		.asciiz		"The sum is "

# Register use
# $s0 -> N, how many terms to sum
# $t1 -> i, the iteration variable (an integer)
# #f0 -> the double 1.0, to be divided by the divisor
# $f2 -> k, the current divisor (a double whose value is equal to i)
# $f4 -> current sum
# $f6 -> current term

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
	li.d	$f0, 1.0
	li.d	$f2, 0.0
	li.d	$f4, 0.0

loop:
	beq	$s0, $t1, done
	nop
	add.d	$f2, $f2, $f0
	div.d	$f6, $f0, $f2
	add.d	$f4, $f4, $f6
	b	loop
	addiu	$t1, 1

done:
	# Print the result
	li	$v0, 4
	la	$a0, result
	syscall

	li	$v0, 3
	mov.d	$f12, $f4
	# mov.d	$f13, $f5
	syscall

	li	$v0, 10
	syscall
