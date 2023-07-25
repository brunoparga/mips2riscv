# Initialize a linked list and populate it with $a0 elements.
# Return the length of the list in $v0 and either a pointer to the first element
# or null in $v1, depending on whether there are elements.

		.data
prompt:		.asciiz		"Element: "

# Register use
# $t0 -> length of the list
# $t1 -> address of the current node
# $t2 -> iterator

		.text
		.globl		createList
createList:
	bgtz	$a0, hasElements
	li	$v0, 0
	j	epilog
	li	$v1, 0

hasElements:
	move	$t0, $a0
	# create the first node
	li	$v0, 9		# allocate memory
	li	$a0, 8		# 8 bytes
	syscall			# $v0 <-- address
	move	$t1, $v0	# $t1 = &(first node)
	subu	$sp, 4
	sw	$t1, ($sp)	# push the address of the list to the stack

	# populate the first node
	li	$v0, 4
	la	$a0, prompt
	syscall

	li	$v0, 5
	syscall
	sw	$v0, 0($t1)

	# create the remaining nodes in a counting loop
	li	$t2, 2		# counter = 2

loop:
	bgtu	$t2, $t0, done	# while (counter <= limit )

	# create a node
	li	$v0, 9		# allocate memory
	li	$a0, 8		# 8 bytes
	syscall			# $v0 <-- address

	# link this node to the previous
				# $t1 = &(previous node)
	sw	$v0, 4($t1)	# copy address of the new node
				# into the previous node

	# make the new node the current node
	move	$t1, $v0

	li	$v0, 4
	la	$a0, prompt
	syscall
	li	$v0, 5
	syscall
	sw	$v0, 0($t1)

	b	loop
	addi	$t2, $t2, 1	# counter++

done:
	# end the list
	sw	$0, 4($t1)	# put null in the link field
				# of the current node, which
				# is the last node.

	move	$v0, $t0
	lw	$v1, ($sp)
	addu	$sp, 4		# pop the list header into $v1

epilog:
	jr	$ra
	nop
