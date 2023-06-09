############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################
.text:

str_len:
	li $t0,0

	str_lenloop:
		lb $t1,0($a0)
		beqz $t1,str_lenloop_end
		addi $a0,$a0,1
		addi $t0,$t0,1
		j str_lenloop

	str_lenloop_end:
		move $v0,$t0
		jr $ra


str_equals:
	addi $sp, $sp, -16
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $ra, 12($sp)
	move $s0,$a0
	move $s1,$a1

	move $a0,$s0
	jal str_len
	move $s2,$v0

	move $a0,$a1
	jal str_len
	move $t2,$v0

	bne $s2,$t2,str_equals_x

	str_equals_loop:
		lb $s2,0($s0)
		lb $t2,0($s1)
		bne $s2,$t2,str_equals_x
		beqz $s2,str_equals_loop_end
		addi $s0,$s0,1
		addi $s1,$s1,1
		j str_equals_loop

	str_equals_loop_end:
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $ra, 12($sp)
	addi $sp, $sp, 16
	li $v0,1
	jr $ra

	str_equals_x:
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $ra, 12($sp)
	addi $sp, $sp, 16
	li $v0,0
	jr $ra


str_cpy:
	li $t0,0
	str_cpy_loop:
		lb $t1,0($a0)
		sb $t1,0($a1)
		beqz $t1,str_cpy_loop_end
		addi $a0,$a0,1
		addi $a1,$a1,1
		addi $t0,$t0,1
		j str_cpy_loop

	str_cpy_loop_end:
	move $v0,$t0
	jr $ra


create_person:
	move $a1,$a0
	lw $t0,0($a0)						# $t0 the total node 
	addi $a0,$a0,8
	lw $t2,0($a0)   					# t2, the node size
	addi $a0,$a0,8
	lw $t1,0($a0)						# $t1 the current node num
	bge $t1,$t0,create_person_full
	move $t4,$t1
	addi $t4,$t4,1
	sw $t4,0($a0)
	addi $a0,$a0,20
	mult $t2,$t1
	mflo $t3
	add $a0,$a0,$t3
	move $v0,$a0
	jr $ra

	create_person_full:
		li $v0,-1
		jr $ra


is_person_exists:
	#move $a2,$a1
	addi $a0,$a0,8
	lw $t0,0($a0)     # t0, node size
	addi $a0,$a0,8
	lw $t1,0($a0)     # t1, current node num
	addi $a0,$a0,20

	is_person_exists_loop:
		beqz $t1,is_person_exists_end
		beq $a0,$a1,is_person_exists_true
		add $a0,$a0,$t0
		addi $t1,$t1,-1
		j is_person_exists_loop

	is_person_exists_true:
		li $v0,1
		jr $ra

	is_person_exists_end:
		li $v0,0
		jr $ra


is_person_name_exists:
	move $a3,$a0
	move $a2,$a1
	addi $a0,$a0,8
	lw $t0,0($a0)     # t0, node size
	addi $a0,$a0,8
	lw $t1,0($a0)     # t1, current node num
	addi $a0,$a0,20
	li $t5,-1 			#the index of name
	move $t6,$a0

	is_person_name_exists_loop:
		beqz $t1, is_person_name_exists_end
		addi $t1,$t1,-1
		move $a1,$a2
		addi $t5,$t5,1
		move $a0,$t6
		mult $t0, $t5
		mflo $t7
		add $a0,$a0,$t7

		is_person_name_exists_ele:
			lb $t2,0($a0)
			lb $t3,0($a1)

			addi $a0,$a0,1
			addi $a1,$a1,1
			bne $t2,$t3,is_person_name_exists_loop
			beqz $t3,is_person_name_exists_true
			j is_person_name_exists_ele

	is_person_name_exists_true:
		li $v0,1
		addi $a3,$a3,36
		mult $t5,$t0
		mflo $t6
		add $a3,$a3,$t6
		move $v1,$a3
		jr $ra

	is_person_name_exists_end:
		li $v0,0
		jr $ra


add_person_property:
	addi $sp, $sp, -20
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $ra, 16($sp)
	move $s0,$a0
	move $s1,$a1
	move $s2,$a2
	move $s3,$a3

	addi $a0,$a0,24
	move $a1,$s2
	jal str_equals
	beq $v0,$0,add_person_property_vio1

	move $a0,$s0
	move $a1,$s1
	jal is_person_exists
	beq $v0,$0,add_person_property_vio2

	move $a0,$s3
	jal str_len
	move $t0,$v0
	move $a0,$s0
	addi $a0,$a0,8
	lw $t1,0($a0)
	bge $t0,$t1,add_person_property_vio3

	move $a0,$s0
	move $a1,$s3
	jal is_person_name_exists
	bne $v0,$0,add_person_property_vio4

	move $a0,$s1
	move $a1,$s3
	add_person_property_loop:
		lb $t2,0($a1)
		sb $t2,0($a0)
		addi $a0,$a0,1
		addi $a1,$a1,1
		beqz $t2,add_person_property_loopend
		j add_person_property_loop

	add_person_property_loopend:
		li $v0,1
		j add_person_property_end

	add_person_property_vio1:
		li $v0,0
		j add_person_property_end

	add_person_property_vio2:
		li $v0,-1
		j add_person_property_end

	add_person_property_vio3:
		li $v0,-2
		j add_person_property_end

	add_person_property_vio4:
		li $v0,-3
		j add_person_property_end

	add_person_property_end:
		lw $s0, 0($sp)
		lw $s1, 4($sp)
		lw $s2, 8($sp)
		lw $s3, 12($sp)
		lw $ra, 16($sp)
		addi $sp, $sp, 20
		jr $ra


get_person:
	move $t9,$a0
	move $t8,$a1
	addi $a0,$a0,8
	lw $t0,0($a0)     # t0, node size
	addi $a0,$a0,8
	lw $t1,0($a0)     # t1, current node num
	addi $a0,$a0,20
	li $t5,-1 			#the index of name
	move $t6,$a0

	get_person_loop:
		beqz $t1, get_person_end
		addi $t1,$t1,-1
		move $a1,$t8
		addi $t5,$t5,1
		move $a0,$t6
		mult $t0, $t5
		mflo $t7
		add $a0,$a0,$t7

		get_person_ele:
			lb $t2,0($a0)
			lb $t3,0($a1)
			addi $a0,$a0,1
			addi $a1,$a1,1
			bne $t2,$t3,get_person_loop
			beqz $t3,get_person_true
			j get_person_ele

	get_person_true:
		addi $t9,$t9,36
		mult $t5,$t0
		mflo $t6
		add $t9,$t9,$t6
		move $v0,$t9
		jr $ra

	get_person_end:
		li $v0,0
		jr $ra



is_relation_exists:
	#move $t7,$a0
	#move $t9,$a1
	#move $t8,$a2
	
	lw $t3,0($a0)	# t3, the total node num
	addi $a0,$a0,8
	lw $t0,0($a0)	# t0, node size
	addi $a0,$a0,4
	lw $t1,0($a0)  	# t1, the edge size  = 12
	addi $a0,$a0,8
	lw $t2,0($a0)	#t6, current edge num

	addi $a0,$a0,16
	mult $t3,$t0
	mflo $t4
	add $a0,$a0,$t4

	li $t5,0
	is_relation_exists_loop:
		beq $t5,$t2,is_relation_exists_x
		lw $t6,0($a0)
		beq $t6,$a1,is_relation_exists_contina2
		beq $t6,$a2,is_relation_exists_contina1
		addi $a0,$a0,12
		addi $t5,$t5,1
		j is_relation_exists_loop

		is_relation_exists_contina2:
			lw $t6,4($a0)
			beq $t6,$a2,is_relation_exists_true
			addi $a0,$a0,12
			addi $t5,$t5,1
			j is_relation_exists_loop
		is_relation_exists_contina1:
			lw $t6,4($a0)
			beq $t6,$a1,is_relation_exists_true
			addi $a0,$a0,12
			addi $t5,$t5,1
			j is_relation_exists_loop


	is_relation_exists_x:
		li $v0,0
		jr $ra
	is_relation_exists_true:
		li $v0,1
		jr $ra


add_relation:
	addi $sp, $sp, -16
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $ra, 12($sp)
	move $s0,$a0
	move $s1,$a1
	move $s2,$a2

	move $a0,$s0
	move $a1,$s1
	jal is_person_exists
	beq $v0,$0,add_relation_vio1

	move $a0,$s0
	move $a1,$s2
	jal is_person_exists
	beq $v0,$0,add_relation_vio1

	move $a0,$s0
	lw $t0,4($a0)
	lw $t1,20($a0)
	bge $t1,$t0,add_relation_vio2

	move $a0,$s0
	move $a1,$s1
	move $a2,$s2
	jal is_relation_exists
	bne $v0,$0,add_relation_vio3

	beq $s1,$s2,add_relation_vio4

	move $a0,$s0
	lw $t0,0($a0)
	lw $t1,8($a0)
	mult $t0,$t1
	mflo $t2
	lw $t4,12($a0)
	lw $t3,20($a0)
	addi $a0,$a0,36
	add $a0,$a0,$t2
	mult $t4,$t3
	mflo $t2
	add $a0,$a0,$t2
	sw $s1,0($a0)
	sw $s2,4($a0)

	move $a0,$s0
	lw $t5,20($a0)
	addi $t5,$t5,1
	sw $t5,20($a0)
	
	li $v0,1
	j add_relation_end

	add_relation_vio1:
		li $v0,0
		j add_relation_end
	add_relation_vio2:
		li $v0,-1
		j add_relation_end
	add_relation_vio3:
		li $v0,-2
		j add_relation_end
	add_relation_vio4:
		li $v0,-3
		j add_relation_end

	add_relation_end:
		lw $s0, 0($sp)
		lw $s1, 4($sp)
		lw $s2, 8($sp)
		lw $ra, 12($sp)
		addi $sp, $sp, 16
		jr $ra


add_relation_property:
	move $fp,$sp
	addi $sp, $sp, -20
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $ra, 16($sp)
	move $s0,$a0
	move $s1,$a1
	move $s2,$a2
	move $s3,$a3

	jal is_relation_exists
	beq $v0,$0,add_relation_property_vio1

	move $a0,$s0
	addi $a0,$a0,29
	move $a1,$s3
	jal str_equals
	beq $v0,$0,add_relation_property_vio2

	lw $t6,0($fp)
	blt $t6,$0,add_relation_property_vio3

	move $a0,$s0
	lw $t3,0($a0)	# t3, the total node num
	lw $t0,8($a0)	# t0, node size
	lw $t1,12($a0)  	# t1, the edge size  = 12
	lw $t2,20($a0)	#t6, current edge num

	addi $a0,$a0,36
	mult $t3,$t0
	mflo $t4
	add $a0,$a0,$t4

	li $t5,0
	add_relation_property_loop:
		beq $t5,$t2,add_relation_property_vio1
		lw $t7,0($a0)
		beq $t7,$s1,add_relation_property_contina2
		beq $t7,$s2,add_relation_property_contina1
		addi $a0,$a0,12
		addi $t5,$t5,1
		j add_relation_property_loop

		add_relation_property_contina2:
			addi $a0,$a0,4
			lw $t7,0($a0)
			beq $t7,$s2,add_relation_property_true
			addi $a0,$a0,-4
			addi $a0,$a0,12
			addi $t5,$t5,1
			j add_relation_property_loop
		add_relation_property_contina1:
			addi $a0,$a0,4
			lw $t7,0($a0)
			beq $t7,$s1,add_relation_property_true
			addi $a0,$a0,-4
			addi $a0,$a0,12
			addi $t5,$t5,1
			j add_relation_property_loop

	add_relation_property_true:
		addi $a0,$a0,4
		sw $t6,0($a0)
		li $v0,1
		j add_relation_property_end

	add_relation_property_vio1:
		li $v0,0
		j add_relation_property_end
	add_relation_property_vio2:
		li $v0,-1
		j add_relation_property_end
	add_relation_property_vio3:
		li $v0,-2
		j add_relation_property_end
	add_relation_property_end:
		lw $s0, 0($sp)
		lw $s1, 4($sp)
		lw $s2, 8($sp)
		lw $s3, 12($sp)
		lw $ra, 16($sp)
		addi $sp, $sp, 20
		jr $ra



is_friend_of_friend:
	addi $sp, $sp, -36
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $s7, 28($sp)
	sw $ra, 32($sp)
	move $s0,$a0
	move $s1,$a1
	move $s2,$a2

	jal is_person_name_exists
	beq $v0,$0,is_friend_of_friend_vio1
	move $s3,$v1

	move $a0,$s0
	move $a1,$s2
	jal is_person_name_exists
	beq $v0,$0,is_friend_of_friend_vio1
	move $s4,$v1

	move $a0,$s0
	move $a1,$s3
	move $a2,$s4
	jal is_relation_exists
	bne $v0,$0,is_friend_of_friend_vio0

	#move $a0,$s0
	move $s5,$s0
	lw $t0,0($s5)
	lw $t1,8($s5)
	mult $t0,$t1
	mflo $t1
	lw $s6,20($s5)
	addi $s5,$s5,36
	add $s5,$s5,$t1

	li $s7,0
	is_friend_of_friend_loop:
		beq $s7,$s6,is_friend_of_friend_vio0
		lw $t3,0($s5)
		lw $t4,4($s5)
		lw $t6,8($s5)
		beq $t3,$s3,is_friend_of_friend_checks4
		beq $t4,$s3,is_friend_of_friend_checks3
		addi $s7,$s7,1
		addi $s5,$s5,12
		j is_friend_of_friend_loop

		is_friend_of_friend_checks4:
			addi $s7,$s7,1
			addi $s5,$s5,12
			ble $t6,$0,is_friend_of_friend_loop
			move $s1,$t4
			move $a0,$s0
			move $a1,$t4
			move $a2,$s4
			jal is_relation_exists
			bne $v0,$0,check2ship
			j is_friend_of_friend_loop

		is_friend_of_friend_checks3:
			addi $s7,$s7,1
			addi $s5,$s5,12
			ble $t6,$0,is_friend_of_friend_loop
			move $s1,$t3
			move $a0,$s0
			move $a1,$t3
			move $a2,$s4
			jal is_relation_exists
			bne $v0,$0,check2ship
			j is_friend_of_friend_loop
	
	check2ship:
		move $s5,$s0
		lw $t0,0($s5)
		lw $t1,8($s5)
		mult $t0,$t1
		mflo $t1
		lw $s6,20($s5)
		addi $s5,$s5,36
		add $s5,$s5,$t1
		li $s7,0
		is_friend_of_friend_loop2:
			beq $s7,$s6,is_friend_of_friend_vio0
			lw $t3,0($s5)
			lw $t4,4($s5)
			lw $t6,8($s5)
			beq $t3,$s4,is_friend_of_friend_checks4_1
			beq $t4,$s4,is_friend_of_friend_checks3_1
			addi $s7,$s7,1
			addi $s5,$s5,12
			j is_friend_of_friend_loop2

			is_friend_of_friend_checks4_1:
				addi $s7,$s7,1
				addi $s5,$s5,12
				ble $t6,$0,is_friend_of_friend_loop2
				beq $t4,$s1,is_friend_of_friend_true
				j is_friend_of_friend_loop2
			is_friend_of_friend_checks3_1:
				addi $s7,$s7,1
				addi $s5,$s5,12
				ble $t6,$0,is_friend_of_friend_loop2
				beq $t3,$s1,is_friend_of_friend_true
				j is_friend_of_friend_loop2

	is_friend_of_friend_true:
		li $v0,1
		j is_friend_of_friend_end
	is_friend_of_friend_vio0:
		li $v0,0
		j is_friend_of_friend_end
	is_friend_of_friend_vio1:
		li $v0,-1
		j is_friend_of_friend_end
	is_friend_of_friend_end:
		lw $s0, 0($sp)
		lw $s1, 4($sp)
		lw $s2, 8($sp)
		lw $s3, 12($sp)
		lw $s4, 16($sp)
		lw $s5, 20($sp)
		lw $s6, 24($sp)
		lw $s7, 28($sp)
		lw $ra, 32($sp)
		addi $sp, $sp, 36
		jr $ra