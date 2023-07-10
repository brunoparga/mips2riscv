# Write a program that asks the user for a string. Read the string into a buffer.
# Now scan the string from right to left starting with the right-most character
# (this is the one just before the null termination.) Push each non-vowel
# character onto the stack. Skip over vowels.

# Now pop the stack character by character back into the buffer. Put characters
# into the buffer from right to left. End the string with a null byte. The buffer
# will now contain the string, in the correct order, without vowels.

# Write out the final string.

		.data
askText:	.asciiz		"Enter the text to be de-vowelized: "
string:		.space		200

# Register use
# $t0 -> input string pointer
# $t1 -> character being processed
# $t2 -> output string pointer

		.text
main:
	# Prompt for text
	li	$v0, 4
	la	$a0, askText
	syscall

	# Get text
	li	$v0, 8
	la	$a0, string
	li	$a1, 200
	syscall

	# Initialize string pointers
	li	$t0, 0
	li	$t2, 0

pushLoop:
	lb	$t1, string($t0)
	addu	$t0, 1

	# We'll check if the char in $t1 is a vowel
	beq	$t1, 0x41, pushLoop		# Is the character 'A'?
	beq	$t1, 0x45, pushLoop		# ... 'E'?
	beq	$t1, 0x49, pushLoop		# ... 'I'?
	beq	$t1, 0x4F, pushLoop		# ... 'O'?
	beq	$t1, 0x55, pushLoop		# ... 'U'?
	beq	$t1, 0x61, pushLoop		# ... 'a'?
	beq	$t1, 0x65, pushLoop		# ... 'e'?
	beq	$t1, 0x69, pushLoop		# ... 'i'?
	beq	$t1, 0x6F, pushLoop		# ... 'o'?
	beq	$t1, 0x75, pushLoop		# ... 'u'?

	# Check if we're done
	beq	$t1, 0xa, endString

	# If the character isn't a vowel, we push it and move the pointer
	subu	$sp, 4
	sw	$t1, ($sp)
	addu	$t2, 1
	j	pushLoop

endString:
	sb	$zero, string($t2)		# write null to end string

popLoop:
	lb	$t1, ($sp)
	addu	$sp, 4
	subu	$t2, 1				# decrement pointer
	sb	$t1, string($t2)		# write it
	beqz	$t2, print			# we're done
	j	popLoop

print:
	li	$v0, 4
	la	$a0, string
	syscall

	li	$v0, 10
	syscall
