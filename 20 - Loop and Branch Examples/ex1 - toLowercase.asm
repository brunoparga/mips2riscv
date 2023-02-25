# Declare a string in the data section:

		.data
string:   	.asciiz		"ABCDEFG"

# Write a program that converts the string to all lower case characters. Do this
# by adding 0x20 to each character in the string. (See Appendix F to figure out
# why this works.)

# Assume that the data consists only of upper-case alphabetical characters, with
# no spaces or punctuation.

	.text
	.globl	main

main:
	lui	$9, 0x1000		# point at first char

# while not char == null do
loop:
	lbu	$10, 0($9)		# load char
	sll	$0, $0, 0		# branch delay
	beq	$10, $0, done		# exit loop if char == null
	sll	$0, $0, 0		# branch delay

	addiu	$10, $10, 0x20		# lowercase the letter
	sb	$10, 0($9)		# overwrite the char
	j	loop
	addiu	$9, $9, 1		# point at the next char

done:
	sll	$0, $0, 0		# target for branch
