# Write a program that stores the number 0 in the first four bytes of the
# .data section, then stores the number 1 in the next four bytes, then stores
# the number 2 in the four bytes after that and so on. Do this for numbers 0
# through 24.

# Of course you will do this in a counting loop. The address in the data section
# is contained in a base register. Increment the base register each time a
# number is stored.

# The data section of your program should look like

	.data
array:	.space		100

# Register use:
# $8  -> holds 24, the target of the count
# $9  -> loop
# $10 -> pointer


	.text
	.globl	main

main:
	ori	$8, $0, 24		# target = 24
	ori	$9, $0, 0		# count = 0
	lui	$10, 0x1000		# set pointer to beginning of array

loop:
	beq	$9, $8, endLoop		# if (count == target) { goto endLoop }
	sw	$9, 0($10)		# store int to array[counter]
	addiu	$9, $9, 1		# count++
	j	loop			# jump to loop
	addiu	$10, $10, 4		# &pointer += sizeof(word)

endLoop:
	sll	$0, $0, 0		# nop
