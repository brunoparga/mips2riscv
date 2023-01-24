# Let register $8 be x and register $9 be y. Write a program to evaluate:

# 3x - 5y

# Leave the result in register $10. Inspect the register after running the program
# to check that the program works. Run the program several times, initialize x and
# y to different values for each run.

	.text
	.globl	main

main:
	addiu	$8, $0,  0x4		# $8 = x
	addiu	$9, $0, 0xB		# $9 = y

	sll	$7, $8, 2		# $7 = 4x
	subu	$8, $7, $8		# $8 = $7 - $8 = 4x - x = 3x

	sll	$7, $9, 2		# $7 = 4y
	addu	$9, $9, $7		# $9 = $9 + $7 = y + 4y = 5y

	subu	$10, $8, $9		# $10 = result = $8 - $9 = 3x = 5y
