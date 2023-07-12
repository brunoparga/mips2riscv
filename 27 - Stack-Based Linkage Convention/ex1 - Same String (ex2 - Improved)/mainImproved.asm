# Prompt the user for a string. Read in the string, prompt for another string
# and read it in. Then write a message that contains a space wherever the two
# strings are identical and a star wherever they differ.

		.data
prompt1:	.asciiz		"Please enter some text: "
prompt2:	.asciiz		"Now enter some more text: "
string1:	.space		200
string2:	.space		200

# Register use
# $s0 -> First string entered by user
# $s1 -> Second string entered by user

		.text
		.globl	main
main:
	# prolog
	subu	$sp, 4
	sw	$ra, ($sp)	# Store OS return address

	# body
	la	$a0, prompt1
	la	$a1, string1
	jal	read
	nop
	move	$s0, $v0	# save first string to $s0

	la	$a0, prompt2
	la	$a1, string2
	jal	read
	nop
	move	$s1, $v0	# save second string to $s1

	move	$a0, $s0
	move	$a1, $s1
	jal	printResultImproved
	nop

	# epilog
	lw	$ra, ($sp)
	addu	$sp, 4
	jr	$ra
	nop
