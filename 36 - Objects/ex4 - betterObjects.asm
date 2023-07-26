# Add two methods to the Complete Program> (above). Add a clear() method that
# makes the first byte of an objects string the null byte (in effect deleting the
# string). Add a capitalize() method that changes each lower case character of
# the object's string to a capital letter. Do this by adding 0x20 to each lower
# case letter. Modify main to test the new methods.

		.globl	main
		.text
main:				# object1.print();
	la	$a0, object1	#	get address of first object
	lw	$t0, 0($a0)	#	get address of print method
	jalr	$t0		#	call the method
				# object1.capitalize();
	la	$a0, object1	#	get address of first object
	lw	$t0, 12($a0)	#	get address of capitalize method
	jalr	$t0		#	call the method
				# object1.print();
	la	$a0, object1	#	get address of first object
	lw	$t0, 0($a0)	#	get address of print method
	jalr	$t0		#	call the method
				# object1.cancel();
	la	$a0, object1	#	get address of first object
	lw	$t0, 4($a0)	#	get address of cancel method
	jalr	$t0		#	call the method
				# object1.capitalize();
	la	$a0, object1	#	get address of first object
	lw	$t0, 12($a0)	#	get address of capitalize method
	jalr	$t0		#	call the method
				# object1.print();
	la	$a0, object1	#	get address of first object
	lw	$t0, 0($a0)	#	get address of print method
	jalr	$t0		#	call the method
				# object2.print();
	la	$a0, object2	#	get address of second object
	lw	$t0, 0($a0)	#	get address of object's method
	jalr	$t0		#	call the object's method
				# object2.clear();
	la	$a0, object2	#	get address of second object
	lw	$t0, 8($a0)	#	get address of clear method
	jalr	$t0		#	call the method
				# object2.print();
	la	$a0, object2	#	get address of second object
	lw	$t0, 0($a0)	#	get address of print method
	jalr	$t0		#	call the method

	li	$v0, 10		# return to OS
	syscall

# Objects constructed in static memory.
# The implementation of an object consists of the data for each object
# and a jump table of entry points common to all objects
# of this type.

		.data
object1:
		.word	print			# Jump Table
		.word	cancel
		.word	clear
		.word	capitalize
		.asciiz	"Hello World\n"		# This object's data

object2:
		.word	print			# Jump Table
		.word	cancel
		.word	clear
		.word	capitalize
		.asciiz	"Silly Example\n"	# This object's data

# print() method
# Used by all objects.
#
# Parameter: $a0 == address of the object
		.text
print:
	li	$v0, 4			# print string service
	addiu	$a0, $a0, 16		# address of object's string
	syscall				#
	jr	$ra

# cancel() method
# Used by all objects.
#
# Parameter: $a0 == address of the object
#
# Registers:
# $t0 == address of the char in the string
# $t1 == char from the string
# $t2 == 'x'

		.text
cancel:
	addiu	$t0, $a0, 16	# the string starts 16 bytes
				# from the start of the object
	li	$t2, 'x'	# replacement character
	lb	$t1, 0($t0)	# get first ch of string
loop:
	beq	$t1, '\n', done	# while ( ch != '\n' )
	sb	$t2, 0($t0)	#	replace ch with 'x'
	addiu	$t0, $t0, 1	#
	lb	$t1, 0($t0)	#	get next ch
	b	loop		# end while
done:
	jr	$ra		# return to caller

# clear() method
# Used by all objects.
#
# Parameter: $a0 == address of the object
		.text
clear:
	sb	$zero, 16($a0)		# NULL the first byte of the string
	jr	$ra

# clear() method
# Used by all objects.
#
# Parameter: $a0 == address of the object
		.text
capitalize:
	addiu	$t0, $a0, 16
	lb	$t1, 0($t0)	# get first ch of string
capLoop:
	beqz	$t1, done	# while ( ch != '\0' )
	blt	$t1, 0x5B, capLoop2
	subu	$t1, 0x20
	sb	$t1, 0($t0)
capLoop2:
	addiu	$t0, $t0, 1
	lb	$t1, 0($t0)
	b	capLoop
