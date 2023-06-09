.data
Newline: .asciiz "\n"
WrongArgMsg: .asciiz "You must provide exactly one argument"
BadToken: .asciiz "Unrecognized Token"
ParseError: .asciiz "Ill Formed Expression"
ApplyOpError: .asciiz "Operator could not be applied"
Comma: .asciiz ","

val_stack : .word 0
op_stack : .word 0


.text
.globl main
main:

  # add code to call and test stack_empty function 
  	la $s2,val_stack
  	addi $sp,$sp,-4
  	li $t2,3
  	sw $t2,0($sp)
  	addi $sp,$sp,-4
  	li $t2,6
  	sw $t2,0($sp)
  	lw $t2,0($sp)
  	addi $sp,$sp,4
  	lw $t2,0($sp)
  	move $a0,$t2
	li $v0, 1
  	syscall

end:
  # Terminates the program
  li $v0, 10
  syscall

#.include "hw2-funcs.asm"
