############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################

############################## Do not .include any files! #############################

.text
eval:
  addi $sp, $sp, -20
  sw $s1, 0($sp)
  sw $s2, 4($sp)
  sw $s3, 8($sp)
  sw $s6, 12($sp)
  sw $s7, 16($sp)
  sw $ra, 20($sp)
  li $t8,-4       #tp  int
  li $t9,-4        #tp op  
  la $s2,val_stack
  addi $s2,$s2,2004
  la $s3,op_stack
  li $t4,10
  li $s6,0                 #int total
  li $s7,1996

loop:
  bgt $t8,$s7,ParseErr
  bgt $t9,$s7,ParseErr
  lb $t1,0($s1)
  beqz $t1,done
  addi $s1,$s1,1
  
  move $t0,$t1
  li $t2,48
  beq $t1,$t2,push0
  move $a0,$t1
  jal is_digit
  beq $v0,$0,checkdig
  j endpushval

push0:
  sw $s6,0($s2)
  addi $s2,$s2,-4
  addi $t8,$t8,4
  j loop

checkdig:
  bne $s6,$0,pushval
  j endpushval
pushval:
  sw $s6,0($s2)
  addi $s2,$s2,-4
  li $s6,0
  addi $t8,$t8,4

endpushval:
  move $t1,$t0
  li $t2,'('
  beq $t1,$t2,pushop
  li $t3,')'
  beq $t1,$t3,braceloop

  #move $t9,$t1
  move $a0,$t1
  jal valid_ops
  bne $v0,$0,oploop
  
  move $t1,$t0
  move $a0,$t1
  jal is_digit
  bne $v0,$0,store_val
  beq $v0,$0,BadTokenerror
  j loop

store_val:
  li $t4,10
  mul $s6,$s6,$t4 
  add $s6,$s6,$t1 
  j loop

done:
  bne $s6,$0, pushvala
  j notpushvala
pushvala:
  sw $s6,0($s2)
  addi $s2,$s2,-4
  li $s6,0
  addi $t8,$t8,4
notpushvala:

  remain:
    li $t2,-4
    beq $t9,$t2,endremain
    jal calculation
    j remain
  endremain:
    li $t2,0
    bne $t8,$t2,ParseErr

    move $a0,$t8
    move $a1,$s2
    jal pop_val
    move $a0,$v1
    li $v0,1
    syscall


  lw $s1, 0($sp)
  lw $s2, 4($sp)
  lw $s3, 8($sp)
  lw $s6, 12($sp)
  lw $s7, 16($sp)
  lw $ra, 20($sp)
addi $sp, $sp, 20
jr $ra


  
oploop:
  checkhigher:
  move $t1,$t0
  li $t2,-4
  beq $t9,$t2,endcheckhigher
  move $a0,$t1
  jal op_precedence
  move $t5,$v0              # i element
  move $a0,$t9
  move $a1,$s3
  jal stack_peek
  move $t1,$v0
  move $a0,$t1
  jal op_precedence
  move $t6,$v0
  blt $t6,$t5,endcheckhigher

  jal calculation
  j checkhigher

  endcheckhigher:
    move $t1,$t0

    move $a0,$t1
    move $a1,$t9
    move $a2,$s3
    jal push_op
    j loop

braceloop:
  stillbrace:
  move $a0,$t9
  move $a1,$s3
  jal stack_peek
  li $t2,'('
  beq $v0,$t2,endstillbrace

  move $a0,$t9
    move $a1,$s3
  jal pop_op
  move $t5,$v1
  move $a0,$t8
  move $a1,$s2
  jal pop_val
  move $t6,$v1
  move $a0,$t8
  move $a1,$s2
  jal pop_val
  move $t7,$v1

  move $a0,$t7
  move $a1,$t5
  move $a2,$t6
  jal apply_bop
  move $t1,$v0

  move $a0,$t1
  move $a1,$t8
  move $a2,$s2
  jal push_val
  j stillbrace
endstillbrace:
  move $a0,$t9
    move $a1,$s3
  jal pop_op
  j loop


calculation:
  addi $sp, $sp, -4
  sw $ra, 0($sp)
  
  move $a0,$t9
    move $a1,$s3
  jal pop_op
  move $t5,$v1
  move $a0,$t8
    move $a1,$s2
  jal pop_val
  move $t6,$v1
  move $a0,$t8
    move $a1,$s2
  jal pop_val
  move $t7,$v1

  move $a0,$t7
  move $a1,$t5
  move $a2,$t6
  jal apply_bop
  move $t1,$v0

  move $a0,$t1
  move $a1,$t8
  move $a2,$s2
  jal push_val

  lw $ra, 0($sp)
  addi $sp, $sp, 4
  jr $ra


pushop:
  sw $t1,0($s3)
  addi $s3,$s3, -4
  addi $t9,$t9,4
  j loop


is_digit:
  li $t2,'0'
  li $t3,'9'
  blt $t1,$t2,toolow
  bgt $t1,$t3,toohigh 
  addi $t1,$t1,-48
  li $v0,1
  jr $ra
toolow:
toohigh:
  li,$v0,0
  jr $ra 


stack_push: 
  addi $sp, $sp, -4
  sw $ra, 0($sp)
  
  move $a0,$t1
  jal is_digit
  beq $v0,$0,op1
  bne $v0,$0,pu1

op1:
  move $a0,$t1
  move $a1,$t9
  move $a2,$s3
  jal push_op
  lw $ra, 0($sp)
  addi $sp, $sp, 4
  jr $ra
pu1:
  move $a0,$t1
  move $a1,$t8
  move $a2,$s2
  jal push_val
  lw $ra, 0($sp)
  addi $sp, $sp, 4
  jr $ra
  
push_val:
  sw $t1,0($s2)
  addi $s2,$s2,-4
  addi $t8,$t8,4
  move $v0,$t8
  jr $ra

push_op:
  sw $t1,0($s3)
  addi $s3,$s3, -4
  addi $t9,$t9,4
  move $v0,$t9
  jr $ra


stack_peek:
  addi $sp, $sp, -4
  sw $ra, 0($sp)

  addi $a1,$a1,4
  lw $v0,0($a1)

  lw $ra, 0($sp)
  addi $sp, $sp, 4
  jr $ra 


pop_val:
  li $t2,-4
  beq $t8, $t2, ParseErr

  addi $s2,$s2,4
  lw $v1,0($s2)
  addi $t8,$t8,-4
  move $v0,$t8
  jr $ra

pop_op:
  li $t2,-4
  beq $t9, $t2, ParseErr

  addi $s3,$s3,4
  lw $v1,0($s3)
  addi $t9,$t9,-4
  move $v0,$t9
  jr $ra

stack_pop:
  addi $sp, $sp, -4
  sw $ra, 0($sp)
 
  move $a0,$t1
  jal is_digit
  beq $v0,$0,op2
  bne $v0,$0,pu2

op2:
  move $a0,$t1
  move $a1,$t9
  move $a2,$s3
  jal push_op
  lw $ra, 0($sp)
  addi $sp, $sp, 4
  jr $ra
pu2:
  move $a0,$t1
  move $a1,$t8
  move $a2,$s2
  jal push_val
  lw $ra, 0($sp)
  addi $sp, $sp, 4
  jr $ra
  

is_stack_empty:
  sle $v0,$a0,$0
  jr $ra


valid_ops:
  li $t2,'+'
  beq $t1,$t2,match
  li $t2,'-'
  beq $t1,$t2,match
  li $t2,'*'
  beq $t1,$t2,match
  li $t2,'/'
  beq $t1,$t2,match
  li $v0,0
  jr $ra
match:
  li $v0,1
  jr $ra


op_precedence:
  li $t2,'+'
  beq $t1,$t2,prece1
  li $t2,'-'
  beq $t1,$t2,prece1
  li $t2,'*'
  beq $t1,$t2,prece2
  li $t2,'/'
  beq $t1,$t2,prece2
  li $t2,'('
  beq $t1,$t2,prece3
  li $t2,')'
  beq $t1,$t2,prece3
  j BadTokenerror
prece1:
  li $v0,0
  jr $ra
prece2:
  li $v0,1
  jr $ra
prece3:
  li $v0,-1
  jr $ra

apply_bop:
  li $t2,'+'
  beq $t5,$t2,addp4
  li $t2,'-'
  beq $t5,$t2,subp4
  li $t2,'*'
  beq $t5,$t2,mulp4
  li $t2,'/'
  beq $t5,$t2,divp4

addp4:
  add $v0,$t7,$t6
  jr $ra
subp4:
  sub $v0,$t7,$t6
  jr $ra
mulp4:
  mul $v0,$t7,$t6
  jr $ra
divp4:
  li $t2,0
  beq $t6,$0,ApplyOpErr
  blt $t6,$0,add71
  j endadd71
add71:
  addi $t2,$t2,1
endadd71:
  blt $t7,$0,add81
  j endadd81
add81:
  addi $t2,$t2,1
endadd81:
  li $t3,1
  beq $t2,$t3,negative
  div $t7,$t6
  mflo $v0 
  j notnegative
negative: 
  div $t7,$t6
  mflo $v0
  mfhi $t2
  beq $t2,$0,notnegative
  addi $v0,$v0,-1
notnegative:
  jr $ra



ApplyOpErr:
  la $a0,ApplyOpError
  li $v0,4
  syscall
  li $v0,10
  syscall
ParseErr:
  la $a0,ParseError
  li $v0,4
  syscall
  li $v0,10
  syscall
BadTokenerror:
  la $a0,BadToken
  li $v0,4
  syscall
  li $v0,10
  syscall
