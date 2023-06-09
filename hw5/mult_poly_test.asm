.data
p_pair: .word 5 2
p_terms: .word 	5 2 7 1 0 -1		#7 1 0 -1
q_pair: .word 3 2
q_terms: .word 	-5 2 1 1 0 -1	#1 1 0 -1
p: .word 0
q: .word 0
r: .word 0
N: .word 3

.text:
main:
    la $a0, p
    la $a1, p_pair
    jal init_polynomial

    la $a0, p
    la $a1, p_terms
    lw $a2, N
    jal add_N_terms_to_polynomial

    la $a0, q
    la $a1, q_pair
    jal init_polynomial

    la $a0, q
    la $a1, q_terms
    lw $a2, N
    jal add_N_terms_to_polynomial

	la $a0, p
	sw $0,0($a0)
	
	
    la $a0, p
    la $a1, q
    la $a2, r
    jal mult_poly

    #write test code

	move $a0,$v0
	li $v0, 1
    syscall

	addi $a0,$0,0xA
	li $v0,11
	syscall
 	la $a0, r
    lw $t0,0($a0)
    li $s1,2
    loop:
        beq $s1,$0,end
        lw $t1,0($t0)
        move $a0,$t1
        li $v0, 1
        syscall
        lw $t2,4($t0)
        move $a0,$t2
        li $v0, 1
        syscall
        lw $t3,8($t0)
        addi $a0,$0,0xA
        li $v0,11
        syscall

        move $t0,$t3
        addi $s1,$s1,-1
        j loop
        
        
    end:	
    li $v0, 10
    syscall

.include "hw5.asm"
