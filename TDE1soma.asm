.data
anos:      .word 1994, 1995, 2005, 2006
tamanho:   .word 4

.text
.globl main
main:
    la   $t0, anos
    lw   $t1, tamanho
    li   $t2, 0
    li   $s0, 0

loop_soma:
    beq  $t2, $t1, imprimir_resultado

    lw   $t3, 0($t0)
    add  $s0, $s0, $t3

    addi $t0, $t0, 4
    addi $t2, $t2, 1
    j    loop_soma

imprimir_resultado:
    move $a0, $s0
    li   $v0, 1
    syscall

fim:
    li   $v0, 10
    syscall
