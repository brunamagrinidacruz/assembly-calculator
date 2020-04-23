	.data
	.align 0
	
#strings gerais
menu_inicio: .asciiz "Bem-vindo a calculadora!\n"
menu_borda: .asciiz "-------------------------\n"
menu_selecao: .asciiz "Selecione a operação desejada\n"
menu_operacoes: .asciiz "1 - Soma\n2 - Subtracao\n3 - Multiplicação\n4 - Divisão\n5 - Potencia\n6 - Raiz quadrada\n7 - Tabuada\n8 - IMC\n9 - Fatorial\n10 - Fibonacci\n0 - Encerrrar\n"
quebra_linha: .asciiz "\n"
resultado: .asciiz "Resultado: "

#strings para subtracao
sub_primeiro_valor: .asciiz "Digite o primeiro valor: "
sub_segundo_valor: .asciiz "Digite o segundo valor: "

#strings para potencia
pot_valor: .asciiz "Digite um numero: "
pot_valor_expoente: .asciiz "Digite o expoente: "

#strings imc
imc_peso: "Digite o peso: "
imc_altura: "Digite a altura: "
imc_str_primeiro_caso: " => Muito abaixo do peso\n"
imc_str_segundo_caso: " => Abaixo do peso\n"
imc_str_terceiro_caso: " => Peso normal\n"
imc_str_quarto_caso: " => Acima do peso\n"
imc_str_quinto_caso: " => Obesidade Grau I\n"
imc_str_sexto_caso: " => Obesidade Grau II\n"
imc_str_setimo_caso: " => Obesidade Grau III\n"

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
	j principal
	
subtracao:
	li $v0, 4
	la $a0, sub_primeiro_valor
	syscall
	
	li $v0, 5
	syscall
	
	move $t0, $v0
	
	li $v0, 4
	la $a0, sub_segundo_valor
	syscall
	
	li  $v0, 5
	syscall
	
	move $t1, $v0
	
	sub $t2, $t0, $t1
	
	li $v0, 4
	la $a0, resultado
	syscall
	
	li $v0, 1
	move $a0, $t2
	syscall
	
	li $v0, 4
	la $a0, quebra_linha
	syscall

	j principal
	
multiplicacao:
	j principal
	
divisao:
	j principal
	
potencia:
	li $v0, 4
	la $a0, pot_valor
	syscall
	
	li $v0, 5
	syscall
	
	move $t0, $v0
	
	li $v0, 4
	la $a0, pot_valor_expoente
	syscall
	
	li $v0, 5
	syscall
	
	move $t1, $v0
	
	addi $t4, $zero, 1	#referencial para a parada do potencia_loop
	add $t3, $zero, $t0	#armazenando o valor de entrada para fazer a multiplicacao da potencia

#loop para fazer a multiplicacao da potencia	
potencia_loop:
	ble $t1, $t4, potencia_endloop	#verifica se ja chegou no final da potenciacao
	
	mul $t0, $t0, $t3	#valor = valor * valor_inicial
	addi $t1, $t1, -1	#contador = contador - 1
	j potencia_loop

potencia_endloop:
	li $v0, 4
	la $a0, resultado
	syscall
	
	li $v0, 1
	move $a0, $t0
	syscall
	
	li $v0, 4
	la $a0, quebra_linha
	syscall

	j principal
	
raiz_quadrada:
	j principal
	
tabuada:
	j principal
	
imc:
	li $v0, 4
	la $a0, imc_peso
	syscall
	
	li $v0, 5
	syscall
	
	move $t0, $v0
	
	li $v0, 4
	la $a0, imc_altura
	syscall
	
	li $v0, 5
	syscall
	
	move $t1, $v0
	
	mul $t1, $t1 $t1 	#altura * altura
	div $t2, $t0, $t1	#resultado = peso / (altura * altura)
	
	blt $t2, 17, imc_primeiro_caso	#se resultado < 17 entao imc_primeiro_caso
	blt $t2, 19, imc_segundo_caso
	blt $t2, 25, imc_terceiro_caso
	blt $t2, 30, imc_quarto_caso
	blt $t2, 35, imc_quinto_caso
	blt $t2, 40, imc_sexto_caso

imc_setimo_caso: 
	li $v0, 4
	la $a0, resultado
	syscall
	
	li $v0, 1
	move $a0, $t2
	syscall
	
	li $v0, 4 
	la $a0, imc_str_setimo_caso
	syscall

	j principal
		
imc_primeiro_caso: 
	li $v0, 4
	la $a0, resultado
	syscall
	
	li $v0, 1
	move $a0, $t2
	syscall
	
	li $v0, 4 
	la $a0, imc_str_primeiro_caso
	syscall

	j principal

imc_segundo_caso: 
	li $v0, 4
	la $a0, resultado
	syscall
	
	li $v0, 1
	move $a0, $t2
	syscall
	
	li $v0, 4 
	la $a0, imc_str_segundo_caso
	syscall

	j principal
		
imc_terceiro_caso: 
	li $v0, 4
	la $a0, resultado
	syscall
	
	li $v0, 1
	move $a0, $t2
	syscall
	
	li $v0, 4 
	la $a0, imc_str_terceiro_caso
	syscall

	j principal
	
imc_quarto_caso: 
	li $v0, 4
	la $a0, resultado
	syscall
	
	li $v0, 1
	move $a0, $t2
	syscall
	
	li $v0, 4 
	la $a0, imc_str_quarto_caso
	syscall

	j principal
	
imc_quinto_caso: 
	li $v0, 4
	la $a0, resultado
	syscall
	
	li $v0, 1
	move $a0, $t2
	syscall
	
	li $v0, 4 
	la $a0, imc_str_quinto_caso
	syscall

	j principal
	
imc_sexto_caso: 
	li $v0, 4
	la $a0, resultado
	syscall
	
	li $v0, 1
	move $a0, $t2
	syscall
	
	li $v0, 4 
	la $a0, imc_str_sexto_caso
	syscall

	j principal

fatorial:
	j principal
	
fibonacci:
	j principal
	
