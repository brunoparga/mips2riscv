# With an ori instruction, initialize $8 to a bit pattern that represents a
# positive integer. Now the program determines how many significant bits are in
# the pattern. The significant bits are the leftmost one bit and all bits to
# its right. So the bit pattern:

# 0000 0000 0010 1001 1000 1101 0111 1101

# ... has 22 significant bits. (To load register $8 with the above pattern,
# 0x00298D7D, use an ori followed by a left shift followed by another ori.)

# The bit count is stored in $9.

	.text
	.globl	main

main:
	lui	$8, 0x29		# load the high half-word
	ori	$8, $8, 0x8D7D		# load the low half-word
	ori	$9, $0, 0		# bits = 0

test:
	beq	$8, $0, done		# if $8 == 0 then goto done
	srl	$8, $8, 1		# $8 >>= 1
	j	test			# jump to test
	addiu	$9, $9, 1		# bits += 1

done:
	sll	$0, $0, 0		# nop
