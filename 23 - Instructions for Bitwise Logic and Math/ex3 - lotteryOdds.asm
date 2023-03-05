# To win a lottery you must correctly pick K out of N numbers. For example, you
# might need to pick 6 numbers out of the numbers 1 to 50. There are

# (50 * 49 * 48 * 47 * 46 * 45 )/(1 * 2 * 3 * 4 * 5 * 6)
# ways of picking 6 out of 50 numbers. So your odds of winning are 1 in that
# number of ways. If you must pick 6 out of 50 numbers, your odds of winning are
# 1 in 15,890,700. In general, there are

# N * (N-1) * (N-2) * (N-3) * (N-4) * ... * (N-K+1)
# -------------------------------------------------
#        1  *   2   *   3   *  4    * ... * K

# ways of picking K out of N numbers.

# Write a program that asks the user for integers N and K and writes out the
# odds of winning such a lottery.

# Test that the program works for reasonable values of N and K.

		.text
		.globl	main

# Register use
# $t0 -> N
# $t1 -> K
# $t2 -> counter, goes from 1 to K
# $t3 -> result
# $t4 -> divisor (K!)

main:
	# Ask the user for N, the total numbers in the lottery
	li	$v0, 4
	la	$a0, askTotal
	syscall

	# Get the answer for N and store it in $t0
	li	$v0, 5
	syscall
	move	$t0, $v0

	# Ask the user for K, the numbers in a ticket
	li	$v0, 4
	la	$a0, askChoice
	syscall

	# Get the answer for K and store it in $t1
	li	$v0, 5
	syscall
	move	$t1, $v0

	# Initialize the counter, the result and K! to 1
	li	$t2, 1
	li	$t3, 1
	li	$t4, 1

loop:
	# First, we check if we're done
	beq	$t2, $t1, done

	# If not, we multiply the relevant numbers
	mul	$t3, $t3, $t0
	subu	$t0, $t0, 1
	nop

	addu	$t2, $t2, 1
	j	loop
	mul	$t4, $t4, $t2

done:
	# Print the first part of the answer message
	li	$v0, 4
	la	$a0, oneInN
	syscall

	# Compute and print the number of possibilities, N choose K
	li	$v0, 1
	divu	$a0, $t3, $t4
	syscall

	# Finish the answer message and quit
	li	$v0, 4
	la	$a0, badIdea
	syscall

	li	$v0, 10
	syscall

		.data

askTotal:	.asciiz		"How many numbers to choose from? "
askChoice:	.asciiz		"How many numbers are chosen? "
oneInN:		.asciiz		"The odds of winning are 1 in "
badIdea:	.asciiz		". Bad idea!\n"
