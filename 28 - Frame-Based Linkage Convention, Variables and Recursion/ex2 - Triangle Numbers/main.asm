# Write a program that computes the value of triangle numbers using a recursive
# subroutine. The definition of triangle numbers is:

# Triangle( 1 ) = 1

# Triangle( N ) = N + Triangle( N-1 )

		.data
prompt:		.asciiz		"Enter N to know the Nth triangle number: "
result:		.asciiz		"The triangle number is "
lf:		.asciiz		"\n"

		.text
		.globl	main

main:
	# prolog
	sub	$sp, $sp, 4	#   1. Push return address
	sw	$ra, ($sp)
	sub	$sp, $sp, 4	#   2. Push caller's frame pointer
	sw	$fp, ($sp)
				#   3. No S registers to push
	sub	$fp, $sp, 4	#   4. $fp = $sp - space_for_variables
	move	$sp, $fp 	#   5. $sp = $fp

	# body
	li	$v0, 4
	la	$a0, prompt	# ask for N
	syscall

	li	$v0, 5		# get the input
	syscall

	sw	$v0, 0($fp)	# store N, the variable

	# subroutine call
	lw	$a0, 0($fp)	# load the variable as argument to function call
	nop
	jal	triangle
	nop

	# print the result
	move	$t0, $v0	# store the result for printing

	li	$v0, 4
	la	$a0, result
	syscall

	li	$v0, 1
	move	$a0, $t0
	syscall

	li	$v0, 4
	la	$a0, lf
	syscall

	# epilog
				#   1. No return value
	add	$sp, $fp, 4	#   2. $sp = $fp + space_for_variables
				#   3. No S registers to pop
	lw	$fp, ($sp)	#   4. Pop $fp
	add	$sp, $sp, 4	#
	lw	$ra, ($sp)	#   5. Pop $ra
	add	$sp, $sp, 4	#
	jr	$ra     	# return to OS
	nop
