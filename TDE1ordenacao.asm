#TDE 1 Ciberfisicos

# Fabio Spiller
# Lucas Gabriel
# Vinicius Wamser

# Programaa de ordenamento

.data # dados
lista: .word 4, 3, 9, 5, 2, 1 
tamanho: .word 6

# t 'temporario' para varieaveis que podem ser perdidas
# s 'saved' para variaveis que não podem ser perdidas
# a 'arguments' onde syscall olha as instruções do que fazer e onde buscar (caixa de entrada)
# v 'valor retornado' após a sub-rotina ela entrega o que foi solicitado (caixa de saida ou ramal de uma chamada especifica)
# la $t0, casaAzul - 'load adress' acha o endereço e carrega dentro do espaço especificado (qual o endereço da casaAzul? Guarda o endereço em $t0. Você não está entrando na casa!!!!)
# lw $t1, ($t0) - 'load word' pega o endereço que está em $t0 e ve o que tem dentro (O que tem dentro da casaAzul($t0)? Guarda a info do que tem dentro em $t1 )
# li $t0, 123 - 'load imediato' apenas carrega o numero diretamente no local
# addi $t1, $t1, 4 - destino, fonte, valor (pegue o que está na fonte, some 4, e guarde no destino)

.text #instruções, funções, etccc
.globl main # aponta onde começar VVV
main:
	 la   $t0, lista          
    lw   $t1, tamanho
    addi $t2, $t1, -1        # Preparando o contador para o loop externo

# while
loop_externo:
    # Prepara as variáveis para o loop interno
    move $t3, $t0            
    li   $t4, 0              
#  while 
loop_interno:
    # ($t4) for >= ($t2), saia.
    bge  $t4, $t2, fim_loop_interno

    lw   $t5, 0($t3)         
    lw   $t6, 4($t3)         
   #if
    ble  $t5, $t6, continua_interno   #se $t5 <= $t6, pule a troca.

    #   se o 'if' for ture
troca:
    sw   $t6, 0($t3)         # Salva o valor menor na posição atual
    sw   $t5, 4($t3)         # Salva o valor maior na posição seguinte

continua_interno:

    addi $t3, $t3, 4         
    addi $t4, $t4, 1         
    j    loop_interno        

fim_loop_interno:
   
    addi $t2, $t2, -1
    bnez $t2, loop_externo   # se $t2 != 0, repita o loop externo



imprimir_lista:

    la   $t0, lista
    li   $t1, 0
    lw   $s1, tamanho

imprimir_loop:
    beq  $t1, $s1, fim
    lw   $a0, 0($t0)
    li   $v0, 1
    syscall
    addi $t0, $t0, 4
    addi $t1, $t1, 1
    j    imprimir_loop

fim:
    li   $v0, 10
    syscall