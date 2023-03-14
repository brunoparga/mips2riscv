# Write a program that writes the following pattern to the simulated terminal:

#     *
#    ***
#   *****
#  *******
# *********

# The last row starts in column one. Use a counting loop to print the five lines.
# The body of the counting loop contains two other loops which, in sequence, fill
# the line buffer with the right number of spaces and stars for the current line.

main:
	li	$t0, 4

outerLoop:
	bltz	$t0, done
	move	$t1, $t0

spaces:
	beqz	$t1, calcStars
	li	$v0, 4
	la	$a0, space
	syscall
	b	spaces
	subu	$t1, 1

calcStars:
	addu	$t1, 9		# $t1 is guaranteed to be 0 when this is reached
	subu	$t1, $t1, $t0
	subu	$t1, $t1, $t0

printStars:
	li	$v0, 4
	la	$a0, star
	syscall

	subu	$t1, 1
	bnez	$t1, printStars
	nop

nextLine:
	li	$v0, 4
	la	$a0, newline
	syscall

	b	outerLoop
	subu	$t0, 1

done:
	li	$v0, 10
	syscall

		.data
space:		.asciiz		" "
star:		.asciiz		"*"
newline:	.asciiz		"\n"
