## Put the following bit pattern into register $1:
## DEADBEEF
## Do one nibble at a time
##

	.text
	.globl  main

main:
	ori     $1, $0, 0xD
	sll     $1, $1, 28

	ori     $2, $0, 0xE
	sll     $2, $2, 24
	or      $1, $1, $2

	ori     $2, $0, 0xA
	sll     $2, $2, 20
	or      $1, $1, $2

	ori     $2, $0, 0xD
	sll     $2, $2, 16
	or      $1, $1, $2

	ori     $2, $0, 0xB
	sll     $2, $2, 12
	or      $1, $1, $2

	ori     $2, $0, 0xE
	sll     $2, $2, 8
	or      $1, $1, $2

	ori     $2, $0, 0xE
	sll     $2, $2, 4
	or      $1, $1, $2

	ori     $2, $0, 0xF
	or      $1, $1, $2

# EOF
