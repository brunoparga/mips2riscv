# Write a program that computes the greatest common divisor (GCD) of two
# integers. The two integers and the GCD will be in memory.

	.data
N:	.word		21
M:	.word		14
GCD:	.word		0

# The GCD of two integers is the largest integer that divides them both with a
# remainder of zero.

# GCD(21,14) = 7
# GCD(14,21) = 7
# GCD(27,36) = 9
# GCD(25,50) = 25
# GCD(19,36) = 1
# GCD(12,55) = 1

# Notice that GCD(X,Y) = GCD(Y,X). If the GCD of two integers is one, then the
# two integers are relatively prime. Two integers might be relatively prime
# without either one of them being prime.

# If two integers have a common divisor, the difference of the two integers has
# the same divisor. To find the common divisor, keep subtracting one integer from
# the other until a common value is reached. Why is this? Say x and y have a
# common divisor, say d.

# Then x = md and y = nd
# Then (x - y) = md - nd = (m - n)d = kd
# So the difference kd has the same divisor d
# Your program can follow this algorithm:

# get N
# get M

# while (N != M)
#     if ( N > M )
#         N = N - M;
#     else
#         M = M - N;

# GCD =  N;
# Load N and M integer registers and implement the algorithm using registers.
# There is no need to change the N and M in memory. When the loop finishes,
# store the resulting GCD into memory.

	.text
	.globl	main

# Register use
# $8  -> N
# $9  -> M
# $10 -> base register
# $11 -> flag: N < M

main:
	lui	$10, 0x1000
	lw	$8, 0($10)		# load N
	lw	$9, 4($10)		# load M
	sll	$0, $0, 0		# nop

loop:
	beq	$8, $9, done		# if (M == N) { goto done }
	slt	$11, $8, $9		# $11 = isNLessThanM
	beq	$11, $0, nMinusM	# if $11 == $0 then goto nMinusM
	sll	$0, $0, 0		# nop
	j	loop			# jump to loop
	sub	$9, $9, $8		# M -= N

nMinusM:
	j	loop			# jump to loop
	sub	$8, $8, $9		# N -= M

done:
	sw	$8, 8($10)		# store the GCD
