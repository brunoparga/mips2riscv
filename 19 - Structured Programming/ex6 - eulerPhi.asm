# Write a program that computes the Euler phi function. The phi function is
# important in cryptography and internet security.

# The phi function of an integer N is the number of positive integers less than
# N that do not share a common factor greater than one with N. Another way to say
# this is that phi( N ) is the number of positive integers less than N that are
# relatively prime to N.

# Two integers share a common factor if there is an integer greater than one
# that divides them both with no remainder. For example, 14 and 21 share a common
# factor of 7. Also, 7 and 21 share a common factor of 7. But 5 and 21 do not
# have a common factor.

# Two integers have a factor in common if they have greatest commmon divisor
# greater than one. The greatest common divisor of 14 and 21 is 7. The greatest
# common divisior of 5 and 21 is 1.

# So the phi function of N is the number of positive integers x less than N for
# which gcd(N,x) = 1.

# Write a program that computes phi(N) for an integer N in the data section.
# Store the result back into the data section.

        .data
N:      .word     60
phi:    .word      0

# The logic of your program could be:

# phi = 0;
# trial = 1;
# while (trial < N)
# {
#     if ( gcd(N,trial) == 1 ) phi++;
# }

	.text
	.globl	main

main:
	lui	$10, 0x1000		# base register
	lw	$8, 0($10)		# N
	ori	$9, $0, 0		# phi
	ori	$11, $0, 0		# trial

phiLoop:
	addu	$11, $11, 1		# trial++
	beq	$8, $11, phiDone	# while trial != N
	or	$12, $8, $0		# copy N to $12 for GCD
	or	$13, $11, $0		# copy trial to $13 for GCD

gcdLoop:
	beq	$12, $13, gcdDone	# if (M == N) { goto gcdDone }
	slt	$14, $12, $13		# $14 = isNLessThanM
	beq	$14, $0, nMinusM	# if $14 == $0 then goto nMinusM
	sll	$0, $0, 0		# nop
	j	gcdLoop			# jump to gcdLoop
	sub	$13, $13, $12		# M -= N

nMinusM:
	j	gcdLoop			# jump to gcdLoop
	sub	$12, $12, $13		# N -= M

gcdDone:
	ori	$14, $0, 1
	bne	$12, $14, phiLoop	# if gcd > 1, don't increment phi
	sll	$0, $0, 0		# nop
	j	phiLoop
	addiu	$9, $9, 1		# phi++

phiDone:
	sw	$9, 4($10)
