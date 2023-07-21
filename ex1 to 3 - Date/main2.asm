# Consider the following structure:

# struct
# {
#   int day;
#   int month;
#   int year;
# }

# Write a program that asks the user for how many dates are needed and then
# allocates space (all at one time) for that many structs.

# Then, in a loop, ask the user for the values to put in each structure. Do this
# by initializing a structure pointer to the first address of the allocated space.
# Then add the size of a structure to it for each execution of the loop.

# Finally, write out the contents of all the structures.

		.data
welcome:	.ascii		"Welcome to the ISO 8601 date printer v2!\n"
prompt:		.asciiz		"How many dates do you want to convert? "

# Register use
# $s0 -> number of dates
# $s1 -> first date address
# $s2 -> sizeof struct iterator
# $s3 -> int iterator

		.text
		.globl		main
main:
	li	$v0, 4
	la	$a0, welcome	# greet the user
	syscall

	li	$v0, 5
	syscall

	move	$s0, $v0	# save number of dates
	li	$s3, 0		# for i = 0

	li	$t0, 12
	mul	$a0, $s0, $t0
	li	$v0, 9
	syscall			# malloc sizeof struct * no. of dates

	move	$s1, $v0
	move	$s2, $s1

loop1:
	beq	$s3, $s0, loop2
	nop

	move	$a0, $s3	# iteration count
	move	$a1, $s2	# current date struct's address
	jal	copyDate
	nop

	addu	$s3, 1
	j	loop1
	addu	$s2, 12

loop2:
	beqz	$s0, done
	nop
	subu	$s0, 1

	move	$a0, $s1
	jal	printDate
	nop

	j	loop2
	addu	$s1, 12

done:
	li	$v0, 10
	syscall
