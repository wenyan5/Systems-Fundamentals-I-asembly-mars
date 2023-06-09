# add test cases to data section
# Test your code with different Network layouts
# Don't assume that we will use the same layout in all our tests
.data
Name1: .asciiz "Cacophonix"
Name2: .asciiz "Getafix"
Name3: .asciiz "xxxxxx"
Name4: .asciiz "   "
Name5: .asciiz "1 "
Name6: .asciiz "6 "
Frnd_prop: .asciiz "FRIEND"
Name_prop: .asciiz "NAME"

Network:
  .word 5   #total_nodes (bytes 0 - 3)
  .word 10  #total_edges (bytes 4- 7)
  .word 12  #size_of_node (bytes 8 - 11)
  .word 12  #size_of_edge (bytes 12 - 15)
  .word 0   #curr_num_of_nodes (bytes 16 - 19)
  .word 0   #curr_num_of_edges (bytes 20 - 23)
  .asciiz "NAME" # Name property (bytes 24 - 28)
  .asciiz "FRIEND" # FRIEND property (bytes 29 - 35)
   # nodes (bytes 36 - 95)	
  .byte 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0	
   # set of edges (bytes 96 - 215)
  .word 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0

.text:
main:
	la $a0, Network
	jal create_person
	move $s0, $v0
	
	la $a0, Network
	move $a1, $s0
	la $a2, Name_prop
	la $a3, Name1
	jal add_person_property
	
	la $a0, Network
	jal create_person
	move $s1, $v0
	
	la $a0, Network
	move $a1, $s1
	la $a2, Name_prop
	la $a3, Name2
	jal add_person_property
	
	la $a0, Network
	move $a1, $s0
	move $a2, $s1
	jal add_relation
	
	la $a0, Network
	move $a1, $s0
	move $a2, $s1
	jal is_relation_exists
	
	la $a0, Network
	move $a1, $s0
	move $a2, $s1
	la $a3, Frnd_prop
	addi $sp, $sp, -4
	li $s3, 1
	sw $s3, 0($sp) 
	jal add_relation_property
	
	la $a0, Network
	jal create_person
	move $s4, $v0
	
	la $a0, Network
	move $a1, $s4
	la $a2, Name_prop
	la $a3, Name4
	jal add_person_property
	
	
	la $a0, Network
	move $a1, $s0
	move $a2, $s4
	jal add_relation
	
	
	la $a0, Network
	move $a1, $s0
	move $a2, $s4
	jal is_relation_exists
	
	la $a0, Network
	move $a1, $s0
	move $a2, $s4
	la $a3, Frnd_prop
	addi $sp, $sp, -4
	li $s3, 1
	sw $s3, 0($sp) 
	jal add_relation_property
	
	
	la $a0, Network
	la $a1, Name2
	la $a2, Name4
	jal is_friend_of_friend
	
	la $a0, Network
	jal create_person
	move $s5, $v0
	
	la $a0, Network
	move $a1, $s5
	la $a2, Name_prop
	la $a3, Name3
	jal add_person_property
	
	la $a0, Network
	jal create_person
	move $s6, $v0
	
	
	la $a0, Network
	move $a1, $s6
	la $a2, Name_prop
	la $a3, Name5
	jal add_person_property
	

	
	la $a0, Network
	jal create_person
	move $s7, $v0
	
	
	
	la $a0, Network
	move $a1, $s7
	la $a2, Name_prop
	la $a3, Name6
	jal add_person_property
	
	
	#write test code
	
	move $a0,$v0
	li $v0, 1
	syscall
	
	
		la $s1, Network
	addi $s1,$s1,36
	li $t2,5
	li $t3,12
ndloop:
	beqz $t2,ndloopend
	addi $t2,$t2,-1
	move $t4,$t3
	addi $a0,$0,0xA
	li $v0,11
	syscall
	one:
	beqz $t4,ndloop
	lb $a0,0($s1)
	li $v0, 11
	syscall
	addi $s1,$s1,1
	addi $t4,$t4,-1
	j one
	
ndloopend:
	li $t2,2
	li $t3,12
ndloop1:
	beqz $t2,ndloopend1
	addi $t2,$t2,-1
	move $t4,$t3
	addi $a0,$0,0xA
	li $v0,11
	#syscall
	one1:
	beqz $t4,ndloop1
	lw $a0,0($s1)
	li $v0, 1
	syscall
	addi $a0,$0,0xA
	li $v0,11
	syscall
	addi $s1,$s1,4
	addi $t4,$t4,-4
	j one1
	
ndloopend1:


	


	li $v0, 10
	syscall
	
.include "hw4.asm"
