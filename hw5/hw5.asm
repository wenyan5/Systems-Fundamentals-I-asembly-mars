############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################
.text:

create_term:
	move $t0,$a0	# coeff
	move $t1,$a1	# exp

	li $a0, 12
	li $v0, 9
	syscall

	beq $t0,$0,create_term_x
	blt $t1,$0,create_term_x

	sw $t0,0($v0)
	sw $t1,4($v0)
	sw $0,8($v0)

	jr $ra

	create_term_x:
		li $v0,-1
		jr $ra


init_polynomial:
	addi $sp, $sp, -12
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $ra, 8($sp)
	move $s0,$a0	# p
	move $s1,$a1	# pair

	lw $t2,0($s1)
	lw $t3,4($s1)

	move $a0,$t2
	move $a1,$t3
	jal create_term
	li $t0,-1
	beq $v0,$t0,init_polynomial_endx
	sw $v0,0($s0)
	li $v0,1
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $ra, 8($sp)
	addi $sp, $sp, 12
	jr $ra

	init_polynomial_endx:
		li $v0,-1
		lw $s0, 0($sp)
		lw $s1, 4($sp)
		lw $ra, 8($sp)
		addi $sp, $sp, 12
		jr $ra


add_N_terms_to_polynomial:
	addi $sp, $sp, -24
	sw $s0, 0($sp)		#p
	sw $s1, 4($sp)		#terms
	sw $s2, 8($sp)		# N
	sw $s3, 12($sp) 	# total add
	sw $s4, 16($sp) 	# pointer
	sw $ra, 20($sp)
	li $s3,0	#add total pair

	move $s0,$a0
	move $s1,$a1
	move $s2,$a2

	ble $s2,$0,add_N_terms_to_polynomial_end_Nx

	lw $t0,0($s0)
	beq $t0,$0,add_N_terms_headnull
	j not_add_N_terms_headnull

	add_N_terms_headnull:

		li $t2,-1
		li $t8,-2
		move $t5,$s1			#delete 0 coe
		add_N_terms_to_polynomial_pexpcheck_head:
			lw $t3,0($t5)
			lw $t4,4($t5)
			addi $t5,$t5,8

			beq $t3,$0,add_N_terms_thent3_head
			j not_add_N_terms_thent3_head
			add_N_terms_thent3_head:
				beq $t4,$t2,add_N_terms_to_polynomial_pexpcheck_end_head
				addi $t5,$t5,-8
				j add_N_terms_duplicate_head
			not_add_N_terms_thent3_head:
				j add_N_terms_to_polynomial_pexpcheck_head

			add_N_terms_duplicate_head:
				sw $t8,0($t5)
				sw $t8,4($t5)
				addi $t5,$t5,8
				j add_N_terms_to_polynomial_pexpcheck_head

		add_N_terms_to_polynomial_pexpcheck_end_head:

		move $t5,$s1
		lw $t6,4($t5) 	#max
		li $t7,0
		add_N_terms_while_max_head:
			lw $t3,0($t5)
			lw $t4,4($t5)
			addi $t5,$t5,8
			beq $t3,$0,add_N_terms_thent3_1_head
			j not_add_N_terms_thent3_1_head
			add_N_terms_thent3_1_head:
				beq $t4,$t2,add_N_terms_while_max_end_head
			not_add_N_terms_thent3_1_head:

			lw $t7,4($t5)
			beq $t7,$t2,not_add_N_terms_duplicate1_head
			beq $t7,$t6,add_N_terms_duplicate1_head
			j not_add_N_terms_duplicate1_head

			add_N_terms_duplicate1_head:
				sw $t8,0($t5)
				sw $t8,4($t5)
				j add_N_terms_while_max_head

			not_add_N_terms_duplicate1_head:
				bgt $t7,$t6,add_N_terms_changemax_head
				j add_N_terms_while_max_head

				add_N_terms_changemax_head:
					move $t6,$t7
					j add_N_terms_while_max_head

		add_N_terms_while_max_end_head:

		add_N_terms_createhead:
			blt $t6,$0,add_N_terms_to_polynomial_end
			move $t5,$s1
			add_N_terms_while_create_head:
				lw $t3,0($t5)
				lw $t4,4($t5)
				beq $t4,$t6,add_N_terms_while_create_end_head
				addi $t5,$t5,8
				j add_N_terms_while_create_head

			add_N_terms_while_create_end_head:
				sw $t8,0($t5)
				sw $t8,4($t5)

				move $a0,$t3
				move $a1,$t4
				jal create_term
				sw $v0,0($s0)


	not_add_N_terms_headnull:

	lw $t2,0($s0)
	lw $t0,0($t2)
	lw $t1,4($t2)
	li $t2,-1
	li $t8,-2
	li $t3,0
	li $t4,0

	move $t5,$s1			#delete 0 coe
	add_N_terms_to_polynomial_pexpcheck:
		lw $t3,0($t5)
		lw $t4,4($t5)
		addi $t5,$t5,8

		beq $t3,$0,add_N_terms_thent3
		j not_add_N_terms_thent3
		add_N_terms_thent3:
			beq $t4,$t2,add_N_terms_to_polynomial_pexpcheck_end
			addi $t5,$t5,-8
			j add_N_terms_duplicate
		not_add_N_terms_thent3:
			j add_N_terms_to_polynomial_pexpcheck

		add_N_terms_duplicate:
			sw $t8,0($t5)
			sw $t8,4($t5)
			addi $t5,$t5,8
			j add_N_terms_to_polynomial_pexpcheck

	add_N_terms_to_polynomial_pexpcheck_end:

	add_N_terms_loopn:
		beq $s2,$0,add_N_terms_to_polynomial_end

		move $t5,$s1
		lw $t6,4($t5) 	#max
		li $t7,0
		add_N_terms_while_max:
			lw $t3,0($t5)
			lw $t4,4($t5)
			addi $t5,$t5,8
			beq $t3,$0,add_N_terms_thent3_1
			j not_add_N_terms_thent3_1
			add_N_terms_thent3_1:
				beq $t4,$t2,add_N_terms_while_max_end
			not_add_N_terms_thent3_1:

			lw $t7,4($t5)
			beq $t7,$t2,not_add_N_terms_duplicate1
			beq $t7,$t6,add_N_terms_duplicate1
			j not_add_N_terms_duplicate1

			add_N_terms_duplicate1:
				sw $t8,0($t5)
				sw $t8,4($t5)
				j add_N_terms_while_max

			not_add_N_terms_duplicate1:
				bgt $t7,$t6,add_N_terms_changemax
				j add_N_terms_while_max

				add_N_terms_changemax:
					move $t6,$t7
					j add_N_terms_while_max

		add_N_terms_while_max_end:
			blt $t6,$0,add_N_terms_to_polynomial_end
			move $t5,$s1
			add_N_terms_while_create:
				lw $t3,0($t5)
				lw $t4,4($t5)
				beq $t4,$t6,add_N_terms_while_create_end
				addi $t5,$t5,8
				j add_N_terms_while_create

			add_N_terms_while_create_end:
				sw $t8,0($t5)
				sw $t8,4($t5)

				addi $sp,$sp,-16
				sw $t2, 0($sp)
				sw $t5, 4($sp)
				sw $t6, 8($sp)
				sw $t8, 12($sp)

				move $a0,$t3
				move $a1,$t4
				jal create_term

				lw $t2, 0($sp)
				lw $t5, 4($sp)
				lw $t6, 8($sp)
				lw $t8, 12($sp)
				addi $sp,$sp,16
			
				beq $s3,$0,add_N_terms_phead
				j not_add_N_terms_phead_term
				add_N_terms_phead:
					sw $v0,0($s0)
					move $s4,$v0
					addi $s3,$s3,1
					addi $s2,$s2,-1
					j add_N_terms_loopn
				not_add_N_terms_phead_term:
					addi $s3,$s3,1
					addi $s2,$s2,-1
					sw $v0,8($s4)
					move $s4,$v0
					j add_N_terms_loopn


		add_N_terms_to_polynomial_end:
			move $v0,$s3
			j add_N_terms_to_polynomial_f

		add_N_terms_to_polynomial_end_Nx:
			li $v0, 0
			j add_N_terms_to_polynomial_f

		add_N_terms_to_polynomial_f:
			lw $s0, 0($sp)
			lw $s1, 4($sp)
			lw $s2, 8($sp)
			lw $s3, 12($sp)
			lw $s4, 16($sp)
			lw $ra, 20($sp)
			addi $sp, $sp, 24
			jr $ra


update_N_terms_in_polynomial:
	addi $sp, $sp, -24
	sw $s0, 0($sp)		#p
	sw $s1, 4($sp)		#terms
	sw $s2, 8($sp)		# N
	sw $s3, 12($sp) 	# total add
	sw $s4, 16($sp) 	# pointer
	sw $ra, 20($sp)

	move $s0,$a0
	move $s1,$a1
	move $s2,$a2

	ble $s2,$0,update_N_terms_end_Nx
	li $s3,0
	li $t7,-1
	li $t8,-2
	lw $t2,0($s0)
	lw $t9,4($t2)

	update_N_terms_loop:
		beq $s2,$0,update_N_terms_loop_end
		#lw $t2,0($s0)
		lw $t0,0($t2)
		lw $t1,4($t2)
		lw $s4,8($t2)
		li $t6,0	# update times

		move $t5,$s1
		update_N_terms_findexist:
			beq $s2,$0,update_N_terms_loop_end
			lw $t3,0($t5)
			lw $t4,4($t5)
			beq $t3,$0,update_N_terms_thent3_1
			j not_update_N_terms_thent3_1
			update_N_terms_thent3_1:
				beq $t4,$t7,update_N_terms_findexist_end
			not_update_N_terms_thent3_1:

				beq $t4,$t1,check_coeffnot0
				j not_check_coeffnot0
				check_coeffnot0:
					beq $t3,$0,discardthisterm
					
					sw $t3,0($t2)
					sw $t4,4($t2)
					addi $t5,$t5,8
					addi $t6,$t6,1
					addi $s2,$s2,-1
					beq $s2,$0,update_N_terms_loop_endplus1
					j update_N_terms_findexist

				not_check_coeffnot0:
					addi $t5,$t5,8
					j update_N_terms_findexist

				discardthisterm:
					sw $t8,0($t5)
					sw $t8,4($t5)
					addi $t5,$t5,8
					j update_N_terms_findexist

		update_N_terms_findexist_end:
			bgt $t6,$0,update_N_terms_addN
			#beq $s2,$0,update_N_terms_loop_end
			move $t2,$s4
			beq $s4,$0,update_N_terms_loop_end
			j update_N_terms_loop
			update_N_terms_addN:
				addi $s3,$s3,1
				#addi $s2,$s2,-1
				move $t2,$s4
				beq $s4,$0,update_N_terms_loop_end
				j update_N_terms_loop

	update_N_terms_loop_end:
		#beq $t4,$t9,update_N_terms_loop_endplus1
		move $v0,$s3
		j update_N_terms_in_polynomial_f

		update_N_terms_loop_endplus1:
			addi $s3,$s3,1
			move $v0,$s3
			j update_N_terms_in_polynomial_f

	update_N_terms_end_Nx:
		li $v0, 0
		j update_N_terms_in_polynomial_f

	update_N_terms_in_polynomial_f:
		lw $s0, 0($sp)
		lw $s1, 4($sp)
		lw $s2, 8($sp)
		lw $s3, 12($sp)
		lw $s4, 16($sp)
		lw $ra, 20($sp)
		addi $sp, $sp, 24
		jr $ra




get_Nth_term:
	ble $a1,$0,get_Nth_term_x

	lw $t0,0($a0)
	move $t1,$t0
	get_Nth_term_loop:
		move $t0,$t1
		addi $a1,$a1,-1
		beq $a1,$0,get_Nth_term_loop_end
		lw $t1,8($t0)
		beq $t1,$0,get_Nth_term_x
		j get_Nth_term_loop

	get_Nth_term_loop_end:
		lw $v0,4($t1)
		lw $v1,0($t1)
		jr $ra

	get_Nth_term_x:
		li $v0,-1
		li $v1,0
		jr $ra


remove_Nth_term:
	ble $a1,$0,remove_Nth_term_x

	lw $t0,0($a0)

	li $t9,1
	beq $a1,$t9,remove_Nth_term_1st
	lw $t8,8($t0)
	beq $t8,$0,remove_Nth_term_x
	j not_remove_Nth_term_1st

	remove_Nth_term_1st:
		lw $t2,8($t0)
		beq $t2,$0,remove_Nth_term_only1st
		sw $t2,0($a0)
		lw $v0,4($t0)
		lw $v1,0($t0)
		jr $ra

		remove_Nth_term_only1st:
			lw $0,0($a0)
			lw $v0,4($t0)
			lw $v1,0($t0)
			jr $ra

	not_remove_Nth_term_1st:
		move $t2,$t0	#t0 ,1st   / $t2,the 2nd
		addi $a1,$a1,-1
		li $t3,0

		remove_Nth_term_loop:
			move $t0,$t2
			lw $t2,8($t0)
			addi $a1,$a1,-1
			beq $a1,$0,remove_Nth_term_loop_end
			beq $t2,$0,remove_Nth_term_x
			lw $t3,8($t2)
			j remove_Nth_term_loop


	remove_Nth_term_loop_end:
		lw $t3,8($t2)
		sw $t3,8($t0)
		lw $v0,4($t2)
		lw $v1,0($t2)
		jr $ra

	remove_Nth_term_x:
		li $v0,-1
		li $v1,0
		jr $ra

add_poly:
	addi $sp, $sp, -24
	sw $s0, 0($sp)		# p
	sw $s1, 4($sp)		# q
	sw $s2, 8($sp)		# r
	sw $s3, 12($sp) 	# the length of r
	sw $s4, 16($sp) 	# v0 address
	sw $ra, 20($sp)

	move $s0,$a0
	move $s1,$a1
	move $s2,$a2
	sw $0,0($s2)

	lw $t1,0($s0)
	beq $t1,$0,add_poly_checkq
	lw $t1,0($s1)
	beq $t1,$0,add_poly_checkp
	j not_add_poly_checkonenull

	add_poly_checkq:
		lw $t1,0($s1)
		beq $t1,$0,add_poly_x

		li $t1,1
		li $a0, 8
		li $v0, 9
		syscall
		sw $t1,0($v0)
		sw $t1,4($v0)

		move $a0,$s2
		move $a1,$v0
		jal init_polynomial

		li $t9,0
		lw $t0,0($s1)		
		add_poly_qlength:
			lw $t1,8($t0)
			beq $t1,$0,add_poly_qlength_end
			addi $t9,$t9,1
			move $t0,$t1
			j add_poly_qlength
			
			add_poly_qlength_end:
				addi $t9,$t9,1
				li $t2,8
				mult $t9,$t2
				mflo $a0
				addi $a0,$a0,8
				li $v0,9
				syscall
				move $s4,$v0

				lw $t0,0($s1)
				add_poly_qcopy:
					beq $t0,$0,add_poly_qcopy_end
					lw $t2,0($t0)
					lw $t3,4($t0)
					sw $t2,0($v0)
					sw $t3,4($v0)
					addi $v0,$v0,8
					lw $t4,8($t0)
					move $t0,$t4
					j add_poly_qcopy

				add_poly_qcopy_end:
					li $t5,-1
					sw $0,0($v0)
					sw $t5,4($v0)

					move $a0,$s2
					move $a1,$s4
					move $a2,$t9
					jal add_N_terms_to_polynomial
					li $v0,1
					j add_poly_end_f


	add_poly_checkp:
		lw $t1,0($s0)
		beq $t1,$0,add_poly_x

		li $t1,1
		li $a0, 8
		li $v0, 9
		syscall
		sw $t1,0($v0)
		sw $t1,4($v0)

		move $a0,$s2
		move $a1,$v0
		jal init_polynomial

		li $t9,0
		lw $t0,0($s0)		
		add_poly_plength:
			lw $t1,8($t0)
			beq $t1,$0,add_poly_plength_end
			addi $t9,$t9,1
			move $t0,$t1
			j add_poly_plength
			
			add_poly_plength_end:
				addi $t9,$t9,1
				li $t2,8
				mult $t9,$t2
				mflo $a0
				addi $a0,$a0,8
				li $v0,9
				syscall
				move $s4,$v0

				lw $t0,0($s0)
				add_poly_pcopy:
					beq $t0,$0,add_poly_pcopy_end
					lw $t2,0($t0)
					lw $t3,4($t0)
					sw $t2,0($v0)
					sw $t3,4($v0)
					addi $v0,$v0,8
					lw $t4,8($t0)
					move $t0,$t4
					j add_poly_pcopy

				add_poly_pcopy_end:	
					li $t5,-1
					sw $0,0($v0)
					sw $t5,4($v0)
					move $a0,$s2
					move $a1,$s4
					move $a2,$t9
					jal add_N_terms_to_polynomial
					li $v0,1
					j add_poly_end_f

	not_add_poly_checkonenull:

		li $t1,1
		li $a0, 8
		li $v0, 9
		syscall
		sw $t1,0($v0)
		sw $t1,4($v0)

		move $a0,$s2
		move $a1,$v0
		jal init_polynomial

		li $t7,0		# add term num
		li $t9,0
		lw $t0,0($s0)		
		add_poly_plength_1:
			lw $t1,8($t0)
			beq $t1,$0,add_poly_plength_end_1
			addi $t9,$t9,1
			move $t0,$t1
			j add_poly_plength_1
			
			add_poly_plength_end_1:
				addi $t9,$t9,1
		
		li $t8,0
		lw $t0,0($s1)		
		add_poly_qlength_1:
			lw $t1,8($t0)
			beq $t1,$0,add_poly_qlength_end_1
			addi $t8,$t8,1
			move $t0,$t1
			j add_poly_qlength_1
			
			add_poly_qlength_end_1:
				addi $t8,$t8,1
		
		#bge $t9,$t8,add_poly_values3to9
		#move $s3,$t8
		#j not_add_poly_values3to9

		#add_poly_values3to9:
		#	move $s3,$t9
		add $s3,$t9,$t8

		not_add_poly_values3to9:
			li $t2,8
			mult $s3,$t2
			mflo $a0
			addi $a0,$a0,8
			li $v0,9
			syscall
			move $s4,$v0

			lw $t0,0($s0)
			lw $t1,0($s1)
			lw $t2,4($t0)
			lw $t3,4($t1)
			bge $t2,$t3,add_poly_startp
			j add_poly_startq
			add_poly_startp:
				lw $t0,0($s0)
				lw $t1,0($s1)
				j add_poly_startyes

			add_poly_startq:
				lw $t0,0($s1)
				lw $t1,0($s0)

			add_poly_startyes:
				move $t5,$t0
				move $t6,$t1
			add_poly_loop:
				move $t0,$t5
				move $t1,$t6
				beq $t0,$0,add_poly_loop_end
				beq $t1,$0,add_poly_loop_end
				lw $t2,4($t0)
				lw $t3,4($t1)
				beq $t2,$t3,addcoeffiecnt
				bgt $t2,$t3,coeffiecnt_higherp
				blt $t2,$t3,coeffiecnt_higherq
				lw $t4,0($t1)
				sw $t4,0($v0)
				sw $t3,4($v0)
				addi $v0,$v0,8
				addi $t7,$t7,1
				j add_poly_loop

				coeffiecnt_higherp:
					lw $t4,0($t0)
					sw $t4,0($v0)
					sw $t2,4($v0)
					addi $v0,$v0,8
					addi $t7,$t7,1
					lw $t5,8($t0)
					j add_poly_loop

				coeffiecnt_higherq:
					lw $t4,0($t1)
					sw $t4,0($v0)
					sw $t3,4($v0)
					addi $v0,$v0,8
					addi $t7,$t7,1
					lw $t6,8($t1)
					j add_poly_loop

				addcoeffiecnt:
					lw $t4,0($t0)
					lw $t8,0($t1)
					add $t4,$t4,$t8
					lw $t5,8($t0)
					lw $t6,8($t1)
					bne $t4,$0, addcoeffiecnt_tor
					j add_poly_loop

					addcoeffiecnt_tor:
						sw $t4,0($v0)
						sw $t2,4($v0)
						addi $v0,$v0,8
						addi $t7,$t7,1
						j add_poly_loop


			add_poly_loop_end:
				beq $t0,$0,add_poly_q_contin
				beq $t1,$0,add_poly_p_contin

				add_poly_q_contin:
					beq $t1,$0,add_poly_end
					lw $t2,0($t1)
					lw $t3,4($t1)
					lw $t4,8($t1)
					sw $t2,0($v0)
					sw $t3,4($v0)
					addi $v0,$v0,8
					addi $t7,$t7,1
					move $t1,$t4
					j add_poly_q_contin

				add_poly_p_contin:
					beq $t0,$0,add_poly_end
					lw $t2,0($t0)
					lw $t3,4($t0)
					lw $t4,8($t0)
					sw $t2,0($v0)
					sw $t3,4($v0)
					addi $v0,$v0,8
					addi $t7,$t7,1
					move $t0,$t4
					j add_poly_p_contin
					

	add_poly_end:
		#move $s3,$t7
		beq $t7,$0,add_poly_x
		li $t5,-1
		sw $0,0($v0)
		sw $t5,4($v0)
		move $a0,$s2
		move $a1,$s4
		move $a2,$s3
		jal add_N_terms_to_polynomial
		li $v0,1
		j add_poly_end_f

	add_poly_x:
		sw $0,0($s2)
		li $v0,0
		j add_poly_end_f

	add_poly_end_f:
		lw $s0, 0($sp)
		lw $s1, 4($sp)
		lw $s2, 8($sp)
		lw $s3, 12($sp)
		lw $s4, 16($sp)
		lw $ra, 20($sp)
		addi $sp, $sp, 24
		jr $ra


mult_poly:
	addi $sp, $sp, -32
	sw $s0, 0($sp)		# p
	sw $s1, 4($sp)		# q
	sw $s2, 8($sp)		# r
	sw $s3, 12($sp) 	# the length of r
	sw $s4, 16($sp) 	# v0 address
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $ra, 28($sp)

	move $s0,$a0
	move $s1,$a1
	move $s2,$a2
	li $s5,0
	li $s6,0

	lw $t1,0($s0)
	beq $t1,$0,mult_poly_checkq
	lw $t1,0($s1)
	beq $t1,$0,mult_poly_checkp
	j not_mult_poly_checkonenull

	mult_poly_checkq:
		lw $t1,0($s1)
		beq $t1,$0,mult_poly_x

		li $t1,1
		li $a0, 8
		li $v0, 9
		syscall
		sw $t1,0($v0)
		sw $t1,4($v0)

		move $a0,$s2
		move $a1,$v0
		jal init_polynomial

		li $t9,0
		lw $t0,0($s1)		
		mult_poly_qlength:
			lw $t1,8($t0)
			beq $t1,$0,mult_poly_qlength_end
			addi $t9,$t9,1
			move $t0,$t1
			j mult_poly_qlength
			
			mult_poly_qlength_end:
				addi $t9,$t9,1
				li $t2,8
				mult $t9,$t2
				mflo $a0
				addi $a0,$a0,8
				li $v0,9
				syscall
				move $s4,$v0

				lw $t0,0($s1)
				mult_poly_qcopy:
					beq $t0,$0,mult_poly_qcopy_end
					lw $t2,0($t0)
					lw $t3,4($t0)
					sw $t2,0($v0)
					sw $t3,4($v0)
					addi $v0,$v0,8
					lw $t4,8($t0)
					move $t0,$t4
					j mult_poly_qcopy

				mult_poly_qcopy_end:
					li $t5,-1
					sw $0,0($v0)
					sw $t5,4($v0)

					move $a0,$s2
					move $a1,$s4
					move $a2,$t9
					jal add_N_terms_to_polynomial
					li $v0,1
					j mult_poly_end_f


	mult_poly_checkp:
		lw $t1,0($s0)
		beq $t1,$0,mult_poly_x

		li $t1,1
		li $a0, 8
		li $v0, 9
		syscall
		sw $t1,0($v0)
		sw $t1,4($v0)

		move $a0,$s2
		move $a1,$v0
		jal init_polynomial

		li $t9,0
		lw $t0,0($s0)		
		mult_poly_plength:
			lw $t1,8($t0)
			beq $t1,$0,mult_poly_plength_end
			addi $t9,$t9,1
			move $t0,$t1
			j mult_poly_plength
			
			mult_poly_plength_end:
				addi $t9,$t9,1
				li $t2,8
				mult $t9,$t2
				mflo $a0
				addi $a0,$a0,8
				li $v0,9
				syscall
				move $s4,$v0

				lw $t0,0($s0)
				mult_poly_pcopy:
					beq $t0,$0,mult_poly_pcopy_end
					lw $t2,0($t0)
					lw $t3,4($t0)
					sw $t2,0($v0)
					sw $t3,4($v0)
					addi $v0,$v0,8
					lw $t4,8($t0)
					move $t0,$t4
					j mult_poly_pcopy

				mult_poly_pcopy_end:	
					li $t5,-1
					sw $0,0($v0)
					sw $t5,4($v0)
					move $a0,$s2
					move $a1,$s4
					move $a2,$t9
					jal add_N_terms_to_polynomial
					li $v0,1
					j mult_poly_end_f

	not_mult_poly_checkonenull:

		lw $t1,0($s2)
		beq $t1,$0,create_new_r
		lw $s5,0($t1)		# r head cor
		lw $s6,4($t1)		# r head exp
		j not_create_new_r
		
		create_new_r:
			li $t1,1
			li $a0, 8
			li $v0, 9
			syscall
			sw $t1,0($v0)
			sw $t0,4($v0)

			move $a0,$s2
			move $a1,$v0
			jal init_polynomial

		not_create_new_r:

		li $t9,0
		lw $t0,0($s0)		
		mult_poly_plength_1:
			lw $t1,8($t0)
			beq $t1,$0,mult_poly_plength_end_1
			addi $t9,$t9,1
			move $t0,$t1
			j mult_poly_plength_1
			
			mult_poly_plength_end_1:
				addi $t9,$t9,1
		
		li $t8,0
		lw $t0,0($s1)		
		mult_poly_qlength_1:
			lw $t1,8($t0)
			beq $t1,$0,mult_poly_qlength_end_1
			addi $t8,$t8,1
			move $t0,$t1
			j mult_poly_qlength_1
			
			mult_poly_qlength_end_1:
				addi $t8,$t8,1

		add $s3,$t9,$t8
		li $t2,8
		mult $s3,$t2
		mflo $a0
		addi $a0,$a0,8
		li $v0,9
		syscall
		move $s4,$v0

		lw $t0,0($s0)
		li $t9,-1
		mult_poly_ploop:
			beq $t9,$0,mult_poly_ploop_end
			lw $t1,0($t0)
			lw $t2,4($t0)

			lw $t3,0($s1)
			li $t9,-1
			mult_poly_qloop:
				beq $t9,$0,mult_poly_qloop_end
				lw $t4,0($t3)
				lw $t5,4($t3)
				lw $t9,8($t3)
				move $t3,$t9
				mult $t1,$t4
				mflo $t4
				add $t5,$t5,$t2

				move $t6,$s4
				mult_poly_rloop:
					lw $t7,0($t6)
					bne $t7,$0,mult_poly_rloop_contin
					sw $t4,0($t6)
					sw $t5,4($t6)
					j mult_poly_qloop
					
					mult_poly_rloop_contin:
						lw $t8,4($t6)
						beq $t5,$t8,mult_poly_findrterm
						addi $t6,$t6,8
						j mult_poly_rloop

						mult_poly_findrterm:
							add $t7,$t7,$t4
							sw $t7,0($t6)
							j mult_poly_qloop


			mult_poly_qloop_end:
				lw $t9,8($t0)
				move $t0,$t9
				j mult_poly_ploop

		mult_poly_ploop_end:
			beq $s5,$0,mult_poly_rlist
			move $t0,$s4
			mult_poly_rloop2:
					lw $t1,0($t0)
					lw $t2,4($t0)
					beq $t2,$s6,mult_poly_addheadrexp
					addi $t0,$t0,8
					j mult_poly_rloop2

					mult_poly_addheadrexp:
						add $t1,$t1,$s5
						sw $t1,0($t0)

			mult_poly_rlist:
				move $t0,$s4
				mult_poly_rloop1:
					lw $t1,0($t0)
					bne $t1,$0,mult_poly_rloop1_contin
					li $t2,-1
					sw $0,0($t0)
					sw $t2,4($t0)
					j mult_poly_rloop1_end

					mult_poly_rloop1_contin:
						addi $t0,$t0,8
						j mult_poly_rloop1

			mult_poly_rloop1_end:
				move $a0,$s2
				move $a1,$s4
				move $a3,$s3
				jal add_N_terms_to_polynomial
				li $v0,1
				j mult_poly_end_f

	mult_poly_x:
		sw $0,0($s2)
		li $v0,0
		j mult_poly_end_f

	mult_poly_end_f:
		lw $s0, 0($sp)
		lw $s1, 4($sp)
		lw $s2, 8($sp)
		lw $s3, 12($sp)
		lw $s4, 16($sp)
		lw $s5, 20($sp)
		lw $s6, 24($sp)
		lw $ra, 28($sp)
		addi $sp, $sp, 32
		jr $ra
