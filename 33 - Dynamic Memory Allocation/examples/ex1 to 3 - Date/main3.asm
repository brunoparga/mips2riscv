# Consider the following structure:

# struct
# {
#   int day;
#   int month;
#   int year;
# }

# In the static data section of your program declare space for an array of up to
# 25 addresses.

# Not all of the potential addresses will be used. The field size starts at zero
# because to start, none of the addresses are used.

# Write a program that asks the user for how many dates are needed. Set size to
# that amount. Now a counting loop executes for that many times. Each execution
# of the loop allocates space for one data, puts the address of that date in the
# array of addresses, asks the user for values for that data, and finally, fills
# the date with those values.

# At the end of the program write out the values in the dates. Do this by
# scanning through the array of addresses to access each date. (Probably the
# dates will be in order in a contiguous block of memory, but a real-world
# program can not count on this being true.)

		.data
welcome:	.ascii		"Welcome to the ISO 8601 date printer v3!\n"
prompt:		.asciiz		"How many dates do you want to convert? "
dateNo:		.asciiz		"Date number "
		.align		2
dates:		.space  	25*4

# Register use
# $s0 -> number of dates
# $s1 -> date addresses
# $s3 -> iterator

		.text
		.globl		main
main:
	li	$v0, 4
	la	$a0, welcome	# greet the user; prompt for number of dates
	syscall

	li	$v0, 5
	syscall
	move	$s0, $v0

preLoop0:
	la	$s1, dates
	li	$s3, 0		# for i = 0

loop0:
	# Initialize the array with N pointers
	beq 	$s3, $s0, preLoop1
	nop

	li	$v0, 9
	li	$a0, 4		# size of an address
	syscall
	sw	$v0, 0($s1)

	addu	$s1, 4
	j	loop0
	addu	$s3, 1

preLoop1:
	la	$s1, dates
	li	$s3, 0

loop1:
	beq	$s3, $s0, preLoop2
	nop

	la	$a1, 0($s1)	# current date struct pointer's address
	move	$a0, $s3	# iteration count
	jal	copyDateAddr
	nop

	addu	$s1, 4
	j	loop1
	addu	$s3, 1

preLoop2:
	la	$s1, dates
	li	$s3, 0

loop2:
	beq	$s3, $s0, done
	nop

	lw	$a0, 0($s1)
	jal	printDate
	nop

	addu	$s1, 4
	j	loop2
	addu	$s3, 1

done:
	li	$v0, 10
	syscall
