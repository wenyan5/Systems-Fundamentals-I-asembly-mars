.data
.align 2
state:        
    .byte 45         # bot_mancala       	(byte #0)
    .byte 0         # top_mancala       	(byte #1)
    .byte 6         # bot_pockets       	(byte #2)
    .byte 6         # top_pockets        	(byte #3)
    .byte 2         # moves_executed	(byte #4)
    .byte 'B'    # player_turn        		(byte #5)
    # game_board                     		(bytes #6-end)
    .asciiz
    #"0108070601000404040404040400"
    "0004040404040400000000000045"
.text
.globl main
main:
la $a0, state
jal check_row
# You must write your own code here to check the correctness of the function implementation.

move $a0,$v0
li $v0, 1
#syscall
move $a0,$v1
li $v0, 1
#syscall


li $t9,6
la $t1, state
print:
	beqz $t9,printend
	lb $t3,0($t1)
	addi $t1,$t1,1
	addi $t9,$t9,-1
	move $a0,$t3
	li $v0,1
	syscall
	j print	
printend:
	add $a0,$0,$t1
	li $v0,4
	syscall






li $v0, 10
syscall

.include "hw3.asm"
