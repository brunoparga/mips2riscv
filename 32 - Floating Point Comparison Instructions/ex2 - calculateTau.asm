# Various infinite series for tau have been discovered. The first such series was

# tau = 8( 1 - 1/3 + 1/5 - 1/7 + 1/9 - . . .)

# This series is of little practical value because enormous numbers of terms are
# required to achieve good approximations (Acton, Calculus, 1999). However, it
# does provide good programming practice.

# Write a SPIM program that writes out the sum of the first 1000, 2000,
# 3000, ... , 10000 terms of the series.

		.data
welcome:	.asciiz		"Welcome to the tau calculator!\n"
prompt:		.asciiz		"How many terms do you want in the series? "
result:		.asciiz		"The circle constant tau is: "

# Register use
# $t0  -> number of terms
# $t1  -> iterator
# $f0  -> -1; used to change the sign of the numerator and increment the denominator
# $f2 -> -1 to generate the numerator (updates every term)
# $f4  -> current term
# $f6  -> denominator of the term
# $f8  -> 8, to multiply at the end
# $f12 -> result

		.text
		.globl	main
main:
	# Welcome the user
	li	$v0, 4
	la	$a0, welcome
	syscall

	# Prompt for the number of terms
	li	$v0, 4
	la	$a0, prompt
	syscall

	li	$v0, 5
	syscall

	# Initialize values
	move	$t0, $v0	# $t0: number of terms, doesn't change
	li	$t1, 0		# iterator
	li.d	$f0, -1.0	# -1 to subtract from denominator since there is
				# no 'add immediate' instruction for floats
	li.d	$f2, -1.0	# -1 to switch sign every iteration
	li.d	$f6, 0.0	# denominator
	li.d	$f8, 8.0	# 8 to multiply at the end
	li.d	$f12, 0.0	# result, gets added up every iteration

loop:
	# calculate a new term
	mul.d	$f2, $f2, $f0	# numerator with the correct sign
	sub.d	$f6, $f6, $f0	# correct, odd denominator
	div.d	$f4, $f2, $f6	# calculate new term

	# update the sum
	add.d	$f12, $f12, $f4

	# check if done; if not, increment and loop.
	# branch delay slots are used to speed things up a bit
	beq	$t0, $t1, done
	sub.d	$f6, $f6, $f0	# temporary even denominator
	b	loop
	addiu	$t1, 1		# iterator

done:
	li	$v0, 4
	la	$a0, result
	syscall

	li	$v0, 3
	mul.d	$f12, $f12, $f8		# multiply series by 8
	syscall

	li	$v0, 11
	li	$a0, '\n'
	syscall

	li	$v0, 10
	syscall
