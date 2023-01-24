# Let register $8 be x. Write a program that computes 13x. Leave the result in
# register $10. Initialize x to 1 for debugging. Then try some other positive values.

# Extend your program so that it also computes -13x and leaves the result in
# register $11 (This will take one additional instruction.) Now initialize
# x to -1. Look at your result for 13x. Is it correct?

	.text
	.globl	main

main:
	addiu	$8, $0, -1		# $8 = x
	sll	$9, $8, 3		# $9 = 8x
	sll	$11, $8, 2		# $11 = 4x
	addu	$10, $9, $11		# $10 = $9 + $11 = 8x + 4x = 12x
	addu	$10, $10, $8		# $10 = $10 + $8 = 12x + x = 13x
	subu	$11, $0, $10		# $11 = 0 - $10 = -13x
