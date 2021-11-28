.data
	number1: .word -3
	number2: .word 8
	result: .word 0

.text
	lw $s0, number1
	lw $s1, number2
	addi $t3, $zero, 1 # Os passos
	
	slt $t8, $s0, $zero # t8 = number1 < 0
	slt $t9, $s1, $zero
	beq $t9, $zero, isUnsigned
		lw $s0, number2 # if number2 < 0:
		lw $s1, number1 #    A, B = B, A
	
	beq $t8, $zero, isUnsigned  # and if number1 < 0:
		addi $t3, $zero, -1 # 	passo = -1
	isUnsigned:
	
	addi $a0, $s0, 0
	addi $a1, $s1, 0
	addi $a2, $t3, 0
	jal Multi
	addi $s3, $v0, 0
	
	bne $t3, -1, IsNotNegatives # if A < 0 and B < 0: resultado * -1
		addi $a0, $zero, 1
		addi $a1, $s3, 0
		addi $a2, $zero, -1
		jal Multi
		addi $s3, $v0, 0
	IsNotNegatives:
	
	j End
	
Multi:
	addi $v0, $zero, 0
	addi $t0, $zero, 0
	WhileMulti:
		beq $t0, $a1, EndMulti
		add $v0, $v0, $a0
		add $t0, $t0, $a2
	j WhileMulti
	
	EndMulti:
		jr $ra

End:
	li $v0, 1
	addi $a0, $s3, 0
	syscall
	
	li $v0, 10
	syscall

