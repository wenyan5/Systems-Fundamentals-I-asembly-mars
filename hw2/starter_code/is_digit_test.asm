.data
Newline: .asciiz "\n"
WrongArgMsg: .asciiz "You must provide exactly one argument"
BadToken: .asciiz "Unrecognized Token"
ParseError: .asciiz "Ill Formed Expression"
ApplyOpError: .asciiz "Operator could not be applied"

val_stack : .word 0
op_stack : .word 0

arg1_addr : .word 0
arg2_addr : .word 0
num_args : .word 0


.text
.globl main
main:

  # add code to call and is_digit function
  
li $s4,0       #tp  int
  li $s5,0        #tp op  
  la $s2,val_stack
  la $s3,op_stack
  li $t4,10
  li $t5,0                  #int total

loop_converint:
  lb $t1,0($s1)
  beqz $t1,pushval
  donep:
  beqz $t1,doneloop_converint
  addi $s1,$s1,1
  jal is_digit
  bne $v0,$0,store_val
  j pushval
store_val:
  mul $t5,$t5,$t4
  add $t5,$t5,$t1 
  j loop_converint
pushval:
  sw $t1,0($s2)
  addi $s2,$s2,4
  li $t5,0
  addi $t4,$t4,4
  j donep

doneloop_converint:
  
  
end:
  # Terminates the program
  li $v0, 10
  syscall

.include "hw2-funcs.asm"
