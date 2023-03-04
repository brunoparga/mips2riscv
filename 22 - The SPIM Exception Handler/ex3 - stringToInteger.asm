# Write a program that asks the user for a string of digits that represent a
# positive integer. Read in the string using service number 8, the "read string"
# service. Now convert the string of digits into an integer by the following
# algorithm:

# value = 0;

# for each digit starting with the left-most:
# {
#   convert the digit into an integer D by subtracting 0x30
#   value = value*10 + D
# }

# You might recognize this as Horner's method. After converting the integer,
# check if it is correct by writing it out on the simulated monitor using
# service 1.

# Notes: assume that the input is correct (that it contains only digits and can
# be converted to a 32-bit integer). Be sure to deal properly with the
# end-of-line character that is at the end of the user's input.

		.text
		.globl		main

main:
	li	$v0, 4
	la	$a0, prompt
	syscall

	li	$v0, 8
	la	$a0, string
	la	$a1, 12
	syscall

	li	$t0, 0xA		# LF, \n; also base 10
	li	$t2, 0x0		# initialize integer as 0
	li	$t3, 0x30		# "0" == 0x30, "1" == 0x31...

loop:
	lbu	$t1, 0($a0)
	addiu	$a0, $a0, 1
	beq	$t1, $t0, done

	multu	$t2, $t0		# multiply value by 10
	mflo	$t2
	subu	$t1, $t1, $t3
	j	loop
	addu	$t2, $t2, $t1

done:
	li	$v0, 1
	move	$a0, $t2
	syscall				# print the integer

	li	$v0, 10
	syscall

		.data
prompt:		.asciiz		"Please enter a positive integer: "
string:		.asciiz		""
