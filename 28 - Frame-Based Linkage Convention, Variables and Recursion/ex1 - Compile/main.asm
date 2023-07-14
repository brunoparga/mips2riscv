# Translate the following little program into MIPS assembly language. Do a
# line-by-line translation as a simple compiler might do (as done in the chapter).
# Use stack-based variables for the program's local variables. Assemble and run
# your program under SPIM

# main()
# {
#   int f;
#   int c;

#   f = 5;
#   c = toCelsius( f );

#   print( "f=", f, "c=", c );
# }

# You could, of course, write the program without using variables since there are
# plenty of "T" registers available. But practice using local variables as in the
# chapter. For each assignment statement, for each variable on the right of the
# equal sign retrieve a value from a variable on the stack. For the variable on
# the left of an assignment statement, store a value into the variable, even if
# the very next statement requires that the value be retrieved.

		.data
fahrenheit:	.asciiz		"Fahrenheit = "
celsius:	.asciiz		"Celsius = "
comma:		.asciiz		", "

		.text
		.globl	main		# main()
main:	# {
	# Prolog instructions without C correspondence
	subu	$sp, 4
	sw	$ra, ($sp)		# push return address

	subu	$sp, 4
	sw	$fp, ($sp)		# push the caller frame pointer

	subu	$fp, $sp, 8		# make space for two int variables
	move	$sp, $fp		# stack pointer = frame pointer

	# body - begin C correspondence

					#   int f;	// 0($fp)
					#   int c;	// 4($fp)

	li	$t0, 5
	sw	$t0, 0($fp)		#   f = 50;

	# subroutine call
	lw	$a0, 0($fp)		# set the argument
	nop
	jal	toCelsius
	nop

	# assign return value to variable
	sw	$v0, 4($fp)		#   c = toCelsius( f );

	#   print( "f=", f, "c=", c );
	li	$v0, 4
	la	$a0, fahrenheit
	syscall

	lw	$a0, 0($fp)
	li	$v0, 1
	syscall

	li	$v0, 4
	la	$a0, comma
	syscall

	li	$v0, 4
	la	$a0, celsius
	syscall

	lw	$a0, 4($fp)
	li	$v0, 1
	syscall

	# epilog - undo what the prolog did
	addu	$sp, $fp, 8		# erase this frame from the stack
	lw	$fp, ($sp)		# restore the frame pointer
	addu	$sp, 4
	lw	$ra, ($sp)		# pop the return address
	addu	$sp, 4

	jr	$ra
	nop				# }
