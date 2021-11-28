# int idadeJoao = ? [valor entre 0,100]
# int idadePedro = ? [valor entre 0,100]
# if (idadeJoao > idadePedro) {
# 	print("João é mais velho que Pedro”)
# } else if (idadePedro > idadeJoao) {
# 	print(“Pedro é mais velho que João")
# } else {
# 	print(“Eles têm a mesma idade")
# }

.data
	askJoaoOld: .asciiz "Digite a idade de João: "
	askPedroOld: .asciiz "Digite a idade de Pedro: "
	
	joaoIsOlderStr: .asciiz "João é mais velho que Pedro"
	pedroIsOlderStr: .asciiz "Pedro é mais velho que João"
	areEqualStr: .asciiz "Eles têm a mesma idade"
.text  
	li $v0, 4 # Carregando e printando uma frase
	la $a0, askJoaoOld
	syscall
	
	li $v0, 5 # Pedindo input do usuário
	syscall
	move $s0, $v0 # Movendo o valor para $s0
	
	li $v0, 4
	la $a0, askPedroOld
	syscall
	
	li $v0, 5
	syscall
	move $s1, $v0
	
	# Se for igual vai para o isEqual
	beq $s0, $s1, isEqual
	slt $t0, $s0, $s1 # É menor?
	
	beq $t0, $zero, isJoaoOlder
	j isPedroOlder # Jump para isPedroOlder
	
end: # Finaliza o programa
	li $v0, 10
	syscall

isJoaoOlder:
	li $v0, 4
	la $a0, joaoIsOlderStr
	syscall 
	j end

isPedroOlder:
	li $v0, 4
	la $a0, pedroIsOlderStr
	syscall 
	j end

isEqual:
	li $v0, 4
	la $a0, areEqualStr
	syscall
	j end
