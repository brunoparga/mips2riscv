# Initialize register $9 to 0x7000. Shift the bit pattern so that $9 contains
# 0x70000000. Now use addu to add $9 to itself. Is the result correct?

# Now use the add instruction and run the program again. What happens?

# This may be the only time in this course that you will use the add
# instruction.

	.text
	.globl	main

main:
	addiu	$9, $0, 0x7000		# $9 = 0x7000
	sll	$9, $9, 16		# $9 <<= 16
	addu	$10, $9, $9		# $10 = $9 + $9
	add	$11, $9, $9		# try $11 = $9 + $9 catch
