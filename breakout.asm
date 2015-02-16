# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#  ___    __   _____   __
# | | \  / /\   | |   / /\
# |_|_/ /_/--\  |_|  /_/--\ Segmento
#
# ...onde as "variáveis" são armazenados.
.data

# A tela é uma matriz 128x64 -> CxL

# 00C54849 vermelho
# 00C66C3A laranja
# 00B47A30 amarelo queimado
# 00A2A22A amarelo
# 0048A048 verde
# 004248C8 azul

# reservando memória
# O espaço da linha na memória é reservado quando multiplicamos
# o valor da coluna por quatro (4 * 128)
linha_00:	.space 512	#vermelho
linha_01:	.space 512	#vermelho
linha_02:	.space 512	#laranja
linha_03:	.space 512	#laranja
linha_04:	.space 512	#amarelo queimado
linha_05:	.space 512	#amarelo queimado
linha_06:	.space 512	#amarelo
linha_07:	.space 512	#amarelo
linha_08:	.space 512	#verde
linha_09:	.space 512	#verde
linha_10:	.space 512	#azul
linha_11:	.space 512	#azul

#------------------------------------------------------------------------

qtdColunas:		.word	128	# constante de coluna
qtdLinhas:		.word 	64	# constante de linhas
qtdElemMatriz:		.word	8192	# quantidade de elementos da matriz

#----- Armazenando cores
vermelho:		.word	0x00C54849
laranja:		.word 	0x00C66C3A
amareloqueimado:	.word	0x00B47A30
amarelo:		.word	0x00A2A22A 
verde:			.word	0x0048A048
azul:			.word	0x004248C8

# 00B47A30 amarelo queimado
# 00A2A22A amarelo
# 0048A048 verde
# 004248C8 azul

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# _____  ____  _    _____
#  | |  | |_  \ \_/  | |
#  |_|  |_|__ /_/ \  |_|  segmento
#
# ...lógica do jogo.
.text
main:

# carrega o endereço do inicio da matriz da tela
lui	$at, 0x1001
add	$s0, $zero, $at

# carrega o endereço a quantidade de colunas
lui	$at, 0x1001
addi 	$s1, $at, 0x1800

# carrega o endereço da quantidade de linhas
lui	$at, 0x1001
addi 	$s2, $at, 0x1804

# carregue endereço da quantidade de elementos da matriz
lui	$at, 0x1001
addi	$s3, $at, 0x1808

lw	$t0, 0($s3)	# carregue a quantidade de elementos da matriz
# carregue cor vermelha
lui 	$at, 0x1001
addi 	$s4, $at, 0x180C
lw	$t1, 0($s4)

lw 	$t2, 0($s1) 	# carrega a quantidade de linhas

# valores a ser decrementados no loop
addi 	$t9, $zero, 2	# a cada duas linha uma cor
addi	$t8, $zero, 6	# serão queimadas 6 cores

######## preenche duas linhas############################################	
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

#loop que insere valores na memória -------------------------------------
	loopAdd:
			#adiciona cor ao pixel
		sw	$t1, 0($s0)
		addi	$s0, $s0, 4

		addi	$t2, $t2, -1
		bgtz	$t2, loopAdd	# Se maior que zero vá para repetição
		
		#queima a segunda linha
		addi	$t9, $t9, -1
		lw 	$t2, 0($s1) 	# carrega a quantidade de linhas
		bgtz	$t9, loopAdd
		#queima as cores
		addi	$t8, $t8, -1
		addi	$t9, $t9, 2
		lw 	$t2, 0($s1)	
		addi 	$s4, $s4, 4
		lw	$t1, 0($s4)
		
		bgtz	$t8, loopAdd
		

###################================================================================
# zera registradores
add 	$t7, $zero, $zero
add 	$t8, $zero, $zero
add 	$t9, $zero, $zero

addi	$t8, $zero, 1	# segura o loop para verificar tecla

# carrega o endereço do inicio da matriz da tela
lui	$at, 0x1001
add	$s0, $zero, $at


# carregue cor amarela
lui 	$at, 0x1001
addi 	$s4, $at, 0x180C
addi 	$s4, $s4, 8
lw	$t1, 0($s4)



#### Loop que verifica teclado ##########################################	
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
	loopVerifica:
		lui 	$at, 0xFFFF
		addi 	$s5, $at, 0x0004
		lw	$t7, 0($s5)
		
		beq	$t7, 106, deslocaEsquerda
		beq	$t7, 108, deslocaDireita
		beq	$t7, 101, fim
		j	continue
		deslocaEsquerda:
						#adiciona cor ao pixel
			sw	$t1, 0($s0)		#!!!!!!!! BUG
			addi	$s0, $s0, -4			 
		deslocaDireita:
			sw	$t1, 0($s0)
			addi	$s0, $s0, 4
			
		 
		continue:
		sw	$zero, 0($s5)
		add	$t7, $zero, $zero
		bgtz	$t8, loopVerifica


#### Finaliza ###########################################################	
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

fim:
	addi	$v0, $zero, 10
	syscall


	
