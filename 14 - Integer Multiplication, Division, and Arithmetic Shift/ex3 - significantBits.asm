# Write a program that multiplies the contents of two registers which you have
# initialized using an immediate operand with the ori instruction. Determine
# (by inspection) the number of significant bits in each of the following
# numbers, represented in two's complement. Use the program to form their
# product and then determine the number of significant bits in it.

# Operand 1		0x00001000	0x00000FFF	0x0000FF00	0x00008000
# Significant Bits		13		12		16		16
# Operand 2		0x00001000	0x00000FFF	0x0000FFFF	0x00001000
# Significant Bits		13		12		16		13
# Product		0x01000000	0x00FFE001	0xFEFF0100	0x08000000
# Significant Bits		25		24		32		28

	.text
	.globl	main

main:
	ori	$8, $0, 0x1000
	mult	$8, $8
	mflo	$9
	ori	$10, $0, 0xFFF
	ori	$11, $0, 0xFF00
	mult	$10, $10
	mflo	$12
	ori	$13, $0, 0xFFFF
	ori	$14, $0, 0x8000
	mult	$11, $13
	mflo	$15
	sll	$0, $0, 0
	sll	$0, $0, 0
	mult	$14, $8
	mflo	$17
