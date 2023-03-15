# Write a program to evaluate 3ab - 2bc - 5a + 20ac - 16

# Prompt the user for the values a, b, and c. Try to use a small number of
# registers. Use the stack to hold intermediate values. Write the final value to
# the monitor.

# I want to use only $t0, $t1 and $t2


		.data
askA:		.asciiz		"Enter number A: "
askB:		.asciiz		"Now enter number B: "
askC:		.asciiz		"Finally enter number C: "
result:		.asciiz		"The final value of 3ab - 2bc - 5a + 20ac - 16 is "

		.text
main:
	# Push the three numbers onto the stack
	li	$v0, 4
	la	$a0, askA
	syscall

	li	$v0, 5
	syscall
	subu	$sp, $sp, 4
	sw	$v0, ($sp)		# ( a )

	li	$v0, 4
	la	$a0, askB
	syscall

	li	$v0, 5
	syscall
	subu	$sp, $sp, 4
	sw	$v0, ($sp)		# ( a b )

	li	$v0, 4
	la	$a0, askC
	syscall

	li	$v0, 5
	syscall

	# In the general case, we divide by c and thus rely on it
	# not being zero. If it is, we just need to calculate 3ab - 5a - 16,
	# a much easier problem.
	beqz	$v0, cIsZero
	nop

cIsNotZero:
	# Calculate the expression
	# First, we calculate the terms that do not depend on a
	move	$t0, $v0		# $t0 = c
	lw	$t1, ($sp)		# $t1 = b
	addu	$sp, $sp, 4		# ( a )
	mul	$t2, $t0, $t1		# $t2 = bc
	nop
	addu	$t2, $t2, 8		# $t2 = bc + 8
	mul	$t2, $t2, -2		# $t2 = -2bc - 16

	# Now we load a into $t1. This results in b being erased; as long
	# as we have the intermediate result above and c, we can
	# reconstruct it. Since $t0 = c and result = -2bc - 16, it follows
	# that b = (-result - 16) / 2c. So we store result and reconstruct b.
	lw	$t1, ($sp)		# $t1 = a
	sw	$t2, ($sp)		# ( result )

	# Now $t0 = c, $t1 = a, $t2 = -2bc - 16, stack = ( -2bc-16 )
	# Let's put b back into $t2
	addu	$t2, $t2, 16		# $t2 = -2bc
	div	$t2, $t2, -2		# $t2 = bc
	nop
	nop
	div	$t2, $t2, $t0		# $t2 = b
	nop
	nop

	# The expression can be rewritten as result + a(3b + 20c - 5),
	# so let's calculate that in $t2
	mul	$t2, $t2, 3		# $t2 = 3b
	nop
	nop
	mul	$t0, $t0, 20		# $t0 = 20c
	subu	$t2, $t2, 5		# $t2 = 3b - 5
	addu	$t2, $t2, $t0		# $t2 = 3b + 20c - 5
	mul	$t2, $t2, $t1		# $t2 = 3ab + 2ac - 5a

	# Now we no longer need a in $t1; let's load the other part
	# of the result and add it to what we've already got
	lw	$t1, ($sp)		# $t1 = -2bc - 16
	addu	$sp, $sp, 4		# ( )
	b	displayResult
	addu	$t2, $t2, $t1		# $t2 = 3ab - 2bc - 5a + 20ac - 16

cIsZero:
	# Invariants for this and the other branch:
	# The stack starts as ( a b );
	# We want the result in $t2

	# here we know that c is 0, so we just need to
	# evaluate 3ab - 5a - 16
	li	$t2, -16
	lw	$t1, ($sp)		# $t1 = b
	addu	$sp, $sp, 4		# ( a )
	lw	$t0, ($sp)		# $t0 = a
	addu	$sp, $sp, 4		# ( )

	mul	$t1, $t1, 3		# $t1 = 3b
	nop
	nop
	mul	$t1, $t1, $t0		# $t1 = 3ab
	addu	$t2, $t2, $t1		# $t2 = 3ab - 16
	nop
	mul	$t0, $t0, -5
	addu	$t2, $t2, $t0		# $t2 = 3ab - 5a - 16

displayResult:
	li	$v0, 4
	la	$a0, result
	syscall

	li	$v0, 1
	move	$a0, $t2
	syscall

	li	$v0, 10
	syscall
