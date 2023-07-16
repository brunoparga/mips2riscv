## horner.asm -- compute ax^2 + bx + c for user-input x
##

	.text
	.globl main

	# Register Use Chart
	# $f0 -- x
	# $f2 -- sum of terms

main:	# read input
	la	$a0, prompt	# prompt user for x
	li	$v0, 4		# print string
	syscall

	li	$v0, 7		# read double
	syscall			# $f0 <-- x

	# evaluate the quadratic
	l.d	$f2, a		# sum = a
	nop
	mul.d	$f2, $f2, $f0	# sum = ax
	l.d	$f4, bb		# get b
	nop
	add.d	$f2, $f2, $f4	# sum = ax + b
	mul.d	$f2, $f2, $f0	# sum = (ax+b)x = ax^2 +bx
	l.d	$f4, c		# get c
	nop
	add.d	$f2, $f2, $f4	# sum = ax^2 + bx + c

	# print the result
	mov.d	$f12, $f2	# $f12 = argument
	li	$v0, 3		# print double
	syscall

	la	$a0, newl	# new line
	li	$v0, 4		# print string
	syscall

	li	$v0, 10		# code 10 == exit
	syscall			# Return to OS.

##
##  Data Segment
##
	.data
a:      .double  1.0
bb:     .double  1.0
c:      .double  1.0

prompt: .asciiz "Enter x: "
blank:  .asciiz " "
newl:   .asciiz "\n"
