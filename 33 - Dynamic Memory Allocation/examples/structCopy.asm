# StructCopy.asm

# struct
# {
#	int age;
#	int pay;
#	int class;
# } myData ;

		.data
pay:		.word		24000		# rate of pay, in static memory
agest:		.asciiz		"age: "

		.text
		.globl		main

main:
	# create the first struct
	li	$v0, 9		# allocate memory
	li	$a0, 12		# 12 bytes
	syscall			# $v0 <-- address
	move	$s1, $v0	# $s1 first struct

	# initialize the first struct
	li	$t0, 34		# store 34
	sw	$t0, 0($s1)	# in age
	lw	$t0, pay	# store 24000
	nop
	sw	$t0, 4($s1)	# in pay
	li	$t0, 12		# store 12
	sw	$t0, 8($s1)	# in class

	# create the second struct
	li	$v0, 9		# allocate memory
	li	$a0, 12		# 12 bytes
	syscall			# $v0 <-- address
	move	$s2, $v0	# $s2 second struct

	# copy data from first struct to second
	lw	$t0, 0($s1)	# copy age from first
	nop
	sw	$t0, 0($s2)	# to second struct
	lw	$t0, 4($s1)	# copy pay from first
	nop
	sw	$t0, 4($s2)	# to second struct
	lw	$t0, 8($s1)	# copy class from first
	nop
	sw	$t0, 8($s2)	# to second struct

	# write out the second struct
	la	$a0, agest	# print "age: "
	li	$v0, 4		# print string service
	syscall
	lw	$a0, 0($s2)	# print age
	li	$v0, 1		# print int service
	syscall

	li	$v0, 10		# return to OS
	syscall
