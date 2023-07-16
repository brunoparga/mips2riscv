# Write a program that computes the value of a polynomial using Horner's method.
# The coefficients of the polynomial are stored in an array of single precision
# floating point values:

		.data
prompt:		.asciiz		"Please enter the value of x: "
order:		.word  		5
coefficients:	.float 		4.3, -12.4, 6.8, -0.45, 3.6
result:		.asciiz		"The value of the polynomial is "

# Write the program so that the size and the values in the array may be easily
# changed. Initialize a sum to zero and then loop n times. Each execution of the
# loop, with loop counter j, does the following:

# sum = sum * x + a[j]

# To test and debug this program, start with easy values for the coefficients.

# Register use:
# $f0 -> x
# $f1 -> value of the polynomial
# $f2 -> coefficient
# $s0 -> iterator
# $s1 -> the order of the polynomial
# $t0 -> array address


		.text
		.globl	main
main:
	# Prompt for x
	li	$v0, 4
	la	$a0, prompt
	syscall

	li	$v0, 6
	syscall			# Result is already in $f0

	# Initialize values
	li	$s0, 0
	lw	$s1, order
	la	$t0, coefficients
	li.s	$f1, 0.0

loop:
	beq	$s0, $s1, done
	nop
	l.s	$f2, 0($t0)
	addiu	$t0, 4		# move the pointer forward in the array
	mul.s	$f1, $f0, $f1
	add.s	$f1, $f1, $f2
	b	loop
	addiu	$s0, 1		# increment the counter

done:
	li	$v0, 4
	la	$a0, result
	syscall

	li	$v0, 2
	mov.s	$f12, $f1
	syscall

	li	$v0, 11
	li	$a0, '\n'

	li	$v0, 10
	syscall
