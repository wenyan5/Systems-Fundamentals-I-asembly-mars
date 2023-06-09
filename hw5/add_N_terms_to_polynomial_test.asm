.data
pair: .word 2 3			#12 8
terms: .word 4 4 5 1 1 2 0 -1			#16 5 1 8 0 -1
p: .word 0
N: .word 6

.text:
main:
    la $a0, p
    la $a1, pair
    jal init_polynomial
    

    la $a0, p
    la $a1, terms
    lw $a2, N
    jal add_N_terms_to_polynomial

    #write test code
    
    move $s1,$v0
    move $a0,$v0
    li $v0, 1
    syscall
 
 

    addi $a0,$0,0xA
	li $v0,11
	syscall
 	la $a0, p
    lw $t0,0($a0)
    
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
