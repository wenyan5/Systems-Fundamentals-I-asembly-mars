.data
coeff: .word 2  #12
exp: .word  8  #8

.text:
main:
    lw $a0, coeff
    lw $a1, exp
    jal create_term

    #write test code
    move $s1,$v0
    li $t1,-1
    beq $s1,$t1,end
    
    li $t1,12
forloop:
	beq $t1,$0,end
    lw $t2,0($s1)
    move $a0,$t2
    li $v0,1
    syscall
    addi $s1,$s1,4
	addi $t1,$t1,-4
 	j forloop
end:
    li $v0, 10
    syscall

.include "hw5.asm"
