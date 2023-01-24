# Initialize the sum in register $8 to zero. Then add 4096(10) to $8 sixteen
# times. You don't know how to loop, yet, so do this by making 16 copies of the
# same instruction. The value 4096(10) is 0x1000.

# # Next initialize register $9 to 4096(10). Shift $9 left by the correct number of
# positions so that registers $8 and $9 contain the same bit pattern.

# # Finally, initialize aregister $10 to 4096(10). Add $10 to itself the correct
# number of times so that it contains the same bit pattern as the other two
# registers.

	.text
	.globl	main

main:
	or	$8, $0, $0		# $8 = 0
	addiu	$8, $8, 4096		# $8 = $8 + 4096
	addiu	$8, $8, 4096		# $8 = $8 + 4096
	addiu	$8, $8, 4096		# $8 = $8 + 4096
	addiu	$8, $8, 4096		# $8 = $8 + 4096
	addiu	$8, $8, 4096		# $8 = $8 + 4096
	addiu	$8, $8, 4096		# $8 = $8 + 4096
	addiu	$8, $8, 4096		# $8 = $8 + 4096
	addiu	$8, $8, 4096		# $8 = $8 + 4096
	addiu	$8, $8, 4096		# $8 = $8 + 4096
	addiu	$8, $8, 4096		# $8 = $8 + 4096
	addiu	$8, $8, 4096		# $8 = $8 + 4096
	addiu	$8, $8, 4096		# $8 = $8 + 4096
	addiu	$8, $8, 4096		# $8 = $8 + 4096
	addiu	$8, $8, 4096		# $8 = $8 + 4096
	addiu	$8, $8, 4096		# $8 = $8 + 4096
	addiu	$8, $8, 4096		# $8 = $8 + 4096

	or	$9, $0, 4096		# $9 = 4096
	sll	$9, $9, 4		# $9 = $9 << 4

	or	$10, $0, 4096		# $10 = 4096
	addu	$10, $10, $10		# $10 += $10
	addu	$10, $10, $10		# $10 += $10
	addu	$10, $10, $10		# $10 += $10
	addu	$10, $10, $10		# $10 += $10
