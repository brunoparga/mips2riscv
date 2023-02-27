# Evaluate the following polynomial using Horner's method:

# ax3 + bx2 + cx + d

# Now the values for the coefficients a, b, c, d as well as for x come from the
# .data section of memory:

		.data
x:		.word	7
a:		.word	-3
bb:		.word	3
c:		.word	9
d:		.word	-24
result: 	.word	0

# Use the pseudoinstruction lw to get the coefficients from memory, and sw to
# write the result back to memory.

# (Recall that the symbolic address b cannot be used in SPIM.)

		.text
		.globl	main

main:
	lw	$t0, a
	lw	$t1, x
	lw	$t2, bb
	mult	$t0, $t1
	mflo	$t0		# $t0 = ax
	lw	$t3, c
	addu	$t0, $t0, $t2	# $t0 = ax + b
	mult	$t0, $t1
	mflo	$t0		# $t0 = ax2 + bx
	lw	$t2, d
	addu	$t0, $t0, $t3	# $t0 = ax2 + bx + c
	mult	$t0, $t1
	mflo	$t0		# $t0 = ax3 + bx2 + cx
	addu	$t0, $t0, $t2	# $t0 = ax3 + bx2 + cx + d
	sw	$t0, result
