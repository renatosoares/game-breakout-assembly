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

vermelho:		.word	0x00C54849
laranja:		.word 	0x00C66C3A

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# _____  ____  _    _____
#  | |  | |_  \ \_/  | |
#  |_|  |_|__ /_/ \  |_|  segmento
#
# ...lógica do jogo.
.text
main:

# carrega o endereço do inicio do array
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
addi 	$t1, $at, 0x180C
lw	$t1, 0($s3)

#loop que insere valores na memória -------------------------------------
	loopAdd:
			#adiciona cor ao pixel
		

		sw	$t1, 0($s0)#!!!!!!!! o problema esta aqui, gravando valores errados na memoria
		addi	$s0, $s0, 4

		addi	$s3, $s3, -1
		bgtz	$s3, loopAdd	# Se maior que zero vá para repetição

###################================================================================


####base preenche duas linhas############################################
#li $t0, 256		# tamanho de duas linhas
#la $t1, 0x00C54849	# Cor primeira cor vermelho
#li $t2, 0x10010000 	# Endereço da tela (pixel 0,0)

# salvar no registrador $s0 em diante valores fixos

#addi 	$t0, $t0, -1	# Sempre é o valor da linha -1

#loop:
#	sw $t1, ($t2)
#	addi $t2, $t2, 4
#	sw $t1, ($t2)
#	addi $t0, $t0, -1
#	bgtz $t0, loop
####base preenche duas linhas############################################	
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
	