# Declare a string in the data section:

		.data
string:		.asciiz		"in a  hOle in the   grOund there lived a hObbit"

# Write a program that capitalizes the first letter of each word, so that after
# running your program the data will look like this:

#		.data
# string:	.asciiz		"In A  Hole In The   Ground There Lived A Hobbit"

# Easy version: assume that the data consists only of lower case characters and
# spaces. There may, however, be several spaces in a row. Be sure to capitalize
# the first letter of the string.

# Medium-hard version: assume that the data consists only of upper and lower
# case characters and spaces. Alter a character only if it is lower case and
# follows a space.

	.text
	.globl	main

main:
	# Set some constants
	lui	$8, 0x1000		# pointer to char
	lbu	$10, 0($8)		# one char
	ori	$12, $0, 0x20		# " ", and also "a" - "A"
	beq	$10, $0, done		# the string is empty!
	ori	$11, $0, 0x60		# "`", the char immediately before "a"

	# Test the first character (unlike all others, it does not
	# require the previous one to be a space to be capitalized)
	slt	$13, $11, $10		# Is the first char "a" or after that?
	slti	$14, $10, 0x7B		# Is the first char "z" or before that?
	and	$13, $13, $14		# isLowercaseLetter = isGTELowercaseA && isLTELowercaseZ
	bne	$13, $0, upcase		# if (isLowercaseLetter) { goto upcase }
	sll	$0, $0, 0		# nop

loop:
	# Test for done
	addiu	$8, $8, 1		# increment pointer
	lbu	$10, 0($8)		# one char
	sll	$0, $0, 0		# nop
	beq	$10, $0, done		# reached the end of the string

	# If the char is less than "a", no need to upcase it
	slt	$13, $11, $10
	beq	$13, $0, loop		# if (char < "a") { goto loop }

	# If the char is greater than "z", no need to upcase it
	slti	$14, $10, 0x7B		# Is the first char "z" or before that?
	beq	$14, $0, loop		# if (char > "z") { goto loop }

	# Only upcase if previous char is " "
	lbu	$9, -1($8)		# previous char
	sll	$0, $0, 0		# nop
	beq	$9, $12, upcase		# if (prevChar == " ") { goto upcase }
	j	loop			# jump to loop
	sll	$0, $0, 0		# nop

upcase:
	sub	$10, $10, $12		# upcase the letter at $10
	j	loop			# jump to loop
	sb	$10, 0($8)		# store capital letter

done:
	sll	$0, $0, 0		# nop
