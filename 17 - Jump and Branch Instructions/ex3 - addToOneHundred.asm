##  Write a program that computes the sum:

##  1 + 2 + 3 + 4 + 5 + ... + 98 + 99 + 100

##  Do this, as above, by using the j instruction to implement a non-ending loop.
##  Before the loop, initialize a register to zero to contain the sum, initialize
##  another register to one to be the counter, and another register to 101(10).
##  Inside the loop add the counter to the sum, increment the counter, and jump
##  to the top of the loop.

##  However, now, at the top of the loop put in a beq instruction that branches
##  out of the loop when the counter equals 101(10). The target of the branch should
##  be something like this:

##  exit:    j    exit      #  sponge for excess machine cycles
##           sll   $0,$0,0

##  Now run the program by setting the value of the PC to 0x400000 (as usual) and
##  entering 500 or so for the number of Multiple Steps (F11). Your program will
##  not need so many steps, but that is OK. The excess steps will be used up
##  repeatedly executing the statment labeled "exit".

	.text
	.globl	main

##  Register use
##  $8  - sum
##  $9  - counter
##  $10 - 101 (to end the loop)

main:
	ori	$8, $0, 0
	ori	$9, $0, 0
	ori	$10, $0, 100

loop:
	beq	$9, $10, exit
	addu	$8, $8, $9
	j	loop
	addiu	$9, $9, 1

exit:
	sll	$0, $0, 0
