.data
	number1: .word 30
	number2: .word 24
	number3: .word 15
	rVariable: .word 0
	
.text
	lw $a0, number1
	lw $a1, number2
	lw $a2, number3
	
	jal LessThan
	beq $v0, $zero, isNotTriangle
	
	lw $a0, number3
	lw $a2, number1
	jal LessThan
	beq $v0, $zero, isNotTriangle
	
	lw $a1, number1
	lw $a2, number2
	jal LessThan
	beq $v0, $zero, isNotTriangle
	
	j IsTriangle

LessThan:
	add $t1, $a0, $a1
	slt $t2, $a2, $t1
	beq $t2, $zero, NotLessThan
	addi $v0, $zero, 1
	jr $ra
	
	NotLessThan:
		addi $v0, $zero, 0
	jr $ra
	
IsTriangle:
	bne $a0, $a1, VerifyIfIsosceles
	bne $a1, $a2, isIsosceles
	
	addi $t0, $zero, 1
	sw $t0, rVariable
	j End
	
	VerifyIfIsosceles:
		bne $a0, $a2, isEscaleno
		bne $a1, $a2, isEscaleno
		
		isIsosceles:
			addi $t0, $zero, 2
			sw $t0, rVariable
			j End
		
	isEscaleno:
		beq $a0, $a2, isIsosceles
		beq $a1, $a2, isIsosceles
		
		addi $t0, $zero, 3
		sw $t0, rVariable
		j End

isNotTriangle:
	
End:
	li $v0, 10
	syscall
	