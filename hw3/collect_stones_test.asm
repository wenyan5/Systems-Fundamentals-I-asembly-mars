.data
player: .byte 'T' 
stones: .word 2
.align 2
state:        
    .byte 4         # bot_mancala       	(byte #0)
    .byte 0         # top_mancala       	(byte #1)
    .byte 6         # bot_pockets       	(byte #2)
    .byte 6         # top_pockets        	(byte #3)
    .byte 2         # moves_executed	(byte #4)
    .byte 'B'    # player_turn        		(byte #5)
    # game_board                     		(bytes #6-end)
    .asciiz
    "0008070601000404040404040404"
.text
.globl main
main:
la $a0, state
lb $a1, player
lb $a2, stones
jal collect_stones
# You must write your own code here to check the correctness of the function implementation.


move $a0,$v0
li $v0, 1
syscall
addi $a0,$0,0xA
li $v0,11
syscall


la $t1, state
li $t2,6
add $a0,$t2,$t1
li $v0,4
syscall


la $t1, state
li $t6,34
print11:
	beqz $t6,printend11
	lb $t3,0($t1)
	addi $t3,$t3,-48
	addi $t1,$t1,1
	addi $t6,$t6,-1
	move $a0,$t3
	li $v0,1
	#syscall
	j print11
	
printend11:


li $v0, 10
syscall

.include "hw3.asm"
