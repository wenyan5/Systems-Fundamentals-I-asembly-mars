# add test cases to data section
.data
src: .asciiz "Jane Doe"
dest: .asciiz ""

.text:
main:
	la $a0, src
	la $a1, dest
	jal str_cpy
	#write test code
	
	move $a0,$v0
	li $v0, 1
	syscall
	
	addi $a0,$0,0xA
	li $v0,11
	syscall
	la $a0,dest
	li $v0, 4
	syscall
	
	
	li $v0, 10
	syscall
	
.include "hw4.asm"
