# Initialize a linked list and populate it with strings.
# Return the length of the list in $v0 and either a pointer to the first element
# or null in $v1, depending on whether there are elements.

		.data
toEnd:		.asciiz		"Enter 'done' to end\n"
prompt:		.asciiz		"String: "
doneStr:	.asciiz		"done\n"
string:		.space		16

# Register use
# $s0 -> length of the list
# $s1 -> address of the first node of the main list
# $s2 -> address of the current node of the main list
# $s3 -> address of the string buffer

		.text
		.globl		createStringList
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

	bnez	$v0, done
	nop

	li	$v0, 9		# allocate memory
	li	$a0, 20		# 20 bytes
	syscall			# $v0 <-- address

	move	$s2, $v0	# $s2 is the new node
	la	$s3, string	# $s3 holds the inputted string

	# if this is the first string, save its pointer to $v1
	bnez	$s0, storeString
	addu	$s0, 1		# list length++
	move	$v1, $v0	# this gets saved as a return value
	move	$s1, $v0	# this holds the current node

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

done:
	beqz	$s2, reallyDone		# guard in case list is empty
	nop
	# end the list
	sw	$0, 0($s2)	# put null in the link field
				# of the current node, which
				# is the last node.

reallyDone:
	move	$v0, $s0
	lw	$ra, ($sp)
	addu	$sp, 4
	jr	$ra
	nop
