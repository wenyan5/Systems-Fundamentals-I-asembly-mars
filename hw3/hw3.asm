

############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################

.text

load_game:
	move $a3,$a0
	li $t8,0
	li $t9,0      

	li $v0, 13
	move $a0, $a1
	li $a1, 0
	li $a2, 0 
	syscall
	#bltz $v0, openError 
    move $t0, $v0
    li $t5,-1
    beq $v0,$t5,part1endwrong

	#read from file
	move $t1,$a3
	li $v0, 14                      #get top stone number
	move $a0,$t0
	move $a1,$t1
	li $a2,1
	syscall 
	lb $t3,0($t1)
	addi $t3,$t3,-48
	move $t7,$t3
	
	li $v0, 14 
	move $a0,$t0
	move $a1,$t1
	li $a2,1
	syscall 
	lb $t3,0($t1)
	li $t5,92
	beq $t3,$t5,topnum
	li $t5,13 
	beq $t3,$t5,topnum
	li $t5,10
	beq $t3,$t5,topnum
change:
	li $t5,10
	mul $t7,$t7,$t5
	addi $t3,$t3,-48
	add $t7,$t7,$t3
topnum:
	sb $t7,1($t1)
	add $t8,$t8,$t7
	li $t4,10
	div $t7,$t4
	mflo $t4
	mfhi $t5
	addi $t4,$t4,48
	addi $t5,$t5,48
	sb $t4,6($t1)
	sb $t5,7($t1)
	
str1:	          			 #get bot stone number     
	li $v0, 14 
	move $a0,$t0
	move $a1,$t1
	li $a2,1
	syscall 
	lb $t3,0($t1)
	li $t5,92
	beq $t3,$t5,skip1
	li $t5,13 
	beq $t3,$t5,skip1
	li $t5,10
	beq $t3,$t5,skip1
	j str1end 
skip1:
	j str1
str1end:
	lb $t3,0($t1)
	addi $t3,$t3,-48
	move $t7,$t3
	
	li $v0, 14 
	move $a0,$t0
	move $a1,$t1
	li $a2,1
	syscall 
	lb $t3,0($t1)
	li $t5,92
	beq $t3,$t5,botnum
	li $t5,13
	beq $t3,$t5,botnum
	li $t5,10
	beq $t3,$t5,botnum
change1:	
	li $t5,10
	mul $t7,$t7,$t5
	addi $t3,$t3,-48
	add $t7,$t7,$t3
botnum:	
	move $t2,$t7
	add $t8,$t8,$t7                                           
	                                                                                                             
str2:								   # packet number
	li $v0, 14 
	move $a0,$t0
	move $a1,$t1
	li $a2,1
	syscall 
	lb $t3,0($t1)
	li $t5,92
	beq $t3,$t5,skip2
	li $t5,13
	beq $t3,$t5,skip2
	li $t5,10
	beq $t3,$t5,skip2
	j str2end 
skip2:
	j str2
str2end:
	lb $t3,0($t1)
	addi $t3,$t3,-48
	move $t7,$t3
	
	li $v0, 14 
	move $a0,$t0
	move $a1,$t1
	li $a2,1
	syscall 
	lb $t3,0($t1)
	li $t5,92
	beq $t3,$t5,packetnum
	li $t5,13
	beq $t3,$t5,packetnum
	li $t5,10
	beq $t3,$t5,packetnum
change2:	
	li $t5,10
	mul $t7,$t7,$t5
	addi $t3,$t3,-48
	add $t7,$t7,$t3
packetnum:	
	
	li $t4,0
	add $t4,$t4,$t7
	add $t4,$t4,$t7
	move $t6,$t4 

	sb $t7,2($t1)
	sb $t7,3($t1)
	sb $0,4($t1)
	li $t3,'B'
	sb $t3,5($t1)

	addi $t9,$t9,8             # $t9 ,index
	              
strread:
	li $v0, 14 
	move $a0,$t0
	move $a1,$t1
	li $a2,1
	syscall 
	beqz $v0,strreadend
	lb $t3,0($t1)
	li $t5,92
	beq $t3,$t5,skip3
	li $t5,13
	beq $t3,$t5,skip3
	li $t5,10
	beq $t3,$t5,skip3
	addi $t3,$t3,-48
	mul $t7,$t3,$t5
	add $t1,$t1,$t9
	addi $t3,$t3,48
	sb $t3,0($t1)
	sub $t1,$t1,$t9
	addi $t9,$t9,1
	
	li $v0, 14 
	move $a0,$t0
	move $a1,$t1
	li $a2,1
	syscall 
	lb $t3,0($t1)
	li $t5,92
	beq $t3,$t5,skip3
	li $t5,13
	beq $t3,$t5,skip3
	li $t5,10
	beq $t3,$t5,skip3
	addi $t3,$t3,-48
	add $t7,$t7,$t3
	add $t8,$t8,$t7

	addi $t3,$t3,48
	add $t1,$t1,$t9
	sb $t3,0($t1)
	sub $t1,$t1,$t9
	addi $t9,$t9,1
	
skip3:	
	j strread 
strreadend:

	sb $t2,0($t1)
	move $t3,$t2

	li $t4,10
	div $t3,$t4
	mflo $t4
	mfhi $t5
	addi $t4,$t4,48
	addi $t5,$t5,48

	add $t1,$t1,$t9
	sb $t4,0($t1)
	sb $t5,1($t1)
	sub $t1,$t1,$t9

	addi $t9,$t9,2
	
	# Close the file 
	li $v0, 16      
	move $a0,$t0
	syscall      

	li $t5,99
	sle $v0,$t8,$t5 
	li $t5,98
	bgt $t6,$t5,exceed
	move $v1,$t6
	jr $ra
exceed:
	li $v1,0
	jr $ra
part1endwrong:
	li $v0, 16      
	move $a0,$t0
	syscall  

	li $v0,-1
	li $v1,-1
	jr $ra
	


get_pocket:
	li $t1,'B'
	beq $a1,$t1,getbotstone
	li $t1,'T'
	beq $a1,$t1,gettopstone
	j get_pocketerror
getbotstone:
	sge $t2,$a2,$0
	beq $t2,$0,get_pocketerror
	lb $t3,2($a0)
	bge $a2,$t3,get_pocketerror

	li $t2,0						# $t2 is index
	addi $t2,$t2,6
	lb $t3,2($a0)
	li $t1,2
	mul $t3,$t3,$t1
	add $t2,$t2,$t3
	add $t2,$t2,$t3
	mul $t4,$a2,$t1
	sub $t2,$t2,$t4
	add $a0,$a0,$t2
	lb $t3, 0($a0)
	addi $t3,$t3,-48
	li $t4,10
	mul $t5,$t3,$t4
	lb $t3, 1($a0)
	addi $t3,$t3,-48
	add $t5,$t5,$t3
	move $v0,$t5
	jr $ra
gettopstone:
	sge $t2,$a2,$0
	beq $t2,$0,get_pocketerror
	lb $t3,2($a0)
	bge $a2,$t3,get_pocketerror

	li $t2,0						# $t2 is index
	addi $t2,$t2,8
	li $t1,2
	mul $t4,$a2,$t1
	add $t2,$t2,$t4
	add $a0,$a0,$t2
	lb $t3, 0($a0)
	addi $t3,$t3,-48
	li $t4,10
	mul $t5,$t3,$t4
	lb $t3, 1($a0)
	addi $t3,$t3,-48
	add $t5,$t5,$t3
	move $v0,$t5
	jr $ra

get_pocketerror:
	li $v0,-1
	jr $ra




set_pocket:
	sge $t2,$a2,$0
	beq $t2,$0,set_pocketerror1
	lb $t3,2($a0)
	bge $a2,$t3,set_pocketerror1
	li $t1,0
	blt $a3,$t1,set_pocketerror2
	li $t1,99
	bgt $a3,$t1,set_pocketerror2
	li $t1,'B'
	beq $a1,$t1,setbotstone
	li $t1,'T'
	beq $a1,$t1,settopstone
	j set_pocketerror1
setbotstone:
	li $t2,0						# $t2 is index
	addi $t2,$t2,6
	lb $t3,2($a0)
	li $t1,2
	mul $t3,$t3,$t1
	add $t2,$t2,$t3
	add $t2,$t2,$t3
	mul $t4,$a2,$t1
	sub $t2,$t2,$t4
	add $a0,$a0,$t2
	move $v0,$a3
	li $t1,10
	div $a3,$t1
	mflo $t4
	addi $t4,$t4,48
	sb $t4,0($a0)
	mfhi $t4
	addi $t4,$t4,48
	sb $t4,1($a0)
	jr $ra
settopstone:
	li $t2,0						# $t2 is index
	addi $t2,$t2,8
	li $t1,2
	mul $t4,$a2,$t1
	add $t2,$t2,$t4
	add $a0,$a0,$t2
	move $v0,$a3
	li $t1,10
	div $a3,$t1
	mflo $t4
	addi $t4,$t4,48
	sb $t4,0($a0)
	mfhi $t4
	addi $t4,$t4,48
	sb $t4,1($a0)
	jr $ra

set_pocketerror1:
	li $v0,-1
	jr $ra
set_pocketerror2:
	li $v0,-2
	jr $ra




collect_stones:
	ble $a2,$0,collect_stoneserror2
	li $t1,'B'
	beq $a1,$t1,collect_stones_b
	li $t1,'T'
	beq $a1,$t1,collect_stones_t
	j collect_stoneserror1

collect_stones_b:
	lb $t3,0($a0)
	add $t3,$t3,$a2
	sb $t3,0($a0)
	li $t4,10
	div $t3,$t4
	mflo $t4
	addi $t4,$t4,48
	mfhi $t5
	addi $t5,$t5,48

	lb $t3,2($a0)
	li $t2,0
	li $t6,4
	mul $t3,$t3,$t6
	add $t2,$t2,$t3
	addi $t2,$t2,8
	add $a0,$a0,$t2
	sb $t4,0($a0)
	sb $t5,1($a0)

	move $v0,$a2
	jr $ra
collect_stones_t:
	lb $t3,1($a0)
	add $t3,$t3,$a2
	sb $t3,1($a0)
	li $t4,10
	div $t3,$t4
	mflo $t4
	addi $t4,$t4,48
	mfhi $t5
	addi $t5,$t5,48
	sb $t4,6($a0)
	sb $t5,7($a0)

	move $v0,$a2
	jr $ra
collect_stoneserror1:
	li $v0,-1
	jr $ra
collect_stoneserror2:
	li $v0,-2
	jr $ra



verify_move:
	li $t1,99
	beq $a2,$t1,verify_moveerror2
	sge $t1,$a2,$0
	beq $t1,$0,verify_moveerror_1
	lb $t3,2($a0)
	bge $a1,$t3,verify_moveerror_1
	beq $a2,$0,verify_moveerror_2
	lb $t3,5($a0)
	li $t1,'B'
	beq $t3,$t1,verify_move_b
	li $t1,'T'
	beq $t3,$t1,verify_move_t

verify_move_b:
	lb $t3,2($a0)
	li $t2,0
	li $t6,4
	mul $t3,$t3,$t6
	add $t2,$t2,$t3
	addi $t2,$t2,6
	sub $t2,$t2,$a1
	sub $t2,$t2,$a1
	add $a0,$a0,$t2
	lb $t4,0($a0)
	lb $t5,1($a0)
	addi $t4,$t4,-48
	addi $t5,$t5,-48
	li $t6,10
	mul $t4,$t4,$t6
	add $t4,$t4,$t5
	beq $t4,$0,verify_moveerror0
	bne $t4,$a2,verify_moveerror_2
	li $v0,1
	jr  $ra
verify_move_t:
	li $t2,0
	addi $t2,$t2,8
	add $t2,$t2,$a1
	add $t2,$t2,$a1
	lb $t4,0($a0)
	lb $t5,1($a0)
	addi $t4,$t4,-48
	addi $t5,$t5,-48
	li $t6,10
	mul $t4,$t4,$t6
	add $t4,$t4,$t5
	beq $t4,$0,verify_moveerror0
	bne $t4,$a2,verify_moveerror_2
	li $v0,1
	jr  $ra

verify_moveerror2:
	li $v0,2
	jr  $ra
verify_moveerror_1:
	li $v0,-1
	jr  $ra
verify_moveerror_2:
	li $v0,-2
	jr  $ra
verify_moveerror0:
	li $v0,0
	jr  $ra




execute_move:
	move $a3,$a0
	lb $t3, 5($a0)
	li $t1,'B'
	beq $t3,$t1,execute_move_b
	li $t1,'T'
	beq $t3,$t1,execute_move_t
	j execute_moveD

execute_move_b:
	lb $t3,2($a0)
	li $t2,0
	li $t1,0
	li $t6,4
	mul $t3,$t3,$t6
	add $t2,$t2,$t3
	add $t1,$t1,$t3        # $t1 index of bot_mancala

	#li $t8,0
	#add $t8,$t8,$t3
	#add $t8,$t8,$t3
	#addi $t8,$t8,8        # $t8, the top num end

	addi $t1,$t1,8
	add $a0,$a0,$t1
	lb $t4,0($a0)
	lb $t5,1($a0)
	addi $t4,$t4,-48
	addi $t5,$t5,-48
	li $t6,10
	mul $t4,$t4,$t6
	add $t4,$t4,$t5 
	move $t9,$t4		      # $t9  num of bot_mancala
	sub $a0,$a0,$t1

	addi $t2,$t2,6         # $t2 index -> now o distant from bot_mancala
	sub $t2,$t2,$a1
	sub $t2,$t2,$a1
	add $a0,$a0,$t2
	lb $t4,0($a0)
	lb $t5,1($a0)
	addi $t4,$t4,-48
	addi $t5,$t5,-48
	li $t6,10
	mul $t4,$t4,$t6
	add $t4,$t4,$t5           #$t4 / $t7 the origin pocket stone number
	move $t7,$t4
	li $t6,48
	sb $t6,0($a0)
	sb $t6,1($a0)

execute_move_bloop:                # first line to execute

	execute_move_bloop_bot:
	beqz $t4, execute_move_bloopend
	beq $t2,$t1,execute_move_bloop_topall
	addi $t2,$t2,2
	addi $a0,$a0,2
	lb $t3,1($a0)
	addi $t3,$t3,-48
	li $t5,9
	beq $t3,$t5,changetens
	j xchangetens
changetens:
	li $t5,48
	sb $t5,1($a0)
	lb $t3,0($a0)
	addi $t3,$t3,1
	sb $t3,0($a0)
	j after_changetens
xchangetens:
	lb $t3,1($a0)
	#addi $t3,$t3,-48
	addi $t3,$t3,1
	sb $t3,1($a0)
after_changetens:
	addi $t4,$t4,-1

	j execute_move_bloop_bot

	execute_move_bloop_topall:
	move $a0,$a3
	lb $t3,2($a0)
	move $t8,$t1
	sub $t8,$t8,$t3
	sub $t8,$t8,$t3
	addi $t8,$t8,-2
	li $t6,6
	add $a0,$a0,$t8
	exetopall:
	beqz $t4, execute_move_bloopend
	beq $t8,$t6,execute_move_bloop_botall

	lb $t3,1($a0)
	addi $t3,$t3,-48
	li $t5,9
	beq $t3,$t5,execute_changetens1
	j execute_xchangetens1
execute_changetens1:
	li $t5,48
	sb $t5,1($a0)
	lb $t3,0($a0)
	#addi $t3,$t3,-48
	addi $t3,$t3,1
	sb $t3,0($a0)
	j after_execute_changetens1
execute_xchangetens1:
	lb $t3,1($a0)
	addi $t3,$t3,1
	sb $t3,1($a0)
after_execute_changetens1:
	addi $a0,$a0,-2
	addi $t8,$t8,-2
	addi $t4,$t4,-1

	j exetopall

	execute_move_bloop_botall:
	move $a0,$a3
	lb $t3,2($a0)
	move $t8,$t1
	sub $t8,$t8,$t3
	sub $t8,$t8,$t3
	#addi $t8,$t8,2
	add $a0,$a0,$t8
	exebotall:
	beqz $t4, execute_move_bloopend
	bgt $t8,$t1,execute_move_bloop_topall
	
	lb $t3,1($a0)
	addi $t3,$t3,-48
	li $t5,9
	beq $t3,$t5,execute_changetens2
	j execute_xchangetens2
execute_changetens2:
	li $t5,48
	sb $t5,1($a0)
	lb $t3,0($a0)
	addi $t3,$t3,1
	sb $t3,0($a0)
	j after_execute_changetens2
execute_xchangetens2:
	lb $t3,1($a0)
	addi $t3,$t3,1
	sb $t3,1($a0)
after_execute_changetens2:
	addi $t8,$t8,2
	addi $a0,$a0,2
	addi $t4,$t4,-1

	j exebotall


execute_move_bloopend:
	move $a0,$a3
	add $a0,$a0,$t1

	lb $t4,0($a0)
	lb $t5,1($a0)
	addi $t4,$t4,-48
	addi $t5,$t5,-48
	li $t6,10
	mul $t4,$t4,$t6
	add $t4,$t4,$t5 

	move $a0,$a3
	sb $t4,0($a0)

	sub $t4,$t4,$t9
	move $v0,$t4

	move $t8,$t7
	sub $t7,$t7,$a1
	addi $t7,$t7,-1
	beq $t7,$0,execute_move_result2_b

	blt $t7,$0, execute_move_result1_b_check
	j execute_move_result1_b_checkmore

execute_move_result1_b_check:
	move $a0,$a3
	lb $t3,2($a0)
	li $t6,4
	li $t2,6
	mul $t3,$t3,$t6
	add $t2,$t2,$t3
	sub $t2,$t2,$a1
	sub $t2,$t2,$a1
	add $t2,$t2,$t8
	add $t2,$t2,$t8
	add $a0,$a0,$t2
	lb $t4,0($a0)
	lb $t5,1($a0)
	addi $t4,$t4,-48
	addi $t5,$t5,-48
	li $t6,10
	mul $t4,$t4,$t6
	add $t4,$t4,$t5 
	li $t6,1
	beq $t4,$t6,execute_move_result1_b
	j execute_move_result0_b

execute_move_result1_b_checkmore:
	move $a0,$a3
	lb $t3,2($a0)
	
	li $t2,0
	add $t2,$t2,$t3
	add $t2,$t2,$t3
	addi $t2,$t2,1

	div $t7,$t2
	mfhi $t4
	li $t5,7
	beq $t4,$0,execute_move_result2_b
	blt $t4,$t5,execute_move_result0_b

	addi $t4,$t4,-7
	lb $t3,2($a0)
	li $t2,8
	add $t2,$t2,$t3
	add $t2,$t2,$t3
	add $t2,$t2,$t4
	add $t2,$t2,$t4
	add $a0,$a0,$t2
	lb $t4,0($a0)
	lb $t5,1($a0)
	addi $t4,$t4,-48
	addi $t5,$t5,-48
	li $t6,10
	mul $t4,$t4,$t6
	add $t4,$t4,$t5 
	li $t6,1
	beq $t4,$t6,execute_move_result1_b

	j execute_move_result0_b

execute_move_result0_b:
	li $v1,0
	move $a0,$a3
	li $t2,'T'
	sb $t2, 5($a0)
	lb $t3,4($a0)
	addi $t3,$t3,1
	sb $t3,4($a0)
	jr $ra
execute_move_result1_b:
	li $v1,1
	move $a0,$a3
	li $t2,'T'
	sb $t2, 5($a0)
	lb $t3,4($a0)
	addi $t3,$t3,1
	sb $t3,4($a0)
	jr $ra
execute_move_result2_b:
	li $v1,2
	move $a0,$a3
	li $t2,'B'
	sb $t2, 5($a0)
	lb $t3,4($a0)
	addi $t3,$t3,1
	sb $t3,4($a0)
	jr $ra

execute_move_t:
	lb $t3,2($a0)
	li $t2,0
	li $t1,0
	li $t6,2
	addi $t1,$t1,6			 # $t1 the  index of top_mancala

	lb $t4,6($a0)
	lb $t5,7($a0)
	addi $t4,$t4,-48
	addi $t5,$t5,-48
	li $t6,10
	mul $t4,$t4,$t6
	add $t4,$t4,$t5 
	move $t9,$t4		      # $t9  num of top_mancala

	addi $t2,$t2,8         # $t2 index -> now 0 distant from top_mancala
	add $t2,$t2,$a1
	add $t2,$t2,$a1
	add $a0,$a0,$t2
	lb $t4,0($a0)
	lb $t5,1($a0)
	addi $t4,$t4,-48
	addi $t5,$t5,-48
	li $t6,10
	mul $t4,$t4,$t6
	add $t4,$t4,$t5           #$t4 / $t7 the origin pocket stone number
	move $t7,$t4
	li $t6,48
	sb $t6,0($a0)
	sb $t6,1($a0)

execute_move_tloop:            # first line to execute

	execute_move_tloop_top:
	beqz $t4, execute_move_tloopend
	beq $t2,$t1,execute_move_tloop_botall_t
	addi $t2,$t2,-2
	addi $a0,$a0,-2
	lb $t3,1($a0)
	addi $t3,$t3,-48
	li $t5,9
	beq $t3,$t5,execute_changetens3
	j execute_xchangetens3
execute_changetens3:
	li $t5,48
	sb $t5,1($a0)
	lb $t3,0($a0)
	#addi $t3,$t3,-48
	addi $t3,$t3,1
	sb $t3,0($a0)
	j after_execute_changetens3
execute_xchangetens3:
	lb $t3,1($a0)
	#addi $t3,$t3,-48
	addi $t3,$t3,1
	sb $t3,1($a0)
after_execute_changetens3:
	addi $t4,$t4,-1

	j execute_move_tloop_top

	execute_move_tloop_botall_t:
	move $a0,$a3
	lb $t3,2($a0)
	move $t8,$t1
	add $t8,$t8,$t3
	add $t8,$t8,$t3
	addi $t8,$t8,2
	li $t5,4
	mul $t6,$t3,$t5
	addi $t6,$t6,8
	add $a0,$a0,$t8
	exebotall_t:
	beqz $t4, execute_move_tloopend
	beq $t8,$t6,execute_move_tloop_topall
	
	lb $t3,1($a0)
	addi $t3,$t3,-48
	li $t5,9
	beq $t3,$t5,execute_changetens4
	j execute_xchangetens4
execute_changetens4:
	li $t5,48
	sb $t5,1($a0)
	lb $t3,0($a0)
	addi $t3,$t3,1
	sb $t3,0($a0)
	j after_execute_changetens4
execute_xchangetens4:
	lb $t3,1($a0)
	addi $t3,$t3,1
	sb $t3,1($a0)
after_execute_changetens4:
	addi $t8,$t8,2
	addi $a0,$a0,2
	addi $t4,$t4,-1

	j exebotall_t


	execute_move_tloop_topall:

	move $a0,$a3
	lb $t3,2($a0)
	move $t8,$t1
	add $t8,$t8,$t3
	add $t8,$t8,$t3
	li $t6,6
	add $a0,$a0,$t8
	exetopall_t:
	beqz $t4, execute_move_tloopend
	blt $t8,$t6,execute_move_tloop_botall_t

	lb $t3,1($a0)
	addi $t3,$t3,-48
	li $t5,9
	beq $t3,$t5,execute_changetens5
	j execute_xchangetens5
execute_changetens5:
	li $t5,48
	sb $t5,1($a0)
	lb $t3,0($a0)
	#addi $t3,$t3,-48
	addi $t3,$t3,1
	sb $t3,0($a0)
	j after_execute_changetens5
execute_xchangetens5:
	lb $t3,1($a0)
	addi $t3,$t3,1
	sb $t3,1($a0)
after_execute_changetens5:
	addi $a0,$a0,-2
	addi $t8,$t8,-2
	addi $t4,$t4,-1

	j exetopall_t

execute_move_tloopend:

	move $a0,$a3
	add $a0,$a0,$t1

	lb $t4,0($a0)
	lb $t5,1($a0)
	addi $t4,$t4,-48
	addi $t5,$t5,-48
	li $t6,10
	mul $t4,$t4,$t6
	add $t4,$t4,$t5 

	move $a0,$a3
	sb $t4,1($a0)

	sub $t4,$t4,$t9
	move $v0,$t4

	move $t8,$t7
	sub $t7,$t7,$a1
	addi $t7,$t7,-1
	beq $t7,$0,execute_move_result2_t

	blt $t7,$0,execute_move_result1_t_check
	j execute_move_result1_t_checkmore
execute_move_result1_t_check:
	move $a0,$a3
	li $t2,8
	add $t2,$t2,$a1
	add $t2,$t2,$a1
	sub $t2,$t2,$t8
	sub $t2,$t2,$t8
	add $a0,$a0,$t2
	lb $t4,0($a0)
	lb $t5,1($a0)
	addi $t4,$t4,-48
	addi $t5,$t5,-48
	li $t6,10
	mul $t4,$t4,$t6
	add $t4,$t4,$t5 
	li $t6,1
	beq $t4,$t6,execute_move_result1_t
	j execute_move_result0_t

execute_move_result1_t_checkmore:
	#blt $t7,$0, execute_move_result1_t
	move $a0,$a3
	lb $t3,2($a0)
	
	li $t2,0
	add $t2,$t2,$t3
	add $t2,$t2,$t3
	addi $t2,$t2,1

	div $t7,$t2
	mfhi $t4
	li $t5,7
	beq $t4,$0,execute_move_result2_t
	blt $t4,$t5,execute_move_result0_t

	#addi $t4,$t4,-7
	#li $t6,13
	move $t6,$t2
	sub $t5,$t6,$t4
	li $t2,8
	add $t2,$t2,$t5
	add $t2,$t2,$t5
	add $a0,$a0,$t2
	lb $t4,0($a0)
	lb $t5,1($a0)
	addi $t4,$t4,-48
	addi $t5,$t5,-48
	li $t6,10
	mul $t4,$t4,$t6
	add $t4,$t4,$t5 
	li $t6,1
	beq $t4,$t6,execute_move_result1_t

	j execute_move_result0_t

execute_move_result0_t:
	li $v1,0
	move $a0,$a3
	li $t2,'B'
	sb $t2, 5($a0)
	lb $t3,4($a0)
	addi $t3,$t3,1
	sb $t3,4($a0)
	jr $ra
execute_move_result1_t:
	li $v1,1
	move $a0,$a3
	li $t2,'B'
	sb $t2, 5($a0)
	lb $t3,4($a0)
	addi $t3,$t3,1
	sb $t3,4($a0)
	jr $ra
execute_move_result2_t:
	li $v1,2
	move $a0,$a3
	li $t2,'T'
	sb $t2, 5($a0)
	lb $t3,4($a0)
	addi $t3,$t3,1
	sb $t3,4($a0)
	jr $ra

execute_moveD:
	li $v0,0
	li $v1,0
	jr $ra




steal:
	move $t7,$a0
	lb $t3,5($a0)
	li $t1,'B'     # be t !?!!!
	beq $t3,$t1,steal_t
	li $t1,'T'
	beq $t3,$t1,steal_b
steal_b:
	lb $t3,2($a0)
	move $t8,$t3			#t8, the row pocket size
	li $t2,0
	li $t6,4
	mul $t3,$t3,$t6
	add $t2,$t2,$t3
	addi $t2,$t2,6
	sub $t2,$t2,$a1
	sub $t2,$t2,$a1
	add $a0,$a0,$t2
	lb $t4,0($a0)
	lb $t5,1($a0)
	addi $t4,$t4,-48
	addi $t5,$t5,-48
	li $t6,10
	mul $t4,$t4,$t6
	add $t4,$t4,$t5		#$t4 the last deposit pocket stone number
	move $t9,$t4		# $t9, the steal num
	li $t5,48
	sb $t5,0($a0)
	sb $t5,1($a0)
	sub $a0,$a0,$t8
	sub $a0,$a0,$t8
	lb $t4,0($a0)
	lb $t5,1($a0)
	addi $t4,$t4,-48
	addi $t5,$t5,-48
	li $t6,10
	mul $t4,$t4,$t6
	add $t4,$t4,$t5
	add $t9,$t9,$t4
	li $t5,48
	sb $t5,0($a0)
	sb $t5,1($a0)

	move $a0,$t7
	lb $t3,2($a0)
	li $t2,0
	li $t6,4
	mul $t3,$t3,$t6
	add $t2,$t2,$t3
	addi $t2,$t2,8
	add $a0,$a0,$t2
	lb $t4,0($a0)
	lb $t5,1($a0)
	addi $t4,$t4,-48
	addi $t5,$t5,-48
	li $t6,10
	mul $t4,$t4,$t6
	add $t4,$t4,$t5
	add $t4,$t4,$t9
	move $v0,$t4

	li $t1,10
	div $t4,$t1
	mflo $t5
	mfhi $t6
	addi $t5,$t5,48
	addi $t6,$t6,48
	sb $t5,0($a0)
	sb $t6,1($a0)

	move $a0,$t7
	sb $v0,0($a0)
	jr $ra
steal_t:
	lb $t3,2($a0)
	move $t8,$t3			#t8, the row pocket size
	li $t2,0
	addi $t2,$t2,8
	add $t2,$t2,$a1
	add $t2,$t2,$a1
	add $a0,$a0,$t2
	lb $t4,0($a0)
	lb $t5,1($a0)
	addi $t4,$t4,-48
	addi $t5,$t5,-48
	li $t6,10
	mul $t4,$t4,$t6
	add $t4,$t4,$t5
	move $t9,$t4		# $t9, the steal num
	li $t5,48
	sb $t5,0($a0)
	sb $t5,1($a0)
	add $a0,$a0,$t8
	add $a0,$a0,$t8
	lb $t4,0($a0)
	lb $t5,1($a0)
	addi $t4,$t4,-48
	addi $t5,$t5,-48
	li $t6,10
	mul $t4,$t4,$t6
	add $t4,$t4,$t5
	add $t9,$t9,$t4
	li $t5,48
	sb $t5,0($a0)
	sb $t5,1($a0)

	move $a0,$t7
	addi $a0,$a0,6
	lb $t4,0($a0)
	lb $t5,1($a0)
	addi $t4,$t4,-48
	addi $t5,$t5,-48
	li $t6,10
	mul $t4,$t4,$t6
	add $t4,$t4,$t5
	add $t4,$t4,$t9
	move $v0,$t4

	li $t1,10
	div $t4,$t1
	mflo $t5
	mfhi $t6
	addi $t5,$t5,48
	addi $t6,$t6,48
	sb $t5,0($a0)
	sb $t6,1($a0)
	move $a0,$t7
	sb $v0,1($a0)
	jr $ra

check_row:
	move $t9,$a0

	lb $t3,2($a0)
	move $t1,$t3               # number of packet
	#addi $t1,$t1,-1
	move $t2,$t3
	#addi $t2,$t2,-1
	addi $a0,$a0,8
check_row_tloop:
	beq $t1,$0,check_row_t_empty
	lb $t4,0($a0)
	lb $t5,1($a0)
	addi $t4,$t4,-48
	addi $t5,$t5,-48
	li $t6,10
	mul $t4,$t4,$t6
	add $t4,$t4,$t5
	bne $t4,$0,check_row_bloop
	addi $a0,$a0,2
	addi $t1,$t1,-1
	j check_row_tloop

check_row_bloop:
	move $a0,$t9
	lb $t3,2($a0)
	addi $a0,$a0,8
	add $a0,$a0,$t3
	add $a0,$a0,$t3

	check_row_bloop1:
	beq $t2,$0,check_row_b_empty
	lb $t4,0($a0)
	lb $t5,1($a0)
	addi $t4,$t4,-48
	addi $t5,$t5,-48
	li $t6,10
	mul $t4,$t4,$t6
	add $t4,$t4,$t5
	bne $t4,$0,check_row_notempty
	addi $a0,$a0,2
	addi $t2,$t2,-1
	j check_row_bloop1

check_row_t_empty:
	li $t8,0                  # t8, the row of pocket collect
	move $a0,$t9
	lb $t3,2($a0)
	addi $a0,$a0,8
	add $a0,$a0,$t3
	add $a0,$a0,$t3
	#addi $t3,$t3,-1

	check_row_collectb:
	beq $t3,$0,check_row_collectb_end
	lb $t4,0($a0)
	lb $t5,1($a0)
	addi $t4,$t4,-48
	addi $t5,$t5,-48
	li $t6,10
	mul $t4,$t4,$t6
	add $t4,$t4,$t5
	add $t8,$t8,$t4
	li $t5,48
	sb $t5,0($a0)
	sb $t5,1($a0)
	addi $a0,$a0,2
	addi $t3,$t3,-1
	j check_row_collectb

check_row_collectb_end:
	li $v0,1
	move $a0,$t9
	lb $t3,0($a0)
	add $t3,$t3,$t8
	sb $t3,0($a0)
	move $t7,$t3
	li $t6,4
	lb $t3,2($a0)
	mul $t3,$t3,$t6
	li $t5,8
	add $t5,$t5,$t3
	add $a0,$a0,$t5

	li $t6,10
	div $t7,$t6
	mflo $t5
	mfhi $t6
	addi $t5,$t5,48
	addi $t6,$t6,48
	sb $t5,0($a0)
	sb $t6,1($a0)
	
	move $a0,$t9
	li $t5,'D'
	sb $t5,5($a0)

	lb $t3,0($a0)
	lb $t4,1($a0)
	blt $t3,$t4,check_row_v2
	beq $t3,$t4,check_row_v0
	bgt $t3,$t4,check_row_v1

check_row_b_empty:
	li $t8,0   
	move $a0,$t9
	lb $t3,2($a0)
	#addi $t3,$t3,-1
	move $t9,$a0
	addi $a0,$a0,8
	check_row_collectt:
	beq $t3,$0,check_row_collectt_end
	lb $t4,0($a0)
	lb $t5,1($a0)
	addi $t4,$t4,-48
	addi $t5,$t5,-48
	li $t6,10
	mul $t4,$t4,$t6
	add $t4,$t4,$t5
	add $t8,$t8,$t4
	li $t5,48
	sb $t5,0($a0)
	sb $t5,1($a0)
	addi $a0,$a0,2
	addi $t3,$t3,-1
	j check_row_collectt

check_row_collectt_end:
	li $v0,1
	move $a0,$t9
	lb $t4,1($a0)
	add $t4,$t4,$t8
	sb $t4,1($a0)
	move $t7,$t4

	addi $a0,$a0,6
	li $t6,10
	div $t7,$t6
	mflo $t5
	mfhi $t6
	addi $t5,$t5,48
	addi $t6,$t6,48
	sb $t5,0($a0)
	sb $t6,1($a0)

	move $a0,$t9
	li $t5,'D'
	sb $t5,5($a0)

	lb $t4,1($a0)
	lb $t3,0($a0)
	blt $t3,$t4,check_row_v2
	beq $t3,$t4,check_row_v0
	bgt $t3,$t4,check_row_v1

check_row_notempty:
	li $v0,0
	move $a0,$t9
	lb $t3,0($a0)
	lb $t4,1($a0)
	blt $t3,$t4,check_row_v2
	beq $t3,$t4,check_row_v0
	bgt $t3,$t4,check_row_v1

check_row_v2:
	li $v1,2
	jr $ra
check_row_v0:
	li $v1,0
	jr $ra
check_row_v1:
	li $v1,1
	jr $ra




load_moves:
	move $a3,$a0
	li $t1,0
	li $v0, 13
	move $a0, $a1
	li $a1, 0
	li $a2, 0 
	syscall
	#bltz $v0, openError 
    move $t0, $v0
    li $t5,-1
    beq $v0,$t5,part9endwrong

	#read from file
	li $v0, 14      
	move $a0,$t0
	move $a1,$a3
	li $a2,1
	syscall 
	lb $t3,0($a3)
	addi $t3,$t3,-48
	move $t9,$t3                    # $t9 Quantity of columns

	li $v0, 14      
	move $a0,$t0
	move $a1,$a3
	li $a2,1
	syscall 
	lb $t3,0($a3)
	li $t5,13 
	beq $t3,$t5,topnum_part9
	li $t5,10
	beq $t3,$t5,topnum_part9

	li $t5,10
	mul $t9,$t9,$t5
	addi $t3,$t3,-48
	add $t9,$t9,$t3
topnum_part9:

str1_part9:	                               
	li $v0, 14 
	move $a0,$t0
	move $a1,$a3
	li $a2,1
	syscall 
	lb $t3,0($a3)
	li $t5,13 
	beq $t3,$t5,skip1_part9
	li $t5,10
	beq $t3,$t5,skip1_part9
	j str1end_part9 
skip1_part9:
	j str1_part9
str1end_part9:
	addi $t3,$t3,-48
	move $t8,$t3                # $t8 Quantity of rows
	
	li $v0, 14 
	move $a0,$t0
	move $a1,$a3
	li $a2,1
	syscall 
	lb $t3,0($a3)
	li $t5,13
	beq $t3,$t5,botnum_part9
	li $t5,10
	beq $t3,$t5,botnum_part9
change1_part9:	
	li $t5,10
	mul $t8,$t8,$t5
	addi $t3,$t3,-48
	add $t8,$t8,$t3
botnum_part9:	

str2_part9:	                               
	li $v0, 14 
	move $a0,$t0
	move $a1,$a3
	li $a2,1
	syscall 
	lb $t3,0($a3)
	li $t5,13 
	beq $t3,$t5,skip2_part9
	li $t5,10
	beq $t3,$t5,skip2_part9
	j str2end_part9 
skip2_part9:
	j str2_part9
str2end_part9:
	addi $t3,$t3,-48
	move $t2,$t3             
	
	li $v0, 14 
	move $a0,$t0
	move $a1,$a3
	li $a2,1
	syscall 
	lb $t3,0($a3)
	li $t5,10
	mul $t2,$t2,$t5
	addi $t3,$t3,-48
	add $t2,$t2,$t3                  # $t2 first move

	move $t6,$t9
	addi $t6,$t6,-1
strread_part9:
	beq $t6,$0,insert99
	li $v0, 14 
	move $a0,$t0
	move $a1,$a3
	li $a2,1
	syscall 
	beqz $v0,strreadend_part9
	lb $t3,0($a3)
	li $t5,10
	addi $t3,$t3,-48
	mul $t7,$t3,$t5
	
	li $v0, 14 
	move $a0,$t0
	move $a1,$a3
	li $a2,1
	syscall 
	lb $t3,0($a3)
	#li $t5,13
	#beq $t3,$t5,skip3_part9
	#li $t5,10
	#beq $t3,$t5,skip3_part9
	addi $t3,$t3,-48
	add $t7,$t7,$t3
	
	addi $t1,$t1,1
	add $a3,$a3,$t1
	sb $t7,0($a3)
	sub $a3,$a3,$t1
	addi $t6,$t6,-1
skip3_part9:	
	j strread_part9
#strreadend_part9:

insert99:
	addi $t1,$t1,1
	add $a3,$a3,$t1
	li $t7,99
	sb $t7,0($a3)
	sub $a3,$a3,$t1

moveloop:
	move $t6,$t9
moveloop_part9:
	beq $t6,$0,insert99_2
	li $v0, 14 
	move $a0,$t0
	move $a1,$a3
	li $a2,1
	syscall 
	beqz $v0,strreadend_part9
	lb $t3,0($a3)
	li $t5,10
	addi $t3,$t3,-48
	mul $t7,$t3,$t5
	
	li $v0, 14 
	move $a0,$t0
	move $a1,$a3
	li $a2,1
	syscall 
	lb $t3,0($a3)
	#li $t5,13
	#beq $t3,$t5,skip3_part9
	#li $t5,10
	#beq $t3,$t5,skip3_part9
	addi $t3,$t3,-48
	add $t7,$t7,$t3
	
	addi $t1,$t1,1
	add $a3,$a3,$t1
	sb $t7,0($a3)
	sub $a3,$a3,$t1
	addi $t6,$t6,-1

	j moveloop_part9
#strreadend_part9:

insert99_2:
	addi $t1,$t1,1
	add $a3,$a3,$t1
	li $t7,99
	sb $t7,0($a3)
	sub $a3,$a3,$t1
	j moveloop

strreadend_part9:
	li $v0, 16      
	move $a0,$t0
	syscall      

	sb $t2,0($a3)
	mul $t6,$t9,$t8
	addi $t8,$t8,-1
	add $t6,$t6,$t8
	move $v0,$t6
	jr $ra

part9endwrong:
	li $v0, 16      
	move $a0,$t0
	syscall      

	li $v0,-1
	jr $ra



play_game:
	move $fp,$sp
	addi $sp, $sp, -20
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $ra, 16($sp)
	move $s0, $a0         # moves_filename
	move $s1, $a1		  # board_filename
	move $s2, $a2			# state
	move $s3, $a3			# moves
	move $a0, $s2
	move $a1,$s1
	jal load_game
	li $t1,1
	bne $v0,$t1,play_game_errorv0_1

	move $a0,$s3
	move $a1,$s0
	jal load_moves
	li $t1,-1
	beq $v0,$t1,play_game_errorv0_1
	move $t2,$v0				# t2, the move number from file

	lw $t3,0($fp)          #  t3, num_moves_to_execute xxx
	ble $t3,$0,play_game_asprovide

	ble $t3,$t2,play_game_executechange
	j xplay_game_executechange
play_game_executechange:
	move $t2,$t3
xplay_game_executechange:
	#move $t4,$t2
	li $t4,0              # t4, actual move

	move $t1,$s3
	play_game_loop:

	beqz $t2, play_game_loop_end
	lb $t3,0($t1)   # t3, the distance from the from  mancala of the current player¡¯s turn
	addi $t1,$t1,1
	addi $t2,$t2,-1
	

	li $t5,99
	beq $t3,$t5,turnchange
	li $t5,49
	bge $t3,$t5,turnchange1
	j xturnchange
turnchange:
	move $a0,$s2
	lb $t5,5($a0)
	li $t7,'B'
	beq $t5,$t7,turnchange_B
	li $t7,'T'
	beq $t5,$t7,turnchange_T
	j turnchangetoend
turnchange_B:
	li $t7,'T'
	sb $t7,5($a0)
	j turnchangetoend
turnchange_T:
	li $t7,'B'
	sb $t7,5($a0)
	j turnchangetoend
turnchangetoend:
	lb $t5,4($a0)
	addi $t5,$t5,1
	sb $t5,4($a0)
	addi $t4,$t4,1
	j play_game_loop
turnchange1:
	j play_game_loop
xturnchange:
	addi $t4,$t4,1
	addi $sp,$sp,-16
	sw $t2, 0($sp)
	sw $t3, 4($sp)
	sw $t4, 8($sp)
	sw $t1, 12($sp)

	move $a0,$s2
	lb $t8,5($a0)
	move $a1,$t8
	move $a2,$t3
	jal get_pocket

	lw $t2, 0($sp)
	lw $t3, 4($sp)
	lw $t4, 8($sp)
	lw $t1, 12($sp)
	addi $sp, $sp, 16

	li $t5,-1
	beq $v0,$t5,play_game_errorv0_1
	beq $v0,$0,play_game_errorv0_1xxx
	move $t6,$v0

	addi $sp,$sp,-20
	sw $t2, 0($sp)
	sw $t3, 4($sp)
	sw $t4, 8($sp)
	sw $t1, 12($sp)
	sw $t6, 16($sp)

	move $a0,$s2
	move $a1,$t3
	jal execute_move

	lw $t2, 0($sp)
	lw $t3, 4($sp)
	lw $t4, 8($sp)
	lw $t1, 12($sp)
	lw $t6, 16($sp)
	addi $sp, $sp, 20

	li $t5,1
	beq $v1,$t5,gotosteal

finishsteal:

	addi $sp,$sp,-20
	sw $t2, 0($sp)
	sw $t3, 4($sp)
	sw $t4, 8($sp)
	sw $t1, 12($sp)
	sw $t6, 16($sp)

	move $a0,$s2
	jal check_row

	lw $t2, 0($sp)
	lw $t3, 4($sp)
	lw $t4, 8($sp)
	lw $t1, 12($sp)
	lw $t6, 16($sp)
	addi $sp, $sp, 20

	bne $v0,$0,gameover
	j notplay_game_errorv0_1xxx
play_game_errorv0_1xxx:
	addi $t4,$t4,-1
notplay_game_errorv0_1xxx:
	j play_game_loop

play_game_loop_end:
	move $a0,$s2
	li $t5,'D'
	lb $t3,5($a0)
	beq $t3,$t5,isD
	j play_game_result0

isD:
	lb $t3,0($a0)
	lb $t4,1($a0)
	blt $t3,$t4,play_game_result2
	beq $t3,$t4,play_game_result0
	bgt $t3,$t4,play_game_result1

gameover:
	li $t5,1
	beq $v1,$t5,play_game_result1
	li $t5,2
	beq $v1,$t5,play_game_result2
	li $t5,0
	beq $v1,$t5,play_game_result0

gotosteal:
	move $a0,$s2
	move $t7,$t3
	ble $t6,$t7,destination_pocket1
	#sub $t6,$t6,$t7             # t6,destination_pocket1
	#addi $t6,$t6,-1
	
	lb $t5,2($a0)
	add $t8,$0,$t5
	add $t8,$t8,$t5
	addi $t8,$t8,1

	div $t6,$t8
	mfhi $t5
	#addi $t5,$t5,-7
	#move $t6,$t5
	sub $t6,$t8,$t5
	#sub $t6,$t6,$t7
	add $t6,$t6,$t7
	j start_steal

destination_pocket1:
	sub $t6,$t7,$t6

start_steal:

	addi $sp,$sp,-20
	sw $t2, 0($sp)
	sw $t3, 4($sp)
	sw $t4, 8($sp)
	sw $t1, 12($sp)
	sw $t6, 16($sp)

	move $a0,$s2
	move $a1,$t6
	jal steal

	lw $t2, 0($sp)
	lw $t3, 4($sp)
	lw $t4, 8($sp)
	lw $t1, 12($sp)
	lw $t6, 16($sp)
	addi $sp, $sp, 20

	j finishsteal


play_game_asprovide:
	move $a0,$s2
	lb $t3,0($a0)
	lb $t4,1($a0)
	blt $t3,$t4,play_game_asprovidev02
	beq $t3,$t4,play_game_asprovidev00
	bgt $t3,$t4,play_game_asprovidev01

play_game_result1:
	li $v0,1
	move $v1,$t4
	j play_game_end

play_game_result2:
	li $v0,2
	move $v1,$t4
	j play_game_end

play_game_result0:
	li $v0,0
	move $v1,$t4
	j play_game_end

play_game_asprovidev00:
	li $v0,0
	li $v1,0
	j play_game_end

play_game_asprovidev01:
	li $v0,1
	li $v1,0
	j play_game_end

play_game_asprovidev02:
	li $v0,2
	li $v1,0
	j play_game_end	

play_game_errorv0_1:
	li $v0,-1
	li $v1,-1
	j play_game_end

play_game_end:
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $ra, 16($sp)
	addi $sp, $sp, 20
	jr  $ra



print_board:
	move $a1,$a0

	lb $t3,6($a0)
	addi $t3,$t3,-48
	move $a0,$t3
	li $v0,1
	syscall

	move $a0,$a1
	lb $t3,7($a0)
	addi $t3,$t3,-48
	move $a0,$t3
	li $v0,1
	syscall
	addi $a0,$0,0xA
	li $v0,11
	syscall

	move $a0,$a1
	lb $t3,0($a0)
	li $t7,10
	div $t3,$t7
	mflo $t3
	move $a0,$t3
	li $v0,1
	syscall
	mfhi $t3
	move $a0,$t3
	li $v0,1
	syscall
	addi $a0,$0,0xA
	li $v0,11
	syscall


	lb $t2,2($a1)
	add $t4,$0,$t2
	add $t4,$t4,$t2
	addi $a1,$a1,8
	move $t9,$t4
	move $t8,$t4
print_board_p:
	beqz $t9,print_board_pend
	lb $t3,0($a1)
	addi $a1,$a1,1
	addi $t9,$t9,-1
	addi $t3,$t3,-48
	move $a0,$t3
	li $v0,1
	syscall
	j print_board_p
print_board_pend:
	addi $a0,$0,0xA
	li $v0,11
	syscall

print_board_p1:
	beqz $t8,print_board_pend1
	lb $t3,0($a1)
	addi $a1,$a1,1
	addi $t8,$t8,-1
	addi $t3,$t3,-48
	move $a0,$t3
	li $v0,1
	syscall
	j print_board_p1
print_board_pend1:
	jr $ra


write_board:
	move $a3,$a0
	#addi $a1,$a0,6

	li $v0, 9 
    li $a0, 10
    syscall

	move $a2,$v0
	li  $t1,'o'
	sb  $t1, 0($a2)
	li  $t1,'u'
	sb $t1, 1($a2)
	li  $t1,'t'
	sb $t1, 2($a2)
	li  $t1,'p'
	sb $t1, 3($a2)
	li  $t1,'u'
	sb $t1, 4($a2)
	li  $t1,'t'
	sb $t1, 5($a2)
	li  $t1,'.'
	sb $t1, 6($a2)
	li  $t1,'t'
	sb $t1, 7($a2)
	li  $t1,'x'
	sb $t1, 8($a2)
	li  $t1,'t'
	sb $t1, 9($a2)

	li   $v0, 13       # system call for open file
  	move  $a0, $a2      # output file name
  	li   $a1, 1        # Open for writing (flags are 0: read, 1: write)
  	li   $a2, 0        # mode is ignored
  	syscall            # open a file (file descriptor returned in $v0)
  	move $t0, $v0      # save the file descriptor 
  	###############################################################
  	# Write to file just opened
  	#li   $v0, 15       # system call for write to file
  	#move $a0, $t0       # file descriptor 
  	#move  $a1, $a3      # address of buffer from which to write
  	#li   $a2, 1       # hardcoded buffer length
  	#syscall            # write to file

	li $t1,0
	blt $t0,$t1,write_boarderror

	move $a0,$a3
	lb $t2,2($a0)
	li $t4,8
	add $t4,$t4,$t2
	add $t4,$t4,$t2
	add $t4,$t4,$t2
	add $t4,$t4,$t2
	add $a0,$a0,$t4

	li   $v0, 15  
	move  $a1, $a0      
  	move $a0, $t0       
  	li   $a2, 2    
  	syscall  

	move $a0,$a3
	li $t2,10
	lb $t3,0($a0)
	sb $t2,0($a0)
	li   $v0, 15  
	move  $a1, $a0      
  	move $a0, $t0       
  	li   $a2, 1      
  	syscall  
	move $a0,$a3
	sb $t3,0($a0)

	addi $a0,$a0,6
	li   $v0, 15  
	move  $a1, $a0      
  	move $a0, $t0       
  	li   $a2, 2    
  	syscall  

	move $a0,$a3
	li $t2,10
	lb $t3,0($a0)
	sb $t2,0($a0)
	li   $v0, 15  
	move  $a1, $a0      
  	move $a0, $t0       
  	li   $a2, 1      
  	syscall  
	move $a0,$a3
	sb $t3,0($a0)

	lb $t2,2($a1)
	add $t2,$t2,$t2
	addi $a0,$a0,8
	li   $v0, 15  
	move  $a1, $a0      
  	move $a0, $t0       
  	move  $a2,$t2 
  	syscall  

	move $a0,$a3
	li $t2,10
	lb $t3,0($a0)
	sb $t2,0($a0)
	li   $v0, 15  
	move  $a1, $a0      
  	move $a0, $t0       
  	li   $a2, 1      
  	syscall  
	move $a0,$a3
	sb $t3,0($a0)

	lb $t2,2($a1)
	add $t2,$t2,$t2
	addi $a0,$a0,8
	add $a0,$a0,$t2
	li   $v0, 15  
	move  $a1, $a0      
  	move $a0, $t0       
  	move  $a2,$t2 
  	syscall 

  	# Close the file 
  	li   $v0, 16       # system call for close file
  	move $a0, $t0      # file descriptor to close
  	syscall            # close file

	li $v0,1
	jr $ra
	
write_boarderror:
	li   $v0, 16       # system call for close file
  	move $a0, $t0      # file descriptor to close
  	syscall            # close file

	li $v0,-1
	jr $ra

############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################
