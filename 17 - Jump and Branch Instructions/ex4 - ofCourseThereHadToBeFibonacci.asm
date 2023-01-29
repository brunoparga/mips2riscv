##  Write a program that computes terms of the Fibonacci series, defined as:

##  1, 1, 2, 3, 5, 8, 13, 21, 34, 55, ...

##  Each term in the series is the sum of the preceeding two terms. So, for
##  example, the term 13 is the sum of the terms 5 and 8.

##  Write the program as a counting loop that terminates when the first 100
##  terms of the series have been computed. Use a register for the current term
##  and a register for the previous term. Each execution of the loop computes a
##  new current term and then copies the old current term to the previous term
##  register.

##  Notice how few machine language instruction this program takes. It would be
##  hard for a compiler to produce such compact code from a program in a high
##  level language. Of course, our program is not doing any IO.

	.text
	.globl	main

##  Register use
##  $8  - current term
##  $9  - previous term
##  $10 - 100 (number of terms)
##  $11 - counter
##  $12 - tmp

main:
	# initialize the first two terms, counter and the length we want
	ori	$8, $0, 1
	ori	$9, $0, 1
	ori	$10, $0, 100
	ori	$11, $0, 0

loop:
	beq	$10, $11, exit
	add	$8, $8, $9		# new = current + previous
	sub	$9, $8, $9		# previous = current
	j	loop
	addi	$11, $11, 1		# counter++

exit:
	sll	$0, $0, 0
