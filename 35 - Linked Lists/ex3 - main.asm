# Modify the program so that each node has the link to the next node in the
# first four bytes, followed by a null-terminated string. Unlike the previous
# exercise, allocate only enough memory for each node to hold the link and the
# string. Read the string into a buffer, compute its length, allocate enough
# memory for the node, and then copy the string from the buffer to the node.

################################################################################
		.text
		.globl	main
################################################################################
main:
	li	$v0, 4
	la	$a0, welcome
	syscall

	jal	createStringList
	nop

	beqz	$v0, endMain	# done if list length is zero
	nop

	# print out the list, which is in $v1
	move	$a0, $v1
	jal	printStringList
	nop

endMain:
	li	$v0, 10		# return to OS
	syscall

		.data
welcome:	.asciiz		"Welcome to the string linked list generator!\n"

################################################################################
		.text
		.globl		printStringList
# Given the address of a linked list of strings, print its contents.
################################################################################
printStringList:
	move	$t0, $a0
printLoop:
	beqz	$t0, endFunction
	nop			# while not null

	la	$a0, 4($t0)	#	get the data
	li	$v0, 4		#	print it
	syscall

	lw	$t0, 0($t0)	#	get next
	b	printLoop
	nop


################################################################################
		.globl		createStringList
# Initialize a linked list and populate it with strings.
# Return the length of the list in $v0 and either a pointer to the first element
# or null in $v1, depending on whether there are elements.

# Register use
# $s0 -> length of the list
# $s1 -> address of the first node of the main list
# $s2 -> address of the current node of the main list
# $s3 -> address of the string buffer
################################################################################

createStringList:
	# prolog
	subu	$sp, 4
	sw	$ra, ($sp)

	# print informational message
	li	$v0, 4
	la	$a0, toEnd
	syscall

	# initialize needed values
	li	$s0, 0		# list is initially empty
	li	$v1, 0		# return empty list = null pointer

readString:
	li	$v0, 4
	la	$a0, prompt
	syscall

	li	$v0, 8
	la	$a0, string
	li	$a1, 16		# maximum size of string
	syscall

	la	$a1, doneStr
	jal	compareStrings
	nop

	bnez	$v0, finishList
	nop

	la	$a0, string
	jal	strLen
	nop

	# allocate 5 + string length bytes; put address in $v0
	# 4 bytes are for the next node pointer and one for the null that
	# terminates the string, which doesn't count for the length
	addu	$a0, $v0, 5
	li	$v0, 9
	syscall

	move	$s2, $v0	# $s2 is the new node
	la	$s3, string	# $s3 holds the inputted string

	# if this is the first string...
	bnez	$s0, storeString
	addu	$s0, 1		# list length++

	# ...save its pointer to $v1 (to return it) and $s1 (to iterate)
	move	$v1, $v0
	move	$s1, $v0

storeString:
	move	$a0, $s3
	addu	$a1, $s2, 4	# to leave space for the next node pointer
	jal	copyString
	nop

	# The first element has no predecessor
	ble	$s0, 1, updateNode
	nop

	# link this node to the previous
				# $s1 = &(previous node)
	sw	$s2, 0($s1)	# copy address of the new node
				# into the previous node

updateNode:
	# make the new node the current node
	b	readString
	move	$s1, $s2

finishList:
	beqz	$s2, endCreateStrList	# guard in case list is empty
	nop
	# end the list
	sw	$0, 0($s2)	# put null in the link field
				# of the current node, which
				# is the last node.

endCreateStrList:
	move	$v0, $s0
	lw	$ra, ($sp)
	addu	$sp, 4

endFunction:
	jr	$ra
	nop


		.data
toEnd:		.asciiz		"Enter 'done' to end\n"
prompt:		.asciiz		"String: "
doneStr:	.asciiz		"done\n"
string:		.space		16

################################################################################
		.text
		.globl		compareStrings
# Compare two strings. Return 1 if they are of the same length and character-by-
# -character equal, 0 otherwise.
################################################################################
compareStrings:
	lb	$t0, 0($a0)
	lb	$t1, 0($a1)
	nop
	bne	$t0, $t1, notEqual
	nop
	beqz	$t0, equal
	addu	$a0, 1
	j	compareStrings
	addu	$a1, 1

equal:
	j	endFunction
	li	$v0, 1

notEqual:
	j	endFunction
	li	$v0, 0


################################################################################
		.globl		copyString
# Copy string from $a0 to $a1.
################################################################################
copyString:
	lb	$t0, 0($a0)
	addu	$a0, 1		# advance the load pointer
	beqz	$t0, endFunction
	sb	$t0, 0($a1)
	j	copyString
	addu	$a1, 1		# and the store pointer

################################################################################
		.globl		strLen
# Return the length of a string.
################################################################################
strLen:
	li	$v0, 1
	move	$t0, $a0
length:
	lb	$t1, 0($t0)
	addu	$t0, 1
	beqz	$t1, endFunction
	nop
	j	length
	addu	$v0, 1

################################################################################
