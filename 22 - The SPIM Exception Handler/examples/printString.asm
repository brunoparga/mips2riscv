	li      $v0,4       	# code 4 == print string
	la      $a0,string  	# $a0 == address of the string
	syscall             	# Ask the operating system to
                    		# perform the service.
	li      $v0,10      	# code 10 == exit
	syscall             	# Return control to the operating system.

        .data
string: .asciiz      "Hello SPIM!\n"