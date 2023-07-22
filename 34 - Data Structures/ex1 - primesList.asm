# Copy the final program of the chapter, linked.asm and get it to work. Now
# rearrange the order of the elements of the linked list that are declared in
# memory. Check that the program still works.

# Next, add more elements to the list. If you wish to keep this a list of prime
# numbers, add elements for 11, 13, 17, 19, and 23. Add these to scattered
# locations in the data section. Check that the program still works.

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

sep:		.asciiz 	"  "
endMsg:		.asciiz 	"done\n"

		.text
		.globl		main

main:
	la	$s0, head	# get pointer to head

loop:
	beqz	$s0, done	# while not null
	nop

	lw	$a0, 0($s0)	#	get the data
	li	$v0, 1		#	print it
	syscall

	la	$a0, sep	#	print separator
	li	$v0, 4
	syscall

	lw	$s0, 4($s0)	#	get next
	b	loop
	nop

done:
	li	$a0, '\n'	# print end of line
	li	$v0, 11
	syscall

	la	$a0, endMsg	# print ending message
	li	$v0, 4
	syscall

	li	$v0, 10	 	# return to OS
	syscall
