.data
	array: .word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
	
.text
	la $s0, array # s0 fica o local da mem�ria do array
	For: 
		sll $t0, $s2, 2	  # s2 � o �ndice
		add $s1, $t0, $s0 # S1 � o local array[$s2]
		lw $t2, 0($s1) # Pega o valor de array[$s1]
		
		div $t1, $s2, 2 # Divide $s2 e joga o resto no mfhi
		mfhi $t1	# Guarda o resto no $t1
		beq $t1, $zero, IsEven
		IsOdd:
			sll $t2, $t2, 1
			sw $t2, 0($s1)
			j Continue
		IsEven:
			addi $s3, $s1, 4 # array[i + 1]
			lw $t3, 0($s3)
			add $t2, $t2, $t3
			sw $t2, 0($s1)
		Continue:
		
		addi $s2, $s2, 1
		sle $t1, $s2, 9 
	bne $t1, $zero, For
	j End
End:
