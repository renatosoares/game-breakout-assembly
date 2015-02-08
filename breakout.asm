# # # # # # # # # # # # # # # # # # # # # # # # #
#  ___    __   _____   __
# | | \  / /\   | |   / /\
# |_|_/ /_/--\  |_|  /_/--\ Segmento
#
# ...onde as "variáveis" são armazenados.
.data

# # # # # # # # # # # # # # # # # # # # # # # # #
# _____  ____  _    _____
#  | |  | |_  \ \_/  | |
#  |_|  |_|__ /_/ \  |_|  segmento
#
# ...lógica do jogo.
.text
main:
li $t0, 8192 		# tamanho da Tela
la $t1, 0x00ffffff 	# Cor
li $t2, 0x10010000 	# Endereço da tela (pixel 0,0)

# salvar no registrador $s0 em diante valores fixos

loop:
	sw $t1, ($t2)
	addi $t2, $t2, 4
	sw $t1, ($t2)
	addi $t0, $t0, -1
	bne $t0, $0, loop