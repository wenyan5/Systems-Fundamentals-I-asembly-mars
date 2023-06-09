.data
player: .byte 'B'
distance: .byte 1
size: .word 101
.align 2
state:        
    .byte 0         # bot_mancala       	(byte #0)
    .byte 1         # top_mancala       	(byte #1)
    .byte 6         # bot_pockets       	(byte #2)
    .byte 6         # top_pockets        	(byte #3)
    .byte 2         # moves_executed	(byte #4)
    .byte 'B'    # player_turn        		(byte #5)
    # game_board                     		(bytes #6-end)
    .asciiz
    #"0108070601000404040404040400"
    "0004040404040420010240000500"
.text
.globl main
main:
la $a0, state
lb $a1, player
lb $a2, distance
lw $a3, size
jal set_pocket
# You must write your own code here to check the correctness of the function implementation.

move $a0,$v0
li $v0,1
syscall
addi $a0,$0,0xA
li $v0,11
syscall



la $t1, state
li $t2,6
add $a0,$t2,$t1
li $v0,4
syscall




li $v0, 10
syscall

.include "hw3.asm"
