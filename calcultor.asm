	.data
	
	.align 0
menu_inicio: .asciiz "Bem-vindo a calculadora!"
menu_borda: .asciiz "\n-------------------------\n"
menu_selecao: .asciiz "Selecione a operação desejada\n"
menu_operacoes: .asciiz "1 - Soma\n2 - Subtracao\n3 - Multiplicação\n4 - Divisão\n5 - Potencia\n6 - Raiz quadrada\n7 - Tabuada\n8 - IMC\n9 - Fatorial\n10 - Fibonacci\n0 - Encerrrar"
string1: .asciiz "Digite o primeiro valor: "
string2: .asciiz "Digite o segundo valor: "
entrada_unica: .asciiz "Digite o valor: "
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
	addi $sp, $sp, -4 
	sw $a0, 0($sp)
	
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

	lw $a0, 0($sp)
	addi $sp, $sp, 4
	
	j principal
	
subtracao:
	j principal
	
multiplicacao:
	#Armazenando $v0 na pilha
	addi $sp, $sp, -4
	sw $v0, 0($sp)	
	
	#Imprimindo texto auxiliar
	li $v0, 4
	la $a0, string1
	syscall 
	
	#Recebendo primeiro valor e armazenando em $t1
	li $v0, 5
	syscall
	move $t1, $v0
	
	#Imprimindo texto auxiliar 	
	li $v0, 4
	la $a0, string2
	syscall 
	
	#Recebendo segundo valor e armazenando em $t2
	li $v0, 5
	syscall
	move $t2, $v0

	#Multiplicando
	mul $t0, $t1, $t2
	
	#Imprimindo texto auxiliar
	li $v0, 4
	la $a0, string_result
	syscall 
	
	#Imprimindo resultado
	li $v0, 1
	move $a0, $t0
	syscall 
	
	#Retornando o valor de $v0
	lw $v0, 0($sp)
	addi $sp, $sp, 4
			
	j principal
	
divisao:
	# salvando registradores na pilha
	addi $sp, $sp, -4 
	sw $a0, 0($sp)
	
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
	
	div $t3, $t1, $t2
	
	li $v0, 4 # codigo para imprimir string
	la $a0, string_result # imprime string_result
	syscall 
	
	li $v0, 1 # codigo para imprimir inteiro
	move $a0, $t3 # inteiro a ser impresso
	syscall
	
	# desempilha registradores

	lw $a0, 0($sp)
	addi $sp, $sp, 4
	
	j principal
	
potencia:
	j principal
	
raiz_quadrada:
	#Armazenando $v0 na pilha
	addi $sp, $sp, -4
	sw $v0, 0($sp)	
	
	#Imprimindo texto auxiliar
	li $v0, 4
	la $a0, entrada_unica
	syscall 

	#Recebendo o valor a ser calculado e armazenando em $t1
	li $v0, 5
	syscall
	move $t1, $v0
	
	#Calculo da raiz quadrada
	li $t2, 1 #Armazenara o resultado
	li $t0, 1 #Contador
	
loop_raiz_quadrada:
	#Se $t2 (armazenador do resultado) for igual ao valor de entrada, finaliza
	beq $t1, $t2, endloop_raiz_quadrada
	#Se $t2 (armazenador do resultado) for maior que o valor de entrada, o resultado deve ser o $t3 anterior
	bgt $t2, $t1, endloop_raiz_quadrada_ultrapassou

	#Incrementando o contador	
	addi $t3, $t0, 1
	
	#Atualizando resultado para pegar a $t3^2 
	mul $t2, $t0, $t0
	
	j loop_raiz_quadrada
	
endloop_raiz_quadrada_ultrapassou:
	addi $t0, $t0, -1
	
endloop_raiz_quadrada:
	#Imprimindo texto auxiliar
	li $v0, 4
	la $a0, string_result
	syscall 
	
	#Imprimindo resultado
	li $v0, 1
	move $a0, $t0
	syscall
	 
	#Retornando o valor de $v0
	lw $v0, 0($sp)
	addi $sp, $sp, 4
		
	j principal
	
tabuada:
	
	j principal
	
imc:
	j principal
	
fatorial:
	#Armazenando $v0 na pilha
	addi $sp, $sp, -4
	sw $v0, 0($sp)	
	
	#Imprimindo texto auxiliar
	li $v0, 4
	la $a0, entrada_unica
	syscall 

	#Recebendo o valor a ser calculado e armazenando em $t1
	li $v0, 5
	syscall
	move $t1, $v0
	
	#Será o acumulador do resultado
	addi $t0, $zero, 1
	#Usado como caso de parada
	addi $t2, $zero, 1

loop_fatorial:			
	#Se a quantidade de multiplicacoes (numero do fatorial) for menor ou igual a 1, encerra
	ble $t1, $t2, endloop_fatorial

	#Calculando o novo fatorial
	mul $t0, $t0, $t1	
	#Decrementando o contador
        addi $t1, $t1, -1	
   	j loop_fatorial
	
endloop_fatorial:
	#Imprimindo texto auxiliar
	li $v0, 4
	la $a0, string_result
	syscall 
	
	#Imprimindo resultado
	li $v0, 1
	move $a0, $t0
	syscall
	
	#Retornando o valor de $v0
	lw $v0, 0($sp)
	addi $sp, $sp, 4
	
	j principal
	
fibonacci:
	j principal
	
recebe_entrada_unica:
recebe_entrada:
	
