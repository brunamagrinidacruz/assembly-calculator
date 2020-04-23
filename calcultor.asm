	.data
	.align 0
menu_inicio: .asciiz "Bem-vindo a calculadora!\n"
menu_borda: .asciiz "-------------------------\n"
menu_selecao: .asciiz "Selecione a operação desejada\n"
menu_operacoes: .asciiz "Soma: 1\nSubtracao: 2\nMultiplicação: 3\nDivisão: 4\nPotencia: 5\nRaiz quadrada: 6\nTabuada: 7\nIMC: 8\nFatorial: 9\nFibonacci: 10\nEncerrrar: 0\n"

	.text
	.globl main
main:
	li $v0, 4 
	la $a0, menu_inicio
	syscall
	
menu:
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
	
	