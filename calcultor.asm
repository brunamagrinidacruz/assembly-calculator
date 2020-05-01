# Bruna Magrini da Cruz, 11218813
# Marlon José Martins 10249010
# Isadora Carolina Siebert 11345580

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
entrada_invalida: .asciiz "Entrada invalida."
entrada_imc_peso: .asciiz "Digite seu peso em kg: "
entrada_imc_altura: .asciiz "Digite sua altura em metro: "
entrada_pot_expoente: .asciiz "Digite o expoente: "

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
	beq $v0, 0, encerrar
	
	jal validar_erro
	j principal
	
#Se $v0 não for igual a nenhum dos valores, a aplicação será encerrada	
encerrar:
	li $v0, 10
	syscall
	
#-------------------------------------Soma-------------------------------------	
soma:
	#Empilhando 
	addi $sp, $sp, -20
	sw $v1, 16($sp)
	sw $v0, 12($sp)
	sw $a2, 8($sp)
	sw $a1, 4($sp)
	sw $a0, 0($sp)

	#Lendo entrada
	jal ler_entrada_dupla
	move $a1, $v0
	move $a2, $v1
		
	#Somando
	add $t3, $a1, $a2
	
	#Imprimindo saida_resultado
	li $v0, 4
	la $a0, saida_resultado 
	syscall 
	
	#Imprimindo resultado da soma
	li $v0, 1 
	move $a0, $t3 
	syscall
	
	#Desempilhando
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	lw $a2, 8($sp)
	lw $v0, 12($sp)
	lw $v1, 16($sp)
	addi $sp, $sp, 20
	
#	addi $v0, $zero, 1	#soma sucesso
	
	j principal

#-------------------------------------Subtração-------------------------------------	
subtracao:
	#Empilhando 
	addi $sp, $sp, -16
	sw $v1, 12($sp)
	sw $v0, 8($sp)
	sw $a1, 4($sp)
	sw $a0, 0($sp)

	#Lendo entrada
	jal ler_entrada_dupla
	move $a0, $v0
	move $a1, $v1
	
	#Subtraindo
	sub $t2, $a0, $a1
	
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

	#Desempilhando
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	lw $v0, 8($sp)
	lw $v1, 12($sp)
	addi $sp, $sp, 16

	j principal

#-------------------------------------Multiplicação-------------------------------------	
multiplicacao:
	#Empilhando 
	addi $sp, $sp, -20
	sw $v1, 16($sp)
	sw $v0, 12($sp)
	sw $a2, 8($sp)
	sw $a1, 4($sp)
	sw $a0, 0($sp)
	
	jal ler_entrada_dupla
	move $a1, $v0
	move $a2, $v1
	
	#Validando se entradas sao menor ou igual maior inteiro de 16 bits
	move $a0, $a1
	jal validar_entrada_16bits
	beq $v0, $zero, principal

	move $a0, $a2
	jal validar_entrada_16bits
	beq $v0, $zero, principal

	#Multiplicando
	mul $t0, $a1, $a2
	
	#Imprimindo texto auxiliar
	li $v0, 4
	la $a0, saida_resultado
	syscall 
	
	#Imprimindo resultado
	li $v0, 1
	move $a0, $t0
	syscall 
	
	#Desempilhando
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	lw $a2, 8($sp)
	lw $v0, 12($sp)
	lw $v1, 16($sp)
	addi $sp, $sp, 20
			
	j principal

#-------------------------------------Divisão-------------------------------------
divisao:
	#Empilhando os registradores utilizados no procedimento
	addi $sp, $sp, -16 
	sw $v0, 12($sp)
	sw $a0, 8($sp)
	sw $a1, 4($sp)
	sw $a2, 0($sp)
	
	#Lendo entrada
	jal ler_entrada_dupla
	move $a1, $v0
	move $a2, $v1
	
	move $a0, $a1
	jal validar_entrada_16bits
	beq $v0, $zero, principal

	move $a0, $a2
	jal validar_entrada_16bits
	beq $v0, $zero, principal
	
	move $a0, $t2
	jal validar_entrada_zero
	beq $v0, $zero, principal
	
	#Dividindo
	div $t3, $a1, $a2
	
	#Imprimindo saida_resultado
	li $v0, 4 
	la $a0, saida_resultado 
	syscall 
	
	#Imprimindo resultado da divisao
	li $v0, 1 
	move $a0, $t3 
	syscall

	#Desempilhando os registradores utilizados no procedimento
	lw $v0, 12($sp)
	lw $a0, 8($sp)
	lw $a1, 4($sp)
	lw $a2, 0($sp)
	addi $sp, $sp, 16
	
	j principal
	
potencia:
	#Empilhando os registradores utilizados no procedimento
	addi $sp, $sp, -16
	sw $v0, 12($sp)
	sw $a2, 8($sp) 
	sw $a1, 4($sp)
	sw $a0, 0($sp)
	
	#Lendo entrada
	li $v0, 4
	la $a0, entrada_unica
	syscall

	li $v0, 5
	syscall
			
	move $a1, $v0
	
	li $v0, 4
	la $a0, entrada_pot_expoente
	syscall
	
	li $v0, 5
	syscall
	
	move $a2, $v0
	
	move $a0, $a2
	jal validar_entrada_negativa
	beq $v0, $zero, principal
	
	move $a0, $a2
	jal validar_entrada_zero_potencia_fatorial
	beq $v0, $zero, principal
	
	addi $t4, $zero, 1	#referencial para a parada do potencia_loop
	add $t3, $zero, $a1	#armazenando o valor de entrada para fazer a multiplicacao da potencia

#loop para fazer a multiplicacao da potencia	
potencia_loop:
	ble $a2, $t4, potencia_endloop	#verifica se ja chegou no final da potenciacao
	
	mul $a1, $a1, $t3	#valor = valor * valor_inicial
	addi $a2, $a2, -1	#contador = contador - 1
	j potencia_loop

potencia_endloop:
	li $v0, 4
	la $a0, saida_resultado
	syscall
	
	li $v0, 1
	move $a0, $a1
	syscall
	
	#Desempilhando os registradores utilizados no procedimento
	lw $v0, 12($sp)
	lw $a2, 8($sp) 
	lw $a1, 4($sp)
	lw $a0, 0($sp)
	addi $sp, $sp, 16
	
	j principal
	
#-------------------------------------Raiz quadrada-------------------------------------
raiz_quadrada:
	#Empilhando os registradores utilizados no procedimento
	addi $sp, $sp, -16
	sw $v0, 12($sp)
	sw $a2, 8($sp) 
	sw $a1, 4($sp)
	sw $a0, 0($sp)
	
	jal ler_entrada_unica
	move $a1, $v0
	
	move $a0, $a1
	jal validar_entrada_negativa
	beq $v0, $zero, principal
		
	#Calculo da raiz quadrada
	li $t2, 1 #Armazenara o resultado
	li $t0, 1 #Contador
	
loop_raiz_quadrada:
	#Se $t2 (armazenador do resultado) for igual ao valor de entrada, finaliza
	beq $a1, $t2, endloop_raiz_quadrada
	#Se $t2 (armazenador do resultado) for maior que o valor de entrada, o resultado deve ser o $t3 anterior
	bgt $t2, $a1, endloop_raiz_quadrada_ultrapassou

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
	 
	#Desempilhando os registradores utilizados no procedimento
	lw $v0, 12($sp)
	lw $a2, 8($sp) 
	lw $a1, 4($sp)
	lw $a0, 0($sp)
	addi $sp, $sp, 16
		
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
	#Empilhando a0
	addi $sp, $sp, -4 
	sw $a0, 0($sp)

	#Lendo entrada
	li $v0, 4
	la $a0, entrada_imc_peso
	syscall
	
	li $v0, 5
	syscall
	
	move $a1, $v0
	
	li $v0, 4
	la $a0, entrada_imc_altura
	syscall
	
	li $v0, 5
	syscall
	
	move $a2, $v0
	
	move $a0, $a1
	jal validar_entrada_negativa
	beq $v0, $zero, principal
	
	move $a0, $a2
	jal validar_entrada_negativa
	beq $v0, $zero, principal
	
	#Efetuando a operanção para obter o imc
	mul $a2, $a2, $a2 	#altura * altura
	div $t2, $a1, $a2	#resultado = peso / (altura * altura)
	
	blt $t2, 17, imc_primeiro_caso	#se resultado < 17 entao imc_primeiro_caso
	blt $t2, 18, imc_segundo_caso
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

	#Desempilhando a0
	lw $a0, 0($sp)
	addi $sp, $sp, 4
	
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
	
	#Desempilhando a0
	lw $a0, 0($sp)
	addi $sp, $sp, 4

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
	
	#Desempilhando a0
	lw $a0, 0($sp)
	addi $sp, $sp, 4

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
	
	#Desempilhando a0
	lw $a0, 0($sp)
	addi $sp, $sp, 4

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
	
	#Desempilhando a0
	lw $a0, 0($sp)
	addi $sp, $sp, 4

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
	
	#Desempilhando a0
	lw $a0, 0($sp)
	addi $sp, $sp, 4

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
	
	#Desempilhando a0
	lw $a0, 0($sp)
	addi $sp, $sp, 4

	j principal

#-------------------------------------Fatorial-------------------------------------
fatorial:
	#Armazenando $v0 e $a0 na pilha
	addi $sp, $sp, -8
	sw $a0, 4($sp)
	sw $v0, 0($sp)	
	
	jal ler_entrada_unica
	move $a1, $v0
	
	move $a0, $a1
	jal validar_entrada_negativa
	beq $v0, $zero, principal
	
	move $a0, $a1
	jal validar_entrada_zero_potencia_fatorial
	beq $v0, $zero, principal
	
	#Será o acumulador do resultado
	addi $t0, $zero, 1
	#Usado como caso de parada
	addi $t2, $zero, 1

loop_fatorial:			
	#Se a quantidade de multiplicacoes (numero do fatorial) for menor ou igual a 1, encerra
	ble $a1, $t2, endloop_fatorial

	#Calculando o novo fatorial
	mul $t0, $t0, $a1	
	#Decrementando o contador
        addi $a1, $a1, -1	
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
	move $a1, $v0
	
	move $a0, $a1
	beq $a0, $zero, imprimir_espaco
	
	jal validar_entrada_negativa
	beq $v0, $zero, principal
	
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
	beq $a1, $t1, fim_fibonacci

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

#-------------------------------------Funções de validação-------------------------------------	
validar_entrada_negativa:
	#Se entrada for maior ou igual a zero, sucesso
	bge $a0, $zero, validar_sucesso
	j validar_erro
	
validar_entrada_zero:
	#Se a entrada for igual a zero, falha
	beq $a0, $zero, validar_erro
	j validar_sucesso

validar_entrada_zero_potencia_fatorial:
	beq $a0, $zero, imprimir_um
	j validar_sucesso

validar_entrada_32bits:
	#possivel maior inteiro de 32 bits = 2147483647
	move $t0, $a0
	addi $t1, $zero, 2147483647
	
	blt $t0, $t1, validar_sucesso	#se entrada < maior inteiro ent�o... 
	j validar_erro

validar_entrada_16bits:
	#possivel maior inteiro de 16 bits = 65535
	move $t0, $a0
	addi $t1, $zero, 65536	#46340 
	
	blt $t0, $t1, validar_sucesso	#se entrada < 65535 entao... 
	j validar_erro
	
####

imprimir_um:	
	#Empilhando 
	addi $sp, $sp, -8
	sw $v0, 4($sp) 
	sw $a0, 0($sp)
	
	#Imprimindo saida_resultado
	li $v0, 4
	la $a0, saida_resultado 
	syscall 
		
	#Imprimindo o valor 1
	li $v0, 1
	li $a0, 1
	syscall

	#Desempilhando
	lw $a0, 0($sp)
	lw $v0, 4($sp)
	addi $sp, $sp, 8
	
	#Retornando 0 para o procedimento em caso de falha (false)
	move $v0, $zero
	jr $ra
	
imprimir_espaco:	
	#Empilhando
	addi $sp, $sp, -8
	sw $v0, 4($sp) 
	sw $a0, 0($sp)
	
	#Imprimindo saida_resultado
	li $v0, 4
	la $a0, espaco
	syscall 
	
	#Desempilhando 
	lw $a0, 0($sp)
	lw $v0, 4($sp)
	addi $sp, $sp, 8
	
	j principal
	
validar_erro:
	#Empilhando
	addi $sp, $sp, -8
	sw $v0, 4($sp) 
	sw $a0, 0($sp)
	
	#Imprimindo que a entrada e invalida
	li $v0, 4
	la $a0, entrada_invalida
	syscall
	
	#Desempilhando 
	lw $a0, 0($sp)
	lw $v0, 4($sp)
	addi $sp, $sp, 8
	
	#Retornando 0 para o procedimento em caso de falha (false)
	move $v0, $zero
	jr $ra
					
validar_sucesso:
	#Retornando 1 para o procedimento em casa de sucesso (true)
	addi $v0, $zero, 1
	jr $ra
