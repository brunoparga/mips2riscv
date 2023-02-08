##  A loop that counts from 0 to 10

	.text
	.globl	main

init:
	ori	$8, $0, 0	# count = 0

test:
	sltiu	$9, $8, 10	# count < 10
	beq	$9, $0, endLp	# end loop if count >= 10
	sll	$0, $0, 0	# delay

				# do stuff

	addiu	$8, $8, 1	# count++ ;
	j	test
	sll	$0, $0, 0	# delay

endLp:
	sll	$0, $0, 0	# branch target
