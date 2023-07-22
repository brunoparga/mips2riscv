# Consider the following structure:

# struct
# {
#   int day;
#   int month;
#   int year;
# }

# Write a program that allocates memory for such a structure and fills it in
# with values such as 9/7/2003.

# Write out the values in the structure.

		.data
welcome:	.asciiz		"Welcome to the ISO 8601 date printer v1!\n"

		.text
		.globl		main
main:
	li	$v0, 4
	la	$a0, welcome	# greet the user
	syscall

	li	$v0, 9		# allocate memory
	la	$a0, 12		# 3 words, one for each number
	syscall

	move	$s0, $v0	# save the address

	li	$t0, 8
	sw	$t0, 0($s0)
	li	$t0, 5
	sw	$t0, 4($s0)
	li	$t0, 1980
	sw	$t0, 8($s0)	# Write a date to the struct
				# the day smallpox was declared eradicated

	# call the printing function
	move	$a0, $s0
	jal	printDate
	nop

	jr	$ra
	nop
