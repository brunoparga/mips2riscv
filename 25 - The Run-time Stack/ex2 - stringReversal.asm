# Write a program that asks the user for a string. Read the string into a
# buffer, then reverse the string using the stack. However, unlike the example
# in the chapter, don't push a null character on the stack. Keep track of the
# number of characters on the stack by incrementing a count each time a character
# is pushed, and decrementing it each time a character is popped. Write out the
# reversed string.

		.data
askText:	.asciiz		"Enter the text to be reversed: "
string:		.space		200


		.text
main:
	li	$v0, 4
	la	$a0, askText
	syscall

	li	$v0, 8
	la	$a0, string
	li	$a1, 200
	syscall

	li	$t0, 0
	li	$t2, 0

pushLoop:
	lb	$t1, string($t0)
	nop
	beq	$t1, 0xa, popLoop
	nop
	subu	$sp, 4
	sw	$t1, ($sp)
	b	pushLoop
	addu	$t0, 1

popLoop:
	beq	$t2, $t0, print
	nop
	lb	$t1, ($sp)
	addu	$sp, 4
	sb	$t1, string($t2)
	b	popLoop
	addu	$t2, 1

print:
	li	$v0, 4
	la	$a0, string
	syscall

	li	$v0, 10
	syscall
