# Subroutine PStruct: print a struct
#
# Registers on entry: 	$a0 --- address of the struct
#			$ra --- return address
#
# Registers:		$s0 --- address of the struct

		.data
agest:		.asciiz 	"age: "
payst:  	.asciiz 	"  pay:   "
classt: 	.asciiz 	"  class: "

		.text
		.globl		PStruct
PStruct:
	sub	$sp, $sp, 4	# push $s0
	sw	$s0, ($sp)	# onto the stack

	move	$s0, $a0	# make a safe copy
				# of struct address

	la	$a0, agest	# print "age: "
	li	$v0, 4
	syscall
	lw	$a0, 0($s0)	# print age
	li	$v0, 1
	syscall

	la	$a0, payst	# print "  pay: "
	li	$v0, 4
	syscall
	lw	$a0, 4($s0)	# print pay
	li	$v0, 1
	syscall

	la	$a0, classt	# print "  class: "
	li	$v0, 4
	syscall
	lw	$a0, 8($s0)	# print class
	li	$v0, 1
	syscall

	add	$sp, $sp, 4	# restore $s0 of caller
	lw	$s0, ($sp)
	jr	$ra		# return to caller
	nop
