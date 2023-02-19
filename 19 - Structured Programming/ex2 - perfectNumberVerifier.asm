# A perfect number is an integer whose integer divisors sum up to the number.
# For example, 6 is perfect because 6 is divided by 1, 2, and 3 and 6 = 1 + 2 + 3.
# Other perfect numbers are 28 and 496.

# Write a program that determines if an integer stored in memory is a perfect
# number. Set a location in memory to 1 if the number is perfect, to 0 if not.

		.data
N:		.word      	33550337
isperfect:	.word      	0

# It would be enormously helpful to first do this by hand with a couple of
# examples. Then draw a flowchart. Check the flowchart by following it with a
# few examples. Then write the program.

		.text
		.globl	main

# Register use
# $8  -> number being tested (N)
# $9  -> running sum of all divisors so far
# $10 -> base register for memory operations
# $11 -> integer going from 2 up to at N/2
# $12 -> N/2 + 1 for ease of testing
# $13 -> helper flag
# $14 -> helper flag

main:
	lui	$10, 0x1000
	lw	$8, 0($10)		# load N
	ori	$9, $0, 1		# sum is 1, since it divides every number
	ori	$11, $0, 1		# i will soon be 2, the first potential divisor
	sra	$12, $8, 1
	addiu	$12, $12, 1		# we'll be testing with N/2 + 1  a lot

checkDone:
	addiu	$11, $11, 1		# i++
	slt	$13, $9, $12		# sum < N/2
	slt	$14, $11, $12		# i < N/2
	and	$13, $13, $14		# if (!(sum < N/2) || !(i < N/2))
	beq	$13, $0, checkPerf	# { goto checkPerf }
	div	$8, $11			# divide N by i

isDivisor:
	mfhi	$14			# flag = N % i
	bne	$14, $0, checkDone	# if (N % i != 0) { goto checkDone }
	sll	$0, $0, 0		# nop
	j	checkDone		# jump to checkDone
	addu	$9, $9, $11		# sum += divisor

setPerf:
	j	done			# jump to done
	ori	$13, $0, 1		# the number is perfect!

checkPerf:
	beq	$9, $8, setPerf		# if sum == N then goto setPerf
	sll	$0, $0, 0		# nop
	ori	$13, $0, 0		# the number is not perfect :(

done:
	sw	$13, 4($10)		# store isPerfect in memory
