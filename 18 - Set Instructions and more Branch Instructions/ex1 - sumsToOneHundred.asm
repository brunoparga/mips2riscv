# Write a program that computes three sums:

# 1 + 2 + 3 + 4 + ... + 99 + 100

# 1 + 3 + 5 + 7 + ... + 97 + 99

# 2 + 4 + 6 + 8 + ... + 98 + 100

# Use a register (say $8) for the sum of evens, a register (say $9) for the sum
# of odds, and another (say $10) for the sum of all numbers. Register $11 is
# used for the counter and $12 and $13 as flags.

# Do this with one counting loop. The loop body contains logic to add the count
# to the proper sums.

	.text
	.globl	main

main:
	ori	$8, $0, 0		# sumEvens = 0
	ori	$9, $0, 0		# sumOdds  = 0
	ori	$10, $0, 0		# sumAll   = 0
	ori	$11, $0, 0		# counter  = 0

test:
	slti	$12, $11, 100		# isNotDone = (counter < 100) ? 1 : 0
	beq	$12, $0, done		# if !isNotDone then goto done

	# If we wanted extreme optimization, we could move this to the branch
	# slot and jump to sumOdd instead (placing that block below sumEven).
	# But this code is clearer.
	addiu	$11, $11, 1		# counter += 1

	andi	$13, $11, 0x1		# counterIsOdd = isOdd(counter)
	beq	$13, $0, sumEven	# if !counterIsOdd then goto sumEven
	sll	$0, $0, 0		# nop

sumOdd:
	j	test			# jump to test
	addu	$9, $9, $11		# sumOdds += counter

sumEven:
	j	test			# jump to test
	addu	$8, $8, $11		# $8 += counter

done:
	addu	$10, $8, $9		# sumAll = sumEvens + sumOdds
