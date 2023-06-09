.data
origin_pocket: .byte 4     #5
.align 2
state:        
    .byte 0         # bot_mancala       	(byte #0)
    .byte 0         # top_mancala       	(byte #1)
    .byte 6         # bot_pockets       	(byte #2)
    .byte 6         # top_pockets        	(byte #3)
    .byte 2         # moves_executed	(byte #4)
    .byte 'B'    # player_turn        		(byte #5)
    # game_board                     		(bytes #6-end)
    .asciiz
    #"0108070601000404040404040400"
    #"0300090000000000000111090609"
    "0004040404040404040404040000"
.text
.globl main
main:
la $a0, state
lb $a1, origin_pocket
jal execute_move
# You must write your own code here to check the correctness of the function implementation.


move $a0,$v0
li $v0, 1
syscall
move $a0,$v1
li $v0, 1
syscall
addi $a0,$0,0xA
li $v0,11
syscall


la $t1, state
lb $t3,0($t1)
move $a0,$t3
li $v0,1
syscall
addi $a0,$0,0xA
li $v0,11
syscall
lb $t3,1($t1)
move $a0,$t3
li $v0,1
syscall
addi $a0,$0,0xA
li $v0,11
syscall
la $t5, state
lb $t3,5($t5)
move $a0,$t3
li $v0, 1
syscall
addi $a0,$0,0xA
li $v0,11
syscall

li $t9,6
la $t1, state
print:
	beqz $t9,printend
	lb $t3,0($t1)
	addi $t1,$t1,1
	addi $t9,$t9,-1
	move $a0,$t3
	li $v0,1
	#syscall
	j print	
printend:

li $t9,14
print1:
	beqz $t9,printend1
	lb $t3,0($t1)
	addi $t3,$t3,-48
	addi $t1,$t1,1
	addi $t9,$t9,-1
	move $a0,$t3
	li $v0,1
	syscall
	j print1
printend1:
	addi $a0,$0,0xA
	li $v0,11
	syscall
	add $a0,$0,$t1
	li $v0,4
	syscall


li $t9,6
la $t1, state
print8:
	beqz $t9,printend8
	lb $t3,0($t1)
	addi $t1,$t1,1
	addi $t9,$t9,-1
	move $a0,$t3
	li $v0,1
	#syscall
	j print8	
printend8:
	add $a0,$0,$t1
	li $v0,4
	#syscall

li $v0, 10
syscall

.include "hw3.asm"
