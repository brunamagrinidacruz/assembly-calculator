	.data
	
	.align 0

#Menu
menu_inicio: .asciiz "Bem-vindo a calculadora!"
menu_borda: .asciiz "\n-------------------------\n"
menu_selecao: .asciiz "Selecione a operação desejada\n"
menu_operacoes: .asciiz "1 - Soma\n2 - Subtracao\n3 - Multiplicação\n4 - Divisão\n5 - Potencia\n6 - Raiz quadrada\n7 - Tabuada\n8 - IMC\n9 - Fatorial\n10 - Fibonacci\n0 - Encerrrar"

#Entrada
entrada_primeiro: .asciiz "Digite o primeiro valor: "
entrada_segundo: .asciiz "Digite o segundo valor: "
entrada_unica: .asciiz "Digite o valor: "

#Saida
saida_resultado: .asciiz "Resultado: "

#Tabuada
operador_mult_tab: .asciiz " * "
operador_igual: .asciiz " = "

#IMC
imc_str_primeiro_caso: " => Muito abaixo do peso\n"
imc_str_segundo_caso: " => Abaixo do peso\n"
imc_str_terceiro_caso: " => Peso normal\n"
imc_str_quarto_caso: " => Acima do peso\n"
imc_str_quinto_caso: " => Obesidade Grau I\n"
imc_str_sexto_caso: " => Obesidade Grau II\n"
imc_str_setimo_caso: " => Obesidade Grau III\n"

#Outros
pula_linha: .asciiz "\n"
espaco: .asciiz " "

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
	
#-------------------------------------Soma-------------------------------------	
soma:
	#Empilhando $a0
	addi $sp, $sp, -4 
	sw $a0, 0($sp)
	
	#Lendo entrada
	jal ler_entrada_dupla
	move $t1, $v0
	move $t2, $v1
	
	#Somando
	add $t3, $t1, $t2
	
	#Imprimindo saida_resultado
	li $v0, 4
	la $a0, saida_resultado 
	syscall 
	
	#Imprimindo resultado da soma
	li $v0, 1 
	move $a0, $t3 
	syscall
	
	#Desempilhando a0
	lw $a0, 0($sp)
	addi $sp, $sp, 4
	
	j principal

#-------------------------------------Subtração-------------------------------------	
subtracao:
	#Lendo entrada
	jal ler_entrada_dupla
	move $t0, $v0
	move $t1, $v1
	
	#Subtraindo
	sub $t2, $t0, $t1
	
	#Imprimindo o resultado
	li $v0, 4
	la $a0, saida_resultado
	syscall
	
	li $v0, 1
	move $a0, $t2
	syscall
	
	li $v0, 4
	la $a0, pula_linha
	syscall

	j principal

#-------------------------------------Multiplicação-------------------------------------	
multiplicacao:
	#Armazenando $v0 e $a0 na pilha
	addi $sp, $sp, -8
	sw $a0, 4($sp)
	sw $v0, 0($sp)
	
	jal ler_entrada_dupla
	move $t1, $v0
	move $t2, $v1

	#Multiplicando
	mul $t0, $t1, $t2
	
	#Imprimindo texto auxiliar
	li $v0, 4
	la $a0, saida_resultado
	syscall 
	
	#Imprimindo resultado
	li $v0, 1
	move $a0, $t0
	syscall 
	
	#Desempilhando $a0 e $v0
	lw $v0, 0($sp)
	lw $a0, 4($sp)
	addi $sp, $sp, 8
			
	j principal

#-------------------------------------Divisão-------------------------------------
divisao:
	#Empilhando a0
	addi $sp, $sp, -4 
	sw $a0, 0($sp)
	
	#Lendo entrada
	jal ler_entrada_dupla
	move $t1, $v0
	move $t2, $v1
	
	#Dividindo
	div $t3, $t1, $t2
	
	#Imprimindo saida_resultado
	li $v0, 4 
	la $a0, saida_resultado 
	syscall 
	
	#Imprimindo resultado da divisao
	li $v0, 1 
	move $a0, $t3 
	syscall
	
	#Desempilhando a0
	lw $a0, 0($sp)
	addi $sp, $sp, 4
	
	j principal
	
#-------------------------------------Potência-------------------------------------
potencia:
	#Lendo entrada
	jal ler_entrada_dupla
	move $t0, $v0
	move $t1, $v1
	
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
	la $a0, saida_resultado
	syscall
	
	li $v0, 1
	move $a0, $t0
	syscall
	
	li $v0, 4
	la $a0, pula_linha
	syscall

	j principal

#-------------------------------------Raiz quadrada-------------------------------------
raiz_quadrada:
	#Armazenando $v0 e $a0 na pilha
	addi $sp, $sp, -8
	sw $a0, 4($sp)
	sw $v0, 0($sp)
	
	jal ler_entrada_unica
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
	addi $t0, $t0, 1
	
	#Atualizando resultado para pegar a $t3^2 
	mul $t2, $t0, $t0
	
	j loop_raiz_quadrada
	
endloop_raiz_quadrada_ultrapassou:
	addi $t0, $t0, -1
	
endloop_raiz_quadrada:
	#Imprimindo texto auxiliar
	li $v0, 4
	la $a0, saida_resultado
	syscall 
	
	#Imprimindo resultado
	li $v0, 1
	move $a0, $t0
	syscall
	 
	#Desempilhando $a0 e $v0
	lw $v0, 0($sp)
	lw $a0, 4($sp)
	addi $sp, $sp, 8
		
	j principal

#-------------------------------------Tabuada-------------------------------------
tabuada:
	#Empilhando a0
	addi $sp, $sp, -4 
	sw $a0, 0($sp)
	
	#Lendo entrada
	jal ler_entrada_unica
	move $t1, $v0
	
	#Inicializando contador
	li $t2, 0 
	li $t4, 11 
	
loop_tabuada:
	#Verificando se t2 = t4
	beq $t2, $t4, fim_tabuada
	
	#Multiplicando 
	mul $t3, $t1, $t2
	
	#Imprimindo valor contido em t1 
	li $v0, 1 
	move $a0, $t1 
	syscall
	
	#Imprimindo " * "
	li $v0, 4 
	la $a0, operador_mult_tab 
	syscall
	
	#Imprimindo valor contido em $t2
	li $v0, 1 
	move $a0, $t2 
	syscall
	
	#Imprimindo " = "
	li $v0, 4 
	la $a0, operador_igual 
	syscall
	
	#Imprimindo resultado contido em $t3
	li $v0, 1
	move $a0, $t3
	syscall
	
	#Pulando uma linha
	li $v0, 4 
	la $a0, pula_linha 
	syscall
	
	#Incrementando t2
	addi $t2, $t2, 1
	jal loop_tabuada
	
fim_tabuada:
	#Desempilhando a0
	lw $a0, 0($sp)
	addi $sp, $sp, 4
	
	j principal

#-------------------------------------IMC-------------------------------------
imc:
	#Lendo entrada
	jal ler_entrada_dupla
	move $t0, $v0
	move $t1, $v1
	
	#Efetuando a operanção para obter o imc
	mul $t1, $t1, $t1 	#altura * altura
	div $t2, $t0, $t1	#resultado = peso / (altura * altura)
	
	blt $t2, 17, imc_primeiro_caso	#se resultado < 17 entao imc_primeiro_caso
	blt $t2, 19, imc_segundo_caso
	blt $t2, 25, imc_terceiro_caso
	blt $t2, 30, imc_quarto_caso
	blt $t2, 35, imc_quinto_caso
	blt $t2, 40, imc_sexto_caso

imc_setimo_caso:
	#Imprimindo o resultado o imc
	li $v0, 4
	la $a0, saida_resultado
	syscall
	
	li $v0, 1
	move $a0, $t2
	syscall
	
	#Imprimindo a string da situação do imc
	li $v0, 4 
	la $a0, imc_str_setimo_caso
	syscall

	j principal
		
imc_primeiro_caso: 
	li $v0, 4
	la $a0, saida_resultado
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
	la $a0, saida_resultado
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
	la $a0, saida_resultado
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
	la $a0, saida_resultado
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
	la $a0, saida_resultado
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
	la $a0, saida_resultado
	syscall
	
	li $v0, 1
	move $a0, $t2
	syscall
	
	li $v0, 4 
	la $a0, imc_str_sexto_caso
	syscall

	j principal

#-------------------------------------Fatorial-------------------------------------
fatorial:
	#Armazenando $v0 e $a0 na pilha
	addi $sp, $sp, -8
	sw $a0, 4($sp)
	sw $v0, 0($sp)	
	
	jal ler_entrada_unica
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
	la $a0, saida_resultado
	syscall 
	
	#Imprimindo resultado
	li $v0, 1
	move $a0, $t0
	syscall
	
	#Desempilhando $a0 e $v0
	lw $v0, 0($sp)
	lw $a0, 4($sp)
	addi $sp, $sp, 8
	
	j principal

#-------------------------------------Fibonacci-------------------------------------
fibonacci:
	# salva registradores na pilha
	addi $sp, $sp, -4 
	sw $a0, 0($sp)
		
	jal ler_entrada_unica
	move $t0, $v0
	
	li $t1, 2 # contador
	li $t2, 0 
	li $t3, 1 
	li $t4, 0
	
	#Imprimindo o primeiro valor do Fibonacci
	li $v0, 1
	move $a0, $t2
	syscall
	
	#Imprimindo espaco
	li $v0, 4
	la $a0, espaco
	syscall
	
	#Imprimindo o segundo valor do Fibonacci
	li $v0, 1
	move $a0, $t3
	syscall
	
	#Imprimindo espaco
	li $v0, 4
	la $a0, espaco
	syscall
	
	jal loop_fibonacci
	
	# desempilha registradores
	lw $a0, 0($sp)
	addi $sp, $sp, 4
	j principal
	
loop_fibonacci:
	#Se o contador for igual a entrada do usuário, encerra
	beq $t0, $t1, fim_fibonacci

	#Faz o cálculo do Fibonacci
	add $t4, $t2, $t3
	
	#Imprime resultado
	li $v0, 1
	move $a0, $t4
	syscall
	
	#Imprime espaco
	li $v0, 4
	la $a0, espaco
	syscall
	
	#Ajustando a sequencia de Fibonacci
	addi $t2, $t3, 0
	addi $t3, $t4, 0
	addi $t1, $t1, 1
	
	j loop_fibonacci
	
fim_fibonacci:
	jr $ra

#-------------------------------------Funções de leitura-------------------------------------	

#Retorno do primeiro valor: $v0
#Retorno do segundo valor: $v1
ler_entrada_dupla:
	#Empilhando $a0
	addi $sp, $sp, -4 
	sw $a0, 0($sp)
	
	#Imprimindo texto da primeira entrada
	li $v0, 4
	la $a0, entrada_primeiro
	syscall 
	
	#Recebendo primeiro valor e armazenando em $t1
	li $v0, 5
	syscall
	move $t1, $v0
	
	#Imprimindo texto da segunda entrada
	li $v0, 4
	la $a0, entrada_segundo
	syscall 
	
	#Recebendo segundo valor e armazenando em $t2
	li $v0, 5
	syscall
	move $t2, $v0
	
	#Enviando como retorno do procedimento
	move $v0, $t1
	move $v1, $t2
	
	lw $a0, 0($sp)
	addi $sp, $sp, 4
	
	jr $ra
	
#Retorno do valor: $v0
ler_entrada_unica:
	#Empilhando $a0
	addi $sp, $sp, -4 
	sw $a0, 0($sp)
	
	#Imprimindo texto da primeira entrada
	li $v0, 4
	la $a0, entrada_unica
	syscall 
	
	#Recebendo o valor e armazenando em $t1
	li $v0, 5
	syscall
	move $t1, $v0
	
	#Enviando como retorno do procedimento
	move $v0, $t1

	#Desempilhando $a0
	lw $a0, 0($sp)
	addi $sp, $sp, 4
	
	jr $ra
