# Copy the final program of the chapter, linked.asm. Modify it so that it does
# the following: The user enters an integer and then the program traverses the
# list looking at each node until it finds that integer. It prints out a message
# when it finds the integer. If it continues to the end of the list without
# finding the integer it prints out a failure message.

# Keep doing this until the user enters a negative value to signal the end.

		.data
head:
elmnt01:	.word		2
		.word		elmnt02

elmnt02:	.word		3
		.word		elmnt03

elmnt03:	.word		5
		.word		elmnt04

elmnt04:	.word		7
		.word		elmnt05

elmnt05:	.word		11
		.word		elmnt06

elmnt06:	.word		13
		.word		elmnt07

elmnt07:	.word		17
		.word		elmnt08

elmnt08:	.word		19
		.word		0

welcome:	.asciiz		"Welcome to the Prime Under 20 Finder!\n"
prompt:		.ascii		"Please enter an integer to search in the list\n"
		.asciiz		"(A negative number ends the program)\n> "
foundMsg:	.asciiz		"Your number was found! It is a prime under 20.\n"
notFoundMsg:	.asciiz		"Your number was not found. It is not a prime <= 20.\n"
thankYou:	.asciiz		"Thank you for using the Prime Under 20 Finder!\n"

# Register use
# $s0 -> head of the list
# $s1 -> number to search for

		.text
		.globl		main

main:
	li	$v0, 4
	la	$a0, welcome
	syscall

loop:
	li	$v0, 4
	la	$a0, prompt
	syscall

	li	$v0, 5
	syscall

	bltz	$v0, done
	move	$s1, $v0
	la	$s0, head	# get pointer to head

listLoop:
	beqz	$s0, notFound	# while not null
	nop

	lw	$t0, 0($s0)	#	get the data
	nop
	beq	$s1, $t0, found

	lw	$s0, 4($s0)	#	get next
	b	listLoop
	nop

found:
	li	$v0, 4
	la	$a0, foundMsg
	b	loop
	syscall

notFound:
	li	$v0, 4
	la	$a0, notFoundMsg
	b	loop
	syscall

done:
	li	$v0, 10	 	# return to OS
	syscall
