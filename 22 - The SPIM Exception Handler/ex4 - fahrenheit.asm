# Write a program that repeatedly asks the user for a scale F or a C (for
# "Fahrenheit" or "Celsius") on one line followed by an integer temperature on
# the next line. It then converts the given temperature to the other scale. Use
# the formulas:

# F = (9/5)C + 32

# C = (5/9)(F - 32)

# Exit the loop when the user types "Q". Assume that all input is correct.
# For example:

# Enter Scale      : F
# Enter Temperature: 32
# Celsius Temperature: 0C

# Enter Scale      : C
# Enter Temperature: 100
# Fahrenheit Temperature: 212F

# Enter Scale      : Q
# done

		.data

scalePrompt:	.asciiz		"\nEnter input scale:\n(F for Fahrenheit, C for Celsius, Q to quit program)\n"
scale:		.asciiz		" "
tempPrompt:	.asciiz		"\nEnter temperature: "
celsius:	.asciiz		"Celsius Temperature: "
fahrenheit:	.asciiz		"Fahrenheit Temperature: "
goodbye:	.asciiz		"\nThank you for using this program!"

		.text
		.globl	main

main:
	li	$t3, 0x43		# "C" to input Celsius
	li	$t4, 0x46		# "F" to input Fahrenheit
	li	$t6, 0x51		# "Q" to quit

	# Constants used in the conversion C <-> F
	li	$t5, 5
	li	$t1, 9
	li	$t7, 32

prompt:
	# Ask the user which scale they want to use for input
	li	$v0, 4
	la	$a0, scalePrompt
	syscall

	# Store the user's answer in the `scale` symbolic address
	li	$v0, 8
	la	$a0, scale
	li	$a1, 2
	syscall

	# Quit if that is the user's choice
	lb	$t0, 0($a0)
	nop
	beq	$t0, $t6, quit

	# Since the next step is asking for the temperature value
	# (regardless of the input scale), we do that here.
	li	$v0, 4
	la	$a0, tempPrompt
	syscall

	# We read the temperature value and branch if the input is in Celsius
	li	$v0, 5
	beq	$t0, $t3, celsToFahr
	syscall				# $v0 <- integer

	# -----------------------------------------------------------
	# In either case of conversion, $t0 will hold the temperature
	# -----------------------------------------------------------

fahrToCels:
	# First steps of the Fahrenheit to Celsius conversion
	subu	$t0, $v0, $t7		# $t0 = $v0 - 32
	mult	$t0, $t5
	mflo	$t0			# $t0 = 5 * (F - 32)

	# We need to fill the mflo delay, so let's already print
	# the label for the Celsius temperature
	li	$v0, 4
	la	$a0, celsius
	syscall

	# We finish the conversion before printing the final answer
	div	$t0, $t1
	mflo	$a0			# $a0 = 5/9 (F - 32)

	# Print the Celsius value and start over
	li	$v0, 1
	j	prompt
	syscall				# celsius temperature is already in $a0

celsToFahr:
	# Begin converting Celsius to Fahrenheit
	mult	$v0, $t1
	mflo	$t0			# $t0 = 9C

	# We need to fill the mflo delay, so let's already print
	# the label for the Fahrenheit temperature
	li	$v0, 4
	la	$a0, fahrenheit
	syscall

	# We finish the conversion before printing the final answer
	div	$t0, $t5
	mflo	$t0			# $t0 = (9/5)C
	addu	$a0, $t0, $t7		# $t0 = $v0 + 32

	# Print the Fahrenheit value and start over
	li	$v0, 1
	j	prompt
	syscall				# fahrenheit temperature is already in $a0

quit:
	li	$v0, 4
	la	$a0, goodbye
	syscall
	li	$v0, 10
	syscall
