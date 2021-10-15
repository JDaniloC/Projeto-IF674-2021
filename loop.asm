# int a = ? [valor entre 0,100]
# int b = ? [valor entre 0,100]
# if (a == 0) {
# 	STORE b;
# } else {
# 	while (b != 0) {
# 		if (a > b) {
# 			a = a - b
# 		} else {
# 			b = b - a
# 		}
# 	}
# 	STORE a;
# }

.data
	askFirstTxt: .asciiz "Digite o primeiro valor: "
	askSecondTxt: .asciiz "Digite o segundo valor: "
	storedValue: .word 0

.text
	jal askFirstInput
	move $s0, $v0
	
	jal askSecondInput
	move $s1, $v0
	
	beq $s0, $zero, aIsZero
	bne $s1, $zero, bIsNotZero
	sw $s0, storedValue
	j end
	
aIsZero:
	sw $s1, storedValue
	j end	

bIsNotZero:
	sle $t0, $s0, $s1
	beq $t0, $zero, decreaseA
	j decreaseB

decreaseA:
	sub $s0, $s0, $s1
	bne $s1, $zero, bIsNotZero
	j storeA

decreaseB:
	sub $s1, $s1, $s0
	bne $s1, $zero, bIsNotZero

storeA:
	sw $s0, storedValue
	j end

askFirstInput:
	li $v0, 4
	la $a0, askFirstTxt
	syscall
	
	j askValue

askSecondInput:
	li $v0, 4
	la $a0, askSecondTxt
	syscall

askValue:
	li $v0, 5
	syscall
	jr $ra

end:
	li $v0, 10
	syscall
