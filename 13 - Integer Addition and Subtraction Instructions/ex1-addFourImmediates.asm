# Write a program that adds up the following integers:
#  456
# -229
#  325
# -552
# Leave the answer in register $8.

	.text
	.globl	main

main:
	addiu	$8, $0,  456
	addiu	$8, $8, -256
	addiu	$8, $8,  325
	addiu	$8, $8, -552
