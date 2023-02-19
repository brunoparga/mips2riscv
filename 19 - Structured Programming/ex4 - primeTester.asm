# Write a program that determines if an integer is prime. An integer is prime if
# it cannot be divided by any positive integer other than one and itself. The
# integer N to be tested will be in memory. Set the location isprime to 1 if N is
# prime, 0 otherwise.

		.data
N:		.word		8192
isprime:	.word		0

# To determine if N is prime, try to divide it with trial divisors from 2 up to
# N/2. If one of them divides N without a remainder, then N is not prime. You only
# have to try trial divisors up to N/2 because if N = trial*X, then trial = N/X
# and the only integer X less than 2 is 1.

		.text
		.globl	main

main:
	lui	$10, 0x1000
	lw	$8, 0($10)		# load the prime candidate to $8
	sll	$0, $0, 0		# nop
	or	$9, $8, $0		# $9 = $8 (for the square root)

sqrt:
	# instead of looking all the way up to N/2, we're gonna look up to
	# approximately sqrt(N). To achieve this we'll repeatedly divide the
	# number by 2 and check if we're under the square root, stopping with
	# the last number that's greater.
	sra	$9, $9, 1		# N/2
	mult	$9, $9			# $9 * $9 = Hi and Lo registers
	mflo	$11			# copy Lo to $11
	slt	$12, $8, $11		# N < (N/2)^2
	bne	$12, $0, sqrt		# if $12 != $0 then goto sqrt
	ori	$11, $0, 1		# Set the first candidate divisor
	# A good enough approximation of sqrt(N) is in $9

trialFactor:
	addiu	$11, $11, 1
	slt	$12, $9, $11		# sqrt(N) < candidate?
	bne	$12, $0, isPrime	# if $12 != $0 then goto isPrime
	div	$8, $11			# $8 / $11
	mfhi	$12			# $12 = $8 % $11
	beq	$12, $0, notPrime	# if $12 == $0 then goto notPrime
	j	trialFactor		# jump to trialFactor

isPrime:
	ori	$12, $0, 1
	j	done
	sw	$12, 4($10)		# store 1 to memory - N is prime!

notPrime:
	sw	$0, 4($10)		# store 0 to memory - N is not prime

done:
	sll	$0, $0, 0		# nop
