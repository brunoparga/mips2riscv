# Divide the last program of the chapter into three parts: a main routine, a
# subroutine that creates the linked list, and a subroutine that prints the
# linked list. Have the linked list creation routine ask the user for each value
# that is stored in a node. The first value that the user enters is the number of
# nodes that will be in the list.

		.data
prompt:		.ascii		"Welcome to the linked list generator!\n"
		.asciiz		"How long is your list of integers? "

		.text
		.globl	main

main:
	li	$v0, 4
	la	$a0, prompt
	syscall

	li	$v0, 5
	syscall

	move	$a0, $v0
	jal	createList
	nop

	beqz	$v0, done
	nop

	# print out the list
	move	$a0, $v1
	jal	printList
	nop

done:
	li	$v0, 10		# return to OS
	syscall
