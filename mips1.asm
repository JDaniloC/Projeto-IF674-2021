.data # Área para dados da memória
	
	msg: .asciiz "Olá Mundo" # Mensagem a ser exibida pelo usuário

.text # Área para instruções
	
	li $v0, 4 # Instrução para impressão de string
	la $a0, msg # Guarda a mensagem em um endereço
	syscall # Faz a instrução