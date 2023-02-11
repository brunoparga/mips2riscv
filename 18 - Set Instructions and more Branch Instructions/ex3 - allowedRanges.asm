# A temperature in $8 is allowed to be within either of two ranges:
# 20 <= temp <= 40 and 60 <= temp <= 80. Write a program that sets a flag
# (register $3) to 1 if the temperature is in an allowed range and to 0 if
# the temperature is not in an allowed range.

# It would be helpful to draw a flowchart before you start programming.

	.text
	.globl	main

main:
	ori	$3, $0, 0		# isAllowed = 0
	ori	$9, $0, 0		# temporary = 0

isTooCold:
	ori	$9, $0, 19
	slt	$9, $9, $8		# notTooCold = 19 < temperature
	beq	$9, $0, done		# if (!notTooCold) { goto done }
	slti	$9, $8, 81		# notTooHot = temperature < 81
	beq	$9, $0, done		# if (!notTooHot) { goto done }

	# At this point we know 20 <= temperature <= 80.
	# We need to eliminate the interval 40 < temperature < 60.
	ori	$9, $0, 40
	slt	$9, $9, $8		# notCoolEnough = 40 < temperature
	beq	$9, $0, isAllowed	# if (!notCoolEnough) { goto isAllowed }
	ori	$9, $0, 59
	slt	$9, $9, $8		# warmEnough = 59 < temperature
	beq	$9, $0, done		# if (!warmEnough) { goto done }
	sll	$0, $0, 0		# nop; needed to prevent false positive

isAllowed:
	addiu	$3, $0, 1		# isAllowed = 1

done:
	sll	$0, $0, 0		# nop
