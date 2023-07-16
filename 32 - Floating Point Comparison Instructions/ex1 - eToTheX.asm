# Write a program that asks the user for x and then computes exp(x) by using a
# Taylor series:

# exp(x) = 1 + x + x^2/2 + x^3/3! + x^4/4! + ...

# exp(x) is e^x, where e is the base of the natural logarithms, 2.718281828...
# You don't need to worry about the math behind this. Just compute a sum of terms.
# Each term in the sum looks like:

# x^n/n!
# Designate a register to hold the current term. Initialize it to 1.0 (the
# zeroeth term). Term one is calculated by multiplying:

# term*x/1
# Term one is the value x. Term two is calculated by multiplying:

# term*x/2
# Term two is the value x2/2. Term three is calculated by multiplying:

# term*x/3
# Term three is the value x3/3!. Term four is calculated by multiplying:

# term*x/4
# ... and so on. In general, after you have added term (n-1)to the sum, calculate
# term n by multiplying:

# term *x/n
# Keep doing this in a loop until the term becomes very small.

		.data
welcome:	.asciiz		"Welcome to the exp(x) calculator!\n"
prompt:		.asciiz		"To what power do you want to raise e? "
result:		.asciiz		"The result is "

# Register use
# $f0 -> exponent
# $f1 -> result
# $f2 -> current term
# $f3 -> n, the integer used in calculating each term
# $f4 -> epsilon = 0.00001
# $f5 -> 1.0 to increment n

		.text
		.globl	main
main:
	# Welcome the user
	li	$v0, 4
	la	$a0, welcome
	syscall

	# Prompt for the exponent
	li	$v0, 4
	la	$a0, prompt
	syscall

	li	$v0, 6
	syscall			# exponent, doesn't change

	# Initialize values
	li.s	$f1, 0.0	# result, gets added up every iteration
	li.s	$f2, 1.0	# term, x^n/n!
	li.s	$f3, 1.0	# n, increases by 1 every iteration
	li.s	$f4, 1.0e-6	# epsilon to check if we're done
	li.s	$f5, 1.0	# 1 to increment iterator since there is no
				# add immediate instruction for floats

loop:
	# update the sum
	add.s	$f1, $f1, $f2
	# check if done
	# calculate a new term
	mul.s	$f2, $f0, $f2
	div.s	$f2, $f2, $f3
	c.lt.s	$f2, $f4
	# if not, increment
	bc1t	done
	nop
	add.s	$f3, $f3, $f5
	# and loop
	b	loop
	nop

done:
	li	$v0, 4
	la	$a0, result
	syscall

	li	$v0, 2
	mov.s	$f12, $f1
	syscall

	li	$v0, 11
	li	$a0, '\n'
	syscall

	li	$v0, 10
	syscall
