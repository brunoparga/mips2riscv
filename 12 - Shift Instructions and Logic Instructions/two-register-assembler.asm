## Program to assemble the instruction ori  $8,$9,0x004A
## Using only two registers
##
	.text
	.globl	main

main:
	or	$25, $0, $0		# clear $25

	ori	$11, $0, 0xD		# opcode
	sll	$11, $11, 26		# shift opcode into position
	or	$25, $25, $11		# or it into the instruction

	ori	$11, $0, 0x9		# operand $s
	sll	$11, $11, 21		# shift operand $s into position
	or	$25, $25, $11		# or it into the instruction

	ori	$11, $0, 0x8		# dest. $d
	sll	$11, $11, 16		# shift dest $d into position
	or	$25, $25, $11		# or it into the instruction

	ori	$14, $0, 0x004A		# immediate operand
	or	$25, $25, $14		# or const into the instruction

	ori	$8, $9, 0x004A		# The actual assembler
					# should create the same machine
					# instruction as we now have in $25

## end of file
