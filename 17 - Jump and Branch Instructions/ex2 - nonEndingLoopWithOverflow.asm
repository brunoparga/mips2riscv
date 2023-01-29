##  Write a program that adds $8 to itself inside a non-ending loop. Initialize
##  $8 before the loop is entered. Use the add instruction so that when overflow
##  is detected the program ends with a trap.

##  Now change the add instruction to addu. Now when overflow occurs, nothing
##  happens. Run the program and observe the difference.

	.text
	.globl	main

main:
	ori	$8, $0, 1

loop:
	j	loop
	addu	$8, $8, $8

##  Since `add` traps overflows, it throws an error once the sum reaches 2^32.
##  `addu` happily adds 0x4000_0000 (2^30) to itself, giving 0x8000_0000, which
##  in two's complement is -(2^31). Added to itself, the only significant bit
##  overflows and the result is zero.
