# Write a program that computes the value of the following arithmetic expression
# for values of x and y entered by the user:

# 5.4xy - 12.3y + 18.23x - 8.23

		.data
promptX:	.asciiz 	"Please enter number x: "
promptY:	.asciiz 	"Now please give number y: "
a:		.float		5.4
bb:		.float		-12.3
c:		.float		18.23
d:		.float		-8.23
expression:	.asciiz		"5.4xy - 12.3y + 18.23x - 8.23 = "

# Register use
# $f2 -> value of the expression
# $f4 -> x
# $f6 -> y
# $f8 -> coefficient
# $t10 -> temporary

		.text
		.globl	main
main:
	# Read in the numbers
	li	$v0, 4
	la	$a0, promptX
	syscall

	li	$v0, 6
	syscall

	mov.s	$f4, $f0		# $f4 <-- X

	li	$v0, 4
	la	$a0, promptY
	syscall

	li	$v0, 6
	syscall

	mov.s	$f6, $f0		# $f6 <-- Y

	# Calculate the expression
	l.s	$f8, a
	mul.s	$f10, $f4, $f6		# tmp = xy
	mul.s	$f2, $f8, $f10		# expression = 5.4xy

	l.s	$f8, bb
	nop				# The load delay could be cleverly
					# exploited, but that hurts readability
	mul.s	$f10, $f6, $f8		# tmp = -12.3y
	add.s	$f2, $f2, $f10		# expression = 5.4xy - 12.3y

	l.s	$f8, c
	nop
	mul.s	$f10, $f4, $f8		# tmp = 18.23x
	add.s	$f2, $f2, $f10		# expression = 5.4xy - 12.3y + 18.23x

	l.s	$f8, d
	nop
	add.s	$f2, $f2, $f8		# expression = 5.4xy - 12.3y + 18.23x - 8.23

	# Print the result
	li	$v0, 4
	la	$a0, expression
	syscall

	li	$v0, 2
	mov.s	$f12, $f2
	nop
	syscall

	li	$v0, 10
	syscall
