# Ordena uma string e formata em letras minúsculas

.data
	string: .asciiz  "ZXCVBMNASDFGHJKLQWERTYUIOP"
	newString: .asciiz 

.text
	la  $v0, string # v0 carrega o local da memória de string
	jal Length
	addi $a3, $a0, 0 # a3 é o tamanho da palavra
	jal ToLowerCase
	
	la $a0, string
	addi $t0, $zero, 0 	# índice i
	WhileNotOrdered:
		addi $t1, $t0, 1	# índice j
		add  $t2, $t0, $a0	# t2 recebe o local da memória de string[i]
		lb   $s0, ($t2)		# s0 = string[i]
		
		ForBytes:
			beq  $t1, $a3, EndForBytes # if j == len: exit()
			
			add $t2, $t1, $a0	# t1 recebe o local de string + j
			lb  $s1, ($t2)		# s1 = string[j]
			
			slt $t3, $s1, $s0	# string[j] < string[i]
			beq $t3, $zero, IsGreaterThan
			
			addi $t4, $s0, 0
			la   $s0, ($s1) 
			sb   $t4, ($t2) 
			
			IsGreaterThan:
				addi $t1, $t1, 1	# j += 1
		j ForBytes
		
		EndForBytes:
			sb $s0, newString($t0)	# novaString[i] = s0
			addi $t0, $t0, 1	# i += 1
			beq  $t0, $a3,   End	# if i == len: exit()
	j WhileNotOrdered		

ToLowerCase:
	WhileNotLower:
		add $t1, $t0, $v0	# t1 recebe o local de a0[i]
		lb $t2, ($t1)		# t1 = a0[i]
		
		addi $t4, $zero, 97
		slt $t3, $t2, $t4	# t1 < 97
		beq $t3, $zero, isLower
		
		addi $t3, $t2, 32	# Pega a letra minúscula
		sb $t3, ($t1)		# a0[i] = t2 - 32
		
		isLower:	
			addi $t0, $t0, 1		# i += 1
			beq  $t0, $a3,   IsLowerCase	# if i == 7: exit()
	j WhileNotLower

	IsLowerCase:
		jr $ra

Length:
	addi $a0, $zero, 0 
	ForLength:
		add $t1, $a0, $v0	# t1 recebe o local da memória de string[i]
		lb  $t2, ($t1)		# t1 = a[i]
		beq $t2, $zero, EndForLength  	# Verifica se tem um carácter nulo
		addi $a0, $a0, 1 		# increment the count
	j ForLength 				# return to the top of the loop
	
	EndForLength:
		addi $t1, $zero, 0	# Resets t1
		addi $t2, $zero, 0	# Resets t2
		
		jr $ra

End:
	li $v0, 4
	la $a0, newString
	syscall
	
	li $v0, 10
	syscall
