# # Perform selection sort on an array in memory:

		.data
size:		.word		20
array:		.word		99, 23, 45, 82, 09, 34, 71, 64, 88, 42, 12, 87, 33, 36, 83, 18, 17, 04, 52, 46
comma:		.asciiz		", "

# The selection sort algorithm looks like this:

# int out, in, min, temp;

# // each time the outer loop is
# // executed, replace the element
# // at out with the minimum of the
# // elements to its right.
# for ( out=0; out<size-1; out++ )
# {
#   min = out;

#   // find the location of the minimum
#   // in the remaining elements
#   for ( in=out+1; in<size; in++ )
#     if ( array[in] < array[min] )
#       min = in;

#   // swap the element at out with
#   // the minimun of the remaining elements
#   temp       = array[out];
#   array[out] = array[min];
#   array[min] = temp;
# }
# Write out the array after it has been sorted.

		.text
# Register use
# $t0 -> array size
# $t1 -> outer loop counter
# $t2 -> inner loop counter
# $t3 -> pointer in outer loop
# $t4 -> minimum value found
# $t5 -> candidate to swap with minimum
# $t6 -> temp
# $t7 -> pointer in inner loop
# $t8 -> pointer to minimum

main:
	lw	$t0, size($zero)
	li	$t1, 0

outerLoop:
	# for (out = 0; out < size-1)
	sub	$t0, $t0, 1
	beq	$t1, $t0, printArray
	addu	$t0, $t0, 1

	mul	$t3, $t1, 4		# outPtr = out * sizeof(word)
	move	$t8, $t3		# minPtr = outPtr
	addu	$t2, $t1, 1		# for (_; in = out + 1; _)

innerLoop:
	lw	$t4, array($t8)		# array[minPtr]
	beq	$t2, $t0, swap		# for (in < size; _; _)
	mul	$t7, $t2, 4		# inPtr = in * sizeof(word)

	lw	$t5, array($t7)		# array[inPtr]
	nop

	bge	$t5, $t4, innerLoop	# if (array[inPtr] < array[minPtr])
	addu	$t2, $t2, 1		# for (_; _; in++)

	b	innerLoop
	move 	$t8, $t7		# minPtr = inPtr

swap:
	lw	$t6, array($t3)		# temp = array[outPtr]
	sw	$t4, array($t3)		# array[outPtr] = array[minPtr]
	sw	$t6, array($t8)		# array[minPtr] = temp
	b	outerLoop
	addu	$t1, $t1, 1		# out++

printArray:
	li	$t1, 0

printLoop:
	beq	$t1, $t0, done
	mul	$t3, $t1, 4
	lw	$a0, array($t3)
	li	$v0, 1
	syscall

	li	$v0, 4
	la	$a0, comma
	syscall

	b	printLoop
	addu	$t1, $t1, 1

done:
	li	$v0, 10
	syscall
