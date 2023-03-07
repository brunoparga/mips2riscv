	.globl  main

main:
	li    $v1, 0		# zero the sum
	li    $t2, 0		# init loop counter
	li    $t1, 0		# init index to 0

for:    beq   $t2, 5, endfor	# for ( i=0; i < 5 ;i++ )
	lw    $v0, array($t1)
	addi  $t1, $t1, 4	# increment index
	addi  $t2, $t2, 1	# increment counter
	b     for
	addu  $v1, $v1, $v0	# sum = sum+array[i]

endfor:
	li    $v0, 10		# exit
	syscall

	.data
array:  .word  1, 2, 3, -5, 1
