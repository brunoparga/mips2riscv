# Start out register $1 with any 32-bit pattern, such as 0x76543210.
# Now, put the reverse of that pattern into register $2, for the example,
# 0x01234567.

	.text
	.globl	main

main:
	ori	$1, $0, 0x7654
	sll	$1, $1, 16
	ori	$1, $1, 0x321B		# $1 = arbitrary pattern

	ori	$3, $0, 0xF		# $3 = mask for lowest nibble
	sll	$4, $3, 4		# $4 = mask for second nibble
	sll	$5, $4, 4		# $5 = mask for third nibble
	sll	$6, $5, 4		# $6 = mask for fourth nibble
	sll	$7, $6, 4		# $7 = mask for fifth nibble
	sll	$8, $7, 4		# $8 = mask for sixth nibble
	sll	$9, $8, 4		# $9 = mask for seventh nibble
	sll	$10, $9, 4		# $10 = mask for eighth nibble

	and	$3, $1, $3		# $3 = first nibble
	and	$4, $1, $4		# $4 = second nibble
	and	$5, $1, $5		# $5 = third nibble
	and	$6, $1, $6		# $6 = fourth nibble
	and	$7, $1, $7		# $7 = fifth nibble
	and	$8, $1, $8		# $8 = sixth nibble
	and	$9, $1, $9		# $9 = seventh nibble
	and	$10, $1, $10		# $10 = eighth nibble

	sll	$3, $3, 28		# $3 = 1st nibble in position 8
	sll	$4, $4, 20		# $4 = 2nd nibble in position 7
	sll	$5, $5, 12		# $5 = 3rd nibble in position 6
	sll	$6, $6, 4		# $6 = 4th nibble in position 5
	srl	$7, $7, 4		# $7 = 5th nibble in position 4
	srl	$8, $8, 12		# $8 = 6th nibble in position 3
	srl	$9, $9, 20		# $9 = 7th nibble in position 2
	srl	$10, $10, 28		# $10 = 8th nibble in position 1

	or	$2, $2, $3		# Nibble 1 -> 8
	or	$2, $2, $4		# Nibble 2 -> 7
	or	$2, $2, $5		# Nibble 3 -> 6
	or	$2, $2,	$6		# Nibble 4 -> 5
	or	$2, $2, $7		# Nibble 5 -> 4
	or	$2, $2, $8		# Nibble 6 -> 3
	or	$2, $2, $9		# Nibble 7 -> 2
	or	$2, $2, $10		# Nibble 8 -> 1

# EOF
