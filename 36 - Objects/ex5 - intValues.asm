# Design an object that has an integer for its data. Its methods are set(),
# double(), and print(). The set() method is passed a parameter in $a0 and sets
# the object's data to that value. The double() method doubles an object's integer,
# and the print() method prints out the integer.

# Write a main routine that creates several objects and tests their methods.

		.text
		.globl	main
main:				# intVal = new IntVal();
	li	$v0, 9		#	allocate 8 bytes
	li	$a0, 8		#	4 for the jump table and 4 for the value
	syscall			#	$v0 = address
	sw	$v0, intVal	#

	la	$t0, jtable	#	initialize jump table
	sw	$t0, 0($v0)	#

				# intVal.set(value);
	lw	$a0, intVal	#	get address of intVal
	lw	$t0, 0($a0)	#	get address of its jump table
	lw	$t0, 0($t0)	#	get address of the set method
	li	$a1, 78557	# 	value the intVal will take
	jalr	$t0		#	call the method
	nop
				# intVal.double();
	lw	$a0, intVal	#	get address of intVal
	lw	$t0, 0($a0)	#	get address of its jump table
	lw	$t0, 4($t0)	#	get address of double method
	jalr	$t0		#	call the method
	nop
				# intVal.print();
	lw	$a0, intVal	#	get address of intVal
	lw	$t0, 0($a0)	#	get address of its jump table
	lw	$t0, 8($t0)	#	get address of print method
	jalr	$t0		#	call the method

	li	$v0, 10		# return to OS
	syscall

		.data
intVal:		.word		0

jtable:		.word		set
		.word		double
		.word		print

# set() method
# Parameter: $a0 == address of the object
#
		.text
set:
	sw	$a1, 4($a0)	# store value
	jr	$ra		# return to caller

# double() method
# Parameter: $a0 == address of the object

		.text
double:
	lw	$t0, 4($a0)	# load value
	sll	$t0, $t0, 1	# shift left by one = double the number
	sw	$t0, 4($a0)
	jr	$ra

# print() method
# Parameter: $a0 == address of the object
		.text
print:
	li	$v0, 1		# print integer service
	lw	$a0, 4($a0)
	syscall			#
	jr	$ra
