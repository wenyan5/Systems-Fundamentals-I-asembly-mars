.data
filename: .asciiz "moves03.txt"
.align 0
moves: .byte 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
.text
.globl main
main:
la $a0, moves
la $a1, filename
jal load_moves

# You must write your own code here to check the correctness of the function implementation.

move $a0,$v0
li $v0, 1
syscall

la $t1, moves
li $t6,11
print11:
	beqz $t6,printend11
	lb $t3,0($t1)
	addi $t1,$t1,1
	addi $t6,$t6,-1
	move $a0,$t3
	li $v0,1
	#syscall
	addi $a0,$0,0xA
	li $v0,11
	#syscall
	j print11
	
printend11:



li $v0, 10
syscall

.include "hw3.asm"
