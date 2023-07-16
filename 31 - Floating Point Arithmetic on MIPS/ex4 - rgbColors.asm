# Colors on a Web page are often coded as a 24 bit integer as follows:

# RRGGBB

# In this, each R, G, or B is a hex digit 0..F. The R digits give the amount of
# red, the G digits give the amount of green, and the B digits give the amount
# of blue. Each amount is in the range 0..255 (the range of one byte).

# Another way that color is sometimes expressed is as three fractions 0.0 to 1.0
# for each of red, green, and blue. For example, pure red is (1.0, 0.0, 0.0),
# medium gray is (0.5, 0.5, 0.5) and so on.

# Write a program that has a color number declared in the data section and that
# writes out the amount of each color expressed as a decimal fraction. Put each
# color number in 32 bits, with the high order byte set to zeros:

		.data
color:		.word 		0x00FF0000     # pure red, (1.0, 0.0, 0.0)
rgb:		.asciiz		"rgb("

# Register use:
# $t0 -> the address of the color code
# $f0 -> RR, the amount of red
# $f2 -> GG, the amount of green
# $f4 -> BB, the amount of blue
# $f6 -> the double 255.0, to divide


		.text
		.globl	main
main:
	la	$t0, color
	lbu	$s0, 2($t0)
	lbu	$s2, 1($t0)
	lbu	$s4, 0($t0)

	li.d	$f6, 255.0

	mtc1	$s0, $f0
	mtc1	$s2, $f2
	mtc1	$s4, $f4

	cvt.d.w	$f0, $f0
	cvt.d.w	$f2, $f2
	cvt.d.w	$f4, $f4

	div.d	$f0, $f0, $f6
	div.d	$f2, $f2, $f6
	div.d	$f4, $f4, $f6

	li	$v0, 4
	la	$a0, rgb
	syscall

	li	$v0, 3
	mov.d	$f12, $f0
	syscall

	li	$v0, 11
	li	$a0, ','
	syscall

	li	$v0, 11
	li	$a0, ' '
	syscall

	li	$v0, 3
	mov.d	$f12, $f2
	syscall

	li	$v0, 11
	li	$a0, ','
	syscall

	li	$v0, 11
	li	$a0, ' '
	syscall

	li	$v0, 3
	mov.d	$f12, $f4
	syscall

	li	$v0, 11
	li	$a0, ')'
	syscall

	li	$v0, 10
	syscall
