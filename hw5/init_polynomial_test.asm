.data
pair: .word 1 0			#2 8
p: .word 0

.text:
main:
    la $a0, p
    la $a1, pair
    jal init_polynomial

    #write test code
	move $a0,$v0
	li $v0,1
	syscall
	
	li $t2,-1
	bne $a0,$t2,show
	j end
	show:
	la $s1,p
	lw $t1,0($s1)
	lw $t2,0($t1)
	move $a0,$t2
	li $v0,1
	syscall
end:	
    li $v0, 10
    syscall

.include "hw5.asm"
