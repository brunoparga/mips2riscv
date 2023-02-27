# Declare two null-terminated strings:

         .data
result:  .word     0
string1: .asciiz   "puffins"
string2: .asciiz   "puFfin"

# Initialize a base register for each string (use the la instruction.) Write a
# program that sets result to 1 if the two strings are equal and to 0 if the
# strings are not equal.

# Two strings are equal if they are the same length and contain the same
# character in each location. Otherwise the strings are not equal.

# Test your program for a variety of strings. You will have to edit the data
# section of your program for each pair of strings tested.

# Extra: write the program so that it does case insensitive string comparison.
# Here, two strings are equal if they are the same length and have the same
# letter (disregarding case) in each location.

	.text
	.globl	main

# Register use
# $t0 -> flag stringsAreEqual
# $t1 -> pointer string1
# $t2 -> pointer string2
# $t3 -> "`", the character immediately before "a"
# $t4 -> char1
# $t5 -> char2
# $t6 -> flag
# $t7 -> flag

main:
	# Initialize flag and pointers
	li	$t0, 1
	la	$t1, string1
	la	$t2, string2

loadFirstChar:
	lbu	$t4, 0($t1)
	li	$t3, 0x60		# to check case
	slt	$t6, $t3, $t4		# "a" or greater
	slti	$t7, $t4, 0x7B		# "z" or lower
	and	$t6, $t6, $t7		# char is lowercase letter
	bne	$t6, $zero, upcaseFirstChar
	nop

loadSecondChar:
	lbu	$t5, 0($t2)
	nop
	slt	$t6, $t3, $t5		# "a" or greater
	slti	$t7, $t5, 0x7B		# "z" or lower
	and	$t6, $t6, $t7		# char is lowercase letter
	bne	$t6, $zero, upcaseSecondChar
	nop

checkEqual:
	# If the upcased chars are different, we're done
	bne	$t4, $t5, notEqual

	# If we get here, the chars are equal
	# If they're both NULL, we're done
	beq	$t4, $zero, done

	# If they're equal and not NULL, we continue
	addiu	$t1, $t1, 1
	j	loadFirstChar
	addiu	$t2, $t2, 1

upcaseFirstChar:
	j	loadSecondChar
	andi	$t4, $t4, 0xFFDF

upcaseSecondChar:
	j	checkEqual
	andi	$t5, $t5, 0xFFDF

notEqual:
	li	$t0, 0		# strings are not equal

done:
	sw	$t0, result
