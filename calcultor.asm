	.data
	.align 0
menu_inicio: .asciiz "Bem-vindo a calculadora!"
menu_borda: .asciiz "\n-------------------------\n"
menu_selecao: .asciiz "Selecione a operação desejada\n"
menu_operacoes: .asciiz "1 - Soma\n2 - Subtracao\n3 - Multiplicação\n4 - Divisão\n5 - Potencia\n6 - Raiz quadrada\n7 - Tabuada\n8 - IMC\n9 - Fatorial\n10 - Fibonacci\n0 - Encerrrar\n"
string1: .asciiz "Digite o primeiro valor: "
string2: .asciiz "Digite o segundo valor: "
string_result: .asciiz "Resultado: "

	.text
	.globl main
	
main:
	#Imprimindo mensagem de boas-vindas
	li $v0, 4 
	la $a0, menu_inicio
	syscall
	
principal:
	#Imprimindo menu
	li $v0, 4 
	la $a0, menu_borda
	syscall
	
	li $v0, 4
	la $a0, menu_selecao
	syscall
	
	li $v0, 4
	la $a0, menu_operacoes
	syscall
	
	li $v0, 4
	la $a0, menu_borda
	syscall
	
	#Recebendo a operação
	li $v0, 5
	syscall
	
	#Chamando a operação
	beq $v0, 1, soma
	
	beq $v0, 2, subtracao
	
	beq $v0, 3, multiplicacao
	
	beq $v0, 4, divisao
	
	beq $v0, 5, potencia
	
	beq $v0, 6, raiz_quadrada
	
	beq $v0, 7, tabuada
	
	beq $v0, 8, imc
	
	beq $v0, 9, fatorial

	beq $v0, 10, fibonacci
	
#Se $v0 não for igual a nenhum dos valores, a aplicação será encerrada	
encerrar:
	li $v0, 10
	syscall
	
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
	j principal
	
subtracao:
	j principal
	
multiplicacao:
	j principal
	
divisao:
	j principal
	
potencia:
	j principal
	
raiz_quadrada:
	j principal
	
tabuada:
	j principal
	
imc:
	j principal
	
fatorial:
	j principal
	
fibonacci:
	j principal
