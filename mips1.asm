.data # �rea para dados da mem�ria
	
	msg: .asciiz "Ol� Mundo" # Mensagem a ser exibida pelo usu�rio

.text # �rea para instru��es
	
	li $v0, 4 # Instru��o para impress�o de string
	la $a0, msg # Guarda a mensagem em um endere�o
	syscall # Faz a instru��o