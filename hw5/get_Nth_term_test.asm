.data
pair: .word 12 8
terms: .word 4 3  5 0 2 2 0 -1				#16 5 1 8 0 -1
p: .word 0
N: .word 3
N1: .word 2

.text:
main:
    la $a0, p
    la $a1, pair
    jal init_polynomial

    la $a0, p
    la $a1, terms
    lw $a2, N
    jal add_N_terms_to_polynomial
    
    
    move $a0,$v0
	li $v0, 1
    #syscall
    addi $a0,$0,0xA
	li $v0,11
	#syscall
    

    la $a0, p
    lw $a1, N1
    jal get_Nth_term

    #write test code
	
	move $a0,$v0
	li $v0, 1
    syscall
    addi $a0,$0,0xA
	li $v0,11
	syscall
    move $a0,$v1
	li $v0, 1
    syscall
    

    li $v0, 10
    syscall

.include "hw5.asm"
