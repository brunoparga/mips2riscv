# Declare a string in the data section:

		.data
string:		.asciiz		"Is  this a dagger    which I see before me?"

# Write a program that removes all the spaces from the string so that the
# resulting string looks like:

# 		.data
# string:	.asciiz		"IsthisadaggerwhichIseebeforeme?"

# Be sure to end the result string with a null after its final character.

# Easy version: declare a second buffer to hold the result string. Transfer
# non-space characters from the input string to the result string.

# Medium-hard version: Use only the buffer that holds the original string. Use
# two character pointers, one for the current character and another for its
# destination.

# The logic for this can be tricky. Figure out how you would do it with
# characters arrays in C or Java before you try it with assembly. For testing,
# use a data string such as the following:

# 		.data
# string:	.asciiz		"aaaa bbbb  cccc   dddd    eeee"

		.text
		.globl	main

main:
	lui	$8, 0x1000		# read pointer
	lui	$9, 0x1000		# write pointer
	ori	$10, 0x20		# space character

loop:
	lbu	$12, 0($8)		# read char from read pointer
	sll	$0, $0, 0		# nop
	beq	$12, $0, done		# if read == null { goto done }
	sll	$0, $0, 0		# nop

	# character is not null
	beq	$12, $10, loop		# read next char if current one is space
	addiu	$8, $8, 1		# move read pointer

	# character is not a space
	sb	$12, 0($9)		# store char in write pointer
	j	loop
	addiu	$9, $9, 1		# move write pointer

done:
	sb	$12, 0($9)
