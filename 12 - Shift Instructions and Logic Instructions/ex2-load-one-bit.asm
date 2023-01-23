## In each register $1 through $7 set the corresponding bit. That is, in
## register 1 set bit 1 (and clear the rest to zero), in $2 set bit 2 (and clear
## the rest to zero), and so on. Use only one ori instruction in your program,
## to set the bit in register $1.

## ori   $1,$0,0x01

## Don't use any ori instructions other than that one. Note: bit 1 of a register
## is the second from the right, the one that (in unsigned binary) corresponds
## to the first power of two.

	.text
	.globl	main

main:
	ori	$1, $0, 0x1		# set one register to 0x00000001
	sll	$1, $1, 1		# $1 = $1 << 1
	sll	$2, $1, 1		# $2 = $1 << 1
	sll	$3, $2, 1		# $3 = $2 << 1
	sll	$4, $3, 1		# $4 = $3 << 1
	sll	$5, $4, 1		# $5 = $4 << 1
	sll	$6, $5, 1		# $6 = $5 << 1
	sll	$7, $6, 1		# $7 = $6 << 1

# EOF
