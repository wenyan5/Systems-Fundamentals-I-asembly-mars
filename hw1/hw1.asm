.data
ErrMsg: .asciiz "Invalid Argument"
WrongArgMsg: .asciiz "You must provide exactly two arguments"
EvenMsg: .asciiz "Even"
OddMsg: .asciiz "Odd"

arg1_addr : .word 0
arg2_addr : .word 0
num_args : .word 0

.text:
.globl main
main:
	sw $a0, num_args

	lw $t0, 0($a1)
	sw $t0, arg1_addr
	lw $s1, arg1_addr

	lw $t1, 4($a1)
	sw $t1, arg2_addr
	lw $s2, arg2_addr

	j start_coding_here

# do not change any line of code above this section
# you can add code to the .data section
start_coding_here: 
	li $v0,'('
	move $a0,$v0
	li $v0,1
	
	syscall
	li $v0,10
	syscall	


	li $t2, 2
	bne $a0, $t2,W1   # check argu num
	lbu $t2, 0($t0)
	li $t3, 'O'
	beq $t3,$t2,part1.3
	li $t3, 'S'
	beq $t3,$t2,part1.3
	li $t3, 'T'
	beq $t3,$t2,part1.3
	li $t3, 'I'
	beq $t3,$t2,part1.3
	li $t3, 'E'
	beq $t3,$t2,part1.3
	li $t3, 'C'
	beq $t3,$t2,part1.3
	li $t3, 'X'
	beq $t3,$t2,part1.3
	li $t3, 'M'
	beq $t3,$t2,part1.3
	j W2

part1.3: 	
	lb $a0 ,0($t1)
	li $t3, '0'
	bne $a0, $t3, W2
	lb $a0 ,1($t1)
	li $t3, 'x'
	bne $a0, $t3, W2
	li $t3, 0
	
loop:
	lb  $a0,2($t1)
    	beqz $a0,part2 
    	
    	li $t2,48
    	blt $a0,$t2,W2
    	li $t2,90
    	bgt $a0,$t2,W2
    	li $t2,58
    	beq $a0,$t2,W2
    	li $t2,59
    	beq $a0,$t2,W2
    	li $t2,60
    	beq $a0,$t2,W2
    	li $t2,61
    	beq $a0,$t2,W2
    	li $t2,62
    	beq $a0,$t2,W2
    	li $t2,63
    	beq $a0,$t2,W2
    	li $t2,64
    	beq $a0,$t2,W2
    	
    	addi $t3,$t3,1
    	addi $t1,$t1,1
    	j loop
    
part2:	
	li,$t2,8
	blt $t3, $t2,W2

	lbu $t2, 0($s1)
	li $t3, 'O'
	beq $t3,$t2,part2a
	
	lbu $t2, 0($s1)
	li $t3, 'S'
	beq $t3,$t2,part2b
	
	lbu $t2, 0($s1)
	li $t3, 'T'
	beq $t3,$t2,part2c
	
	lbu $t2, 0($s1)
	li $t3, 'I'
	beq $t3,$t2,part2d
	
	lbu $t2, 0($s1)
	li $t3, 'E'
	beq $t3,$t2,part3
	
	lbu $t2, 0($s1)
	li $t3, 'C'
	beq $t3,$t2,part4
	
	lbu $t2, 0($s1)
	li $t3, 'X'
	beq $t3,$t2,part5a
	
	lbu $t2, 0($s1)
	li $t3, 'M'
	beq $t3,$t2,part5b
	
part2a:	
	li $t7,28
	li $t8,4
	li $t9,0       #bianry
	li $t4,0
	li $t5,8
for2a:
	beq $t4,$t5,finish2a
	lb $t2,2($s2)
	li $t3,60
	ble $t2,$t3,changep2a1
	bge $t2,$t3,changep2a2
changep2a1:
	li $t3,48 
	sub $t6,$t2,$t3
	addi $t4,$t4,1
	j finishp2a1
changep2a2:
	li $t3,55
	sub $t6,$t2,$t3
	addi $t4,$t4,1
	j finishp2a1
finishp2a1:
	sllv $t6,$t6,$t7
	add $t9,$t9,$t6
	addi $s2,$s2,1
	sub $t7,$t7,$t8
	j for2a
finish2a:
	srl $t9,$t9,26
	move $a0,$t9
	li $v0,1
	syscall	
	li $v0,10
	syscall	

part2b:
	li $t7,28
	li $t8,4
	li $t9,0       #bianry
	li $t4,0
	li $t5,8
for2b:
	beq $t4,$t5,finish2b
	lb $t2,2($s2)
	li $t3,60
	ble $t2,$t3,changep2b1
	bge $t2,$t3,changep2b2
changep2b1:
	li $t3,48 
	sub $t6,$t2,$t3 
	addi $t4,$t4,1
	j finishp2b1
changep2b2:
	li $t3,55
	sub $t6,$t2,$t3 
	addi $t4,$t4,1
	j finishp2b1
finishp2b1:
	sllv $t6,$t6,$t7
	add $t9,$t9,$t6
	addi $s2,$s2,1
	sub $t7,$t7,$t8
	j for2b
finish2b:
	sll $t9,$t9,6
	srl $t9,$t9,27
	move $a0,$t9
	li $v0,1
	syscall	
	li $v0,10
	syscall	
	
part2c:
	li $t7,28
	li $t8,4
	li $t9,0       #bianry
	li $t4,0
	li $t5,8
for2c:
	beq $t4,$t5,finish2c
	lb $t2,2($s2)
	li $t3,60
	ble $t2,$t3,changep2c1
	bge $t2,$t3,changep2c2
changep2c1:
	li $t3,48 
	sub $t6,$t2,$t3 
	addi $t4,$t4,1
	j finishp2c1
changep2c2:
	li $t3,55
	sub $t6,$t2,$t3
	addi $t4,$t4,1
	j finishp2c1
finishp2c1:
	sllv $t6,$t6,$t7
	add $t9,$t9,$t6
	addi $s2,$s2,1
	sub $t7,$t7,$t8
	j for2c
	
finish2c:
	sll $t9,$t9,11
	srl $t9,$t9,27
	move $a0,$t9
	li $v0,1
	syscall	
	li $v0,10
	syscall	
	
part2d:
	li $t7,28
	li $t8,4
	li $t9,0       #bianry
	li $t4,0
	li $t5,8
for2d:
	beq $t4,$t5,finish2dend
	lb $t2,2($s2)
	li $t3,60
	ble $t2,$t3,changep2d1
	bge $t2,$t3,changep2d2
	
changep2d1:
	li $t3,48 
	sub $t6,$t2,$t3 
	addi $t4,$t4,1
	j finish2d1
changep2d2:
	li $t3,55
	sub $t6,$t2,$t3 
	addi $t4,$t4,1
	j finish2d1
	
finish2d1:
	sllv $t6,$t6,$t7
	add $t9,$t9,$t6
	addi $s2,$s2,1
	sub $t7,$t7,$t8
	j for2d
	
finish2dend:
	sll $t9,$t9,16
	sra $t9,$t9,16
	move $a0,$t9
	li $v0,1
	syscall
	li $v0,10
	syscall

part3:	
	lb $t5, 9($s2)
	li $t6,'0'
	beq $t5 ,$t6,Even
	li $t6,'1'
	beq $t5 ,$t6,Odd
	li $t6,'2'
	beq $t5 ,$t6,Even
	li $t6,'3'
	beq $t5 ,$t6,Odd
	li $t6,'4'
	beq $t5 ,$t6,Even
	li $t6,'5'
	beq $t5 ,$t6,Odd
	li $t6,'6'
	beq $t5 ,$t6,Even
	li $t6,'7'
	beq $t5 ,$t6,Odd
	li $t6,'8'
	beq $t5 ,$t6,Even
	li $t6,'9'
	beq $t5 ,$t6,Odd
	li $t6,'A'
	beq $t5 ,$t6,Even
	li $t6,'B'
	beq $t5 ,$t6,Odd
	li $t6,'C'
	beq $t5 ,$t6,Even
	li $t6,'D'
	beq $t5 ,$t6,Odd
	li $t6,'E'
	beq $t5 ,$t6,Even
	li $t6,'F'
	beq $t5 ,$t6,Odd
	
part4:
	li $t7,28
	li $t8,4
	li $t9,0       #bianry
	li $t4,0
	li $t5,8
for4:
	beq $t4,$t5,finish4
	lb $t2,2($s2)
	li $t3,60
	ble $t2,$t3,changep41
	bge $t2,$t3,changep42
	
changep41:
	li $t3,48 
	sub $t6,$t2,$t3
	addi $t4,$t4,1
	j finishp41
	
changep42:
	li $t3,55
	sub $t6,$t2,$t3
	addi $t4,$t4,1
	j finishp41
	
finishp41:
	sllv $t6,$t6,$t7
	add $t9,$t9,$t6
	addi $s2,$s2,1
	sub $t7,$t7,$t8
	j for4
finish4:
	li $t2, 0 		# counter = 0
	li $t3, 1 		# position = 1
	li $t4, 0 		# i = 0

part4count:
	and $t5,$t9,$t3
	beqz $t5, end_if
	addi $t2, $t2, 1
end_if:
	sll $t3, $t3, 1
	addi $t4, $t4, 1
	li $t6, 32
	blt $t4, $t6, part4count
	
part4done:
	move $a0, $t2
	li $v0, 1
	syscall

	li $v0,10
	syscall	
	
part5a:
	li $t7,28
	li $t8,4
	li $t9,0       #bianry
	li $t4,0
	li $t5,8
for5a:
	beq $t4,$t5,finish5a
	lb $t2,2($s2)
	li $t3,60
	ble $t2,$t3,changep5a1
	bge $t2,$t3,changep5a2
changep5a1:
	li $t3,48 
	sub $t6,$t2,$t3 
	addi $t4,$t4,1
	j finishp5a1
changep5a2:
	li $t3,55
	sub $t6,$t2,$t3 
	addi $t4,$t4,1
	j finishp5a1
finishp5a1:
	sllv $t6,$t6,$t7
	add $t9,$t9,$t6
	addi $s2,$s2,1
	sub $t7,$t7,$t8
	j for5a
finish5a:
	sll $t9,$t9,1
	srl $t9,$t9,24
	li $t3, 127
	sub $t9,$t9,$t3
	move $a0,$t9
	li $v0,1
	syscall
	li $v0,10
	syscall	
	
part5b:
	li $t7,28
	li $t8,4
	li $t9,0       #bianry
	li $t4,0
	li $t5,8
for5b:
	beq $t4,$t5,finish5b
	lb $t2,2($s2)
	li $t3,60
	ble $t2,$t3,changep5b1
	bge $t2,$t3,changep5b2
changep5b1:
	li $t3,48 
	sub $t6,$t2,$t3
	addi $t4,$t4,1
	j finishp5b1
changep5b2:
	li $t3,55
	sub $t6,$t2,$t3
	addi $t4,$t4,1
	j finishp5b1
finishp5b1:
	sllv $t6,$t6,$t7
	add $t9,$t9,$t6
	addi $s2,$s2,1
	sub $t7,$t7,$t8
	j for5b
finish5b:
	li $a0, 1
	li $v0,1
	syscall
	li $a0, '.'
	li $v0,11
	syscall
	sll $t9,$t9,9
	move $a0,$t9
	li $v0,35
	syscall
	li $v0,10
	syscall	

Odd:
	la $a0,OddMsg
	li $v0,4
	syscall
	li $v0,10
	syscall	
Even:
	la $a0,EvenMsg
	li $v0,4
	syscall
	li $v0,10
	syscall	
W1:
	la $a0,WrongArgMsg
	li $v0,4
	syscall
	li $v0,10
	syscall	
W2:
	la $a0,ErrMsg
	li $v0,4
	syscall
	li $v0,10
	syscall	
