# This exercise continues exercise 2.

# Write a program that searches for perfect numbers. It has an outer loop that
# counts upward from two to some limit. Each number is tested (as above) to see
# if it is a perfect number. If it is a perfect number it is stored at a memory
# location. Store perfect numbers at successive full-word memory locations. Look
# at exercise 1 for a way to do this.

# Again, to save time and effort, create a flowchart first.

		.data
max:		.word      	9000
perfects:	.space		100

		.text
		.globl	main

# Register use
# $8  -> number being tested (N)
# $9  -> running sum of all divisors so far
# $10 -> base register for memory operations
# $11 -> potential divisor, going from 2 up to at N/2
# $12 -> N/2 + 1 for ease of testing
# $13 -> helper flag
# $14 -> helper flag
# $15 -> maximum number to test

main:
	lui	$10, 0x1000
	lw	$15, 0($10)		# load max
	ori	$8, $0, 4		# initialize N to 1

setup:
	addiu	$8, $8, 1		# N++
	beq	$8, $15, done
	ori	$9, $0, 1		# sum is 1, since it divides every number
	ori	$11, $0, 1		# i will soon be 2, the first potential divisor
	sra	$12, $8, 1
	addiu	$12, $12, 1		# we'll be testing with N/2 + 1  a lot

nextDivisor:
	addiu	$11, $11, 1		# i++
	slt	$13, $9, $12		# sum < N/2
	slt	$14, $11, $12		# i < N/2
	and	$13, $13, $14		# if (!(sum < N/2) || !(i < N/2))
	beq	$13, $0, checkPerf	# { goto checkPerf }

isDivisor:
	div	$8, $11			# divide N by i
	mfhi	$14			# flag = N % i
	bne	$14, $0, nextDivisor	# if (N % i != 0) { goto nextDivisor }
	sll	$0, $0, 0		# nop
	j	nextDivisor		# jump to nextDivisor
	addu	$9, $9, $11		# sum += divisor

checkPerf:
	bne	$9, $8, setup		# if sum != N then goto setup
	sll	$0, $0, 0		# nop

setPerf:
	addiu	$10, $10, 4		# where to store the next perfect
	j	setup			# jump to setup
	sw	$8, 0($10)		# store perfect number in memory

done:
	sll	$0, $0, 0		# nop
