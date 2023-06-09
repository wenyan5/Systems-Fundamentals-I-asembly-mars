.data
Newline: .asciiz "\n"
WrongArgMsg: .asciiz "You must provide exactly one argument"
BadToken: .asciiz "Unrecognized Token"
ParseError: .asciiz "Ill Formed Expression"
ApplyOpError: .asciiz "Operator could not be applied"

val_stack : .word 0
op_stack : .word 0
arg1_addr : .word 0
num_args : .word 0



.text
.globl main
main:
  
	sw $a0, num_args
  
	lw $t0, 0($a1)
 sw $t0, arg1_addr 
	lw $s1, arg1_addr
   lb $t3,0($s1)
  # add code to call and test valid_op function
   li $s4,0       #tp  int
  li $s5,0        #tp op  
  la $s2,val_stack
  la $s3,op_stack
  li $t4,10
  li $t5,0        
  #lui $s2,0x1000
  #ori $s2,$s2,0x7000
  # add code to call and test stack_push function
  

push_op:
  addi $sp, $sp, -4
  sw $ra, 0($sp)

  sw $t1,0($s3)
  addi $s3, $s3, -4
  addi $t5,$t5,4
  move $v0,$s5

  lw $ra, 0($sp)
  addi $sp, $sp, 4
  jr $ra


  
  li $t1,'+'
  jal push_op
  move $a0,$s5
  li $v0, 1
  syscall



end:
  # Terminates the program

  li $v0, 10
  syscall

#.include "hw2-funcs.asm"
