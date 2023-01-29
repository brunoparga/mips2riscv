##  Write a program that computes the sum:

##  1 + 2 + 3 + 4 + 5 + ...

##  Do this by using the j instruction to implement a non-ending loop. Before the
##  loop, initialize a register to zero to contain the sum, and initialize another
##  register to one to be the counter. Inside the loop add the counter to the sum,
##  increment the counter, and jump to the top of the loop.

##  Execute the program by single-stepping (by pushing F10). After you have done
##  this enough to confirm that the program works, look at SPIM's menu and select
##  Simulator and Multiple Step. Enter a number of steps (such as 40) into the
##  window and click "OK". Each step is the execution of one machine cycle. Once
##  you see how this works you can do the same thing more easily by pushing F11.

##  Register use
##  $8  - sum
##  $9  - counter

	.text
	.globl	main

main:
	and	$8, $8, $0
	and	$9, $9, $0		##  Zero registers $8 and $9

loop:
	addiu	$9, $9, 1		##  counter++
	j	loop			##  jump to loop
	addu	$8, $8, $9		##  sum += counter
