.data
Newline: .asciiz "\n"
WrongArgMsg: .asciiz "You must provide exactly one argument"
BadToken: .asciiz "Unrecognized Token"
ParseError: .asciiz "Ill Formed Expression"
ApplyOpError: .asciiz "Operator could not be applied"

val_stack : .word 0
op_stack : .word 0

.text
.globl main
main:

  # add code to test call and test apply_bop function
  li $t6,-1
  li $t1,'/'
  li $t7,2
  li $t2,'+'
  li $t3,'-'
  li $t4,'*'
  li $t5,'/'
  beq $t1,$t2,addp4
  beq $t1,$t3,subp4
  beq $t1,$t4,mulp4
  beq $t1,$t5,divp4
  
addp4:
  add $v0,$t6,$t7
  move $a0,$v0
  li $v0, 1
  syscall
  j end
  
subp4:
  sub $v0,$t6,$t7
  move $a0,$v0
  li $v0, 1
  syscall
  j end
  
mulp4:
  mul $v0,$t6,$t7 
  move $a0,$v0
  li $v0, 1
  syscall
  j end
  
divp4:
  div $t6,$t7 
  mflo $v0   
  move $a0,$v0
  li $v0, 1
  syscall
  j end
  
end:
  # Terminates the program
  li $v0, 10
  syscall

.include "hw2-funcs.asm"
