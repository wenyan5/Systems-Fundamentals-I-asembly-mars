.data
Newline: .asciiz "\n"
WrongArgMsg: .asciiz "You must provide exactly one argument"
BadToken: .asciiz "Unrecognized Token"
ParseError: .asciiz "Ill Formed Expression"
ApplyOpError: .asciiz "Operator could not be applied"
Comma: .asciiz ","

arg1_addr : .word 0
num_args : .word 0

val_stack : .word 0
op_stack : .word 0
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
  
loop:
  li $t2,'('
  li $t3,')'
  lb $t1,0($s1)
  beqz $t1,done
  addi $s1,$s1,1
  
  move $t9,$t1
  li $t4,49
  beq $t1,$t4,is_digit
  
  move $t1,$t9
  jal is_digit
  beq $v0,$0,checkdig
  j endpushval

checkdig:
  bne $t5,$0,pushval
  j endpushval
pushval:
  sw $t5,0($s2)
  addi $s2,$s2,-4
  li $t5,0
  addi $s4,$s4,4

endpushval:
  move $t1,$t9 
  

  jal is_digit
  bne $v0,$0,store_val
  j loop
  
 
store_val:
  mul $t5,$t5,$t4
  add $t5,$t5,$t1 
  j loop

done:
  bne $t5,$0, pushvala
  j notpushvala
pushvala:
  sw $t5,0($s2)
  addi $s2,$s2,-4
  li $t5,0
  addi $s4,$s4,4
notpushvala:
  move $a0,$s4
  li $v0, 1
  syscall
  
  addi $s2,$s2,4
  lw $t1,0($s2)
  move $a0,$t1
  li $v0, 1
  syscall
end:
  # Terminates the program
  li $v0, 10
  syscall
  


is_digit:
  addi $sp, $sp, -4
  sw $ra, 0($sp)
  li $t2,'0'
  li $t3,'9'
  blt $t1,$t2,toolow
  bgt $t1,$t3,toohigh 
  addi $t1,$t1,-48
  li $v0,1
  lw $ra, 0($sp)
  addi $sp, $sp, 4
  jr $ra
toolow:
toohigh:
  li,$v0,0
  lw $ra, 0($sp)
  addi $sp, $sp, 4
  jr $ra 



#.include "hw2-funcs.asm"
