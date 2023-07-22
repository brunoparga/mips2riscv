# In the data section declare linked list nodes for the integers 2 through 25
# (using copy and paste in your text editor will help here.) Declare two symbolic
# addresses headP for the address of the node that contains 2, and headC for the
# address of the node that contains 4.

# Regard headP as the head element for a linked list of primes. Edit the nodes
# that belong in this list so that they are linked together in order.

# Regard headC as the head element for a linked list of composite numbers (all
# those not prime). Edit the nodes that belong in this list so that they are
# linked together in order.

# Write a program (much like the one above) that first prints out the elements in
# the list of primes and then prints out the elements in the list of composites.
# Writing a subroutine that traverses a linked list would be very useful here.

		.data
headP:
elt2:		.word		2
		.word		elt3

elt3:		.word		3
		.word		elt5

headC:
elt4:		.word		4
		.word		elt6

elt5:		.word		5
		.word		elt7

elt6:		.word		6
		.word		elt8

elt7:		.word		7
		.word		elt11

elt8:		.word		8
		.word		elt9

elt9:		.word		9
		.word		elt10

elt10:		.word		10
		.word		elt12

elt11:		.word		11
		.word		elt13

elt12:		.word		12
		.word		elt14

elt13:		.word		13
		.word		elt17

elt14:		.word		14
		.word		elt15

elt15:		.word		15
		.word		elt16

elt16:		.word		16
		.word		elt18

elt17:		.word		17
		.word		elt19

elt18:		.word		18
		.word		elt20

elt19:		.word		19
		.word		elt23

elt20:		.word		20
		.word		elt21

elt21:		.word		21
		.word		elt22

elt22:		.word		22
		.word		elt24

elt23:		.word		23
		.word		0

elt24:		.word		24
		.word		elt25

elt25:		.word		25
		.word		0

welcome:	.asciiz		"Welcome to the printer of primes and composite numbers!\n"
primes:		.asciiz		"Here are the primes up to 25: "
composites:	.asciiz		"And here are the composite numbers: "
doneMsg:	.asciiz		"Thank you!\n"

		.text
		.globl		main
main:
	li	$v0, 4
	la	$a0, welcome
	syscall

	la	$a0, primes
	syscall

	la	$a0, headP
	jal	printList
	nop

	li	$v0, 4
	la	$a0, composites
	syscall

	la	$a0, headC
	jal	printList
	nop

	li	$v0, 4
	la	$a0, doneMsg
	syscall

	li	$v0, 10
	syscall
