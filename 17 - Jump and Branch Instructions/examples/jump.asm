## jump.asm
##
	.text
	.globl	main

main:
	sll	$0, $0, 0
	sll	$0, $0, 0
	sll	$0, $0, 0
	sll	$0, $0, 0
	j	main
	addiu	$8, $8, 1

## End of file
