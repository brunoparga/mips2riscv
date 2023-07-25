# Modify the program (either the one from from the chapter or the one in
# Exercise 1) so that the data in each node is a null-terminated string. For this
# exercise, make all nodes the same size. Allow for strings of up to 16 characters
# (counting the null).

# Put the link to the next node in the first for bytes of a node (this will make
# things easier later.) The user enters string data in a loop. The string "done"
# signals the end of input. Print out the linked list.

		.data
welcome:	.asciiz		"Welcome to the string linked list generator!\n"

		.text
		.globl	main

main:
	li	$v0, 4
	la	$a0, welcome
	syscall

	jal	createStringList
	nop

	beqz	$v0, done	# done if list length is zero
	nop

	# print out the list, which is in $v1
	move	$a0, $v1
	jal	printStringList
	nop

done:
	li	$v0, 10		# return to OS
	syscall
