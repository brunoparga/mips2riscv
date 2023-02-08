##  Say that you are writing a control program for a robot spray painter. The
##  allowed temperature range for the paint is 30 degrees to 55 degrees Celsius.
##  The device driver for the temperature sensor puts the temperature in
##  register $2.

##  Your program will test if the unsigned integer in register $2 is in range.
##  If it is in range, register $3 is set to 1, otherwise to 0.

##  (Sensors often deliver unsigned data. Pretend that our sensor delivers
##  unsigned data in the range of 0 to 100 in register $2.)

	.text
	.globl	main

##  Register use
##  $2  - temperature sensor
##  $3  - temperature is in range
##  $4  - temperature is warm enough
##  $5  - temperature is cool enough
##  $6  - lower temperature bound

main:
	ori	$6, $0, 30		##  minTemp = 30
	sltu	$4, $6, $2		##  warmEnough = minTemp < temperature
	sltiu	$5, $2, 56		##  coolEnough = temperature <= 55
	and	$3, $4, $5		##  inRange = warmEnough && coolEnough
