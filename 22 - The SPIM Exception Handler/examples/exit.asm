	.text
	.globl	main

main:
	li      $v0,10      # code 10 == exit
	syscall             # Return control to the operating system.
