# Write a program that asks the user for an integer and then computes the square
# root of that integer. Use only integer arithmetic. The integer square root of
# N is the positive integer X who's square is exactly N, or who's square is less
# than N but as close to N as possible. Examples:

# iSqrt(25) == 5 since 5*5 == 25.
# iSqrt(29) == 5 since 5*5 == 25 and 6*6 == 36, so 6 is too big.
# iSqrt(60) == 8 since 8*8 == 56 and 9*9 == 81, so 9 is too big.
# iSqrt(0) == 0,  iSqrt(1) == 1, iSqrt(2) == 1.

# The integer square root is undefined for negative integers.

# There are various fast ways of computing the integer square root (Newton's
# method is one). But for this program, use a counting loop that generates
# integers 0, 1, 2, 3, ... and their squares 0, 1, 4, 9, ... As soon as the
# square of an integer exceeds N, then the previous integer is the integer
# square root of N.

# The logic for this exercise has already been implemented in chapter 19,
# exercise 4.
