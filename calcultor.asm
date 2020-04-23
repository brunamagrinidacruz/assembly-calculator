	.data
	.align 0	
string1: .asciiz "Digite o primeiro valor: "
string2: .asciiz "Digite o segundo valor: "
string_result: .asciiz "Resultado: "

	.text
	.globl main
main:

soma:
	# salvando registradores na pilha
	addi $sp, $sp, -16 
	
	sw $t1, 0($sp) 
	sw $t2, 4($sp) 
	sw $t3, 8($sp) 
	sw $a0, 12($sp)
	
	li $v0, 4 # codigo para imprimir string
	la $a0, string1 # imprime string1
	syscall 
	
	li $v0, 5 # le um inteiro fornecido pelo usuario em $v0
	syscall
	
	move $t1, $v0 # transfere o valor de $v0 para $t1
	
	li $v0, 4 # codigo para imprimir string
	la $a0, string2 # imprime string2
	syscall 
	
	li $v0, 5 # le um inteiro fornecido pelo usuario em $v0 
	syscall
	
	move $t2, $v0 # transfere o valor de $v0 para $t2
	
	add $t3, $t1, $t2
	
	li $v0, 4 # codigo para imprimir string
	la $a0, string_result # imprime string_result
	syscall 
	
	li $v0, 1 # codigo para imprimir inteiro
	move $a0, $t3 # inteiro a ser impresso
	syscall
	
	# desempilha registradores

	lw $a0, 12($sp)
	lw $t3, 8($sp)
	lw $t2, 4($sp)
	lw $t1, 0($sp)
	
	addi $sp, $sp, 16
	
divisao:

tabuada:








encerra_programa:
	li $v0, 10
	syscall