# Write a program that asks the user for the size of an image: R rows and C
# columns. Then allocate space for R*C bytes.

# Fill row 1 with 1s, fill row 2 with 2s, and so on. Examine the data section of
# the simulator to see if you did this correctly.

		.data
welcome:	.asciiz		"Welcome to the Image Generator!\n"
askRows:	.asciiz		"How many rows should the image have? "
askCols:	.asciiz		"And how many columns? "
present:	.asciiz		"Here is your image:\n\n"

# Register use
# $s0 -> number of rows
# $s1 -> number of columns
# $s2 -> address of the memory block

		.text
		.globl		main

main:
	li	$v0, 4
	la	$a0, welcome
	syscall

	li	$v0, 4
	la	$a0, askRows
	syscall

	li	$v0, 5
	syscall
	move	$s0, $v0

	li	$v0, 4
	la	$a0, askCols
	syscall

	li	$v0, 5
	syscall
	move	$s1, $v0

	mul	$a0, $s0, $s1
	li	$v0, 9
	syscall
	move	$s2, $v0

	li	$t0, 0		# row iterator

rowLoop:
	li	$v0, 11
	li	$a0, '\n'	# end previous row
	syscall

	beq	$t0, $s0, done
	nop

	addu	$t0, 1		# number to write is now correct
	move	$a0, $t0	# put it for writing
	li	$t1, 0		# column iterator

columnLoop:
	beq	$t1, $s1, rowLoop
	nop

	sb	$a0, 0($s2)
	li	$v0, 1
	syscall

	addu	$s2, 1
	j	columnLoop
	addu	$t1, 1

done:
	li	$v0, 10
	syscall
