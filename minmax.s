# minmax.s
# 
# Program to print out min and max number based on input
# input requries 10 2-digit positive integers separated by whitespace
# Assume inputs are always well formatted
# outputs both min and max separated by whitespace
# Valid input is always assumed 

    .data
array: .space 40
prompt:     .asciiz "Enter 10 positive 2-digit integers separated by whitespace"
point: .asciiz "."
  
colon: .asciiz ":"
nextline: .asciiz "\n"
spacing: .asciiz ","
INPUT: .asciiz "Input:"
SUM: .asciiz "Sum:"
AVERAGE: .asciiz "Average:"
Max: .asciiz "Max:"
Min: .asciiz "Min:"

    .text
main:   addi $t0, $t0, 40   # Create space for Array
        addi $t4, $t4, 90  # Loop counter
        addi $t9, $t9, 1    # Input Counter
        addi $s5, $s5, 10

        li $v0,4            # syscall 4 (print_str)
        la $a0, prompt
        syscall
        
        li $v0,4
        la $a0, nextline
        syscall

input:  beq $t1, $t0, continue
        move $a0,$t9
        li $v0, 1           # syscall 1 (print_int)
        syscall      

        li $v0, 4
        la $a0,colon
        syscall       

        li $v0, 5           # syscall 5 (read_int)
        syscall
        move $t2, $v0

        sw $t2, array($t1)
        addi $t1, $t1, 4
        addi $t9, $t9, 1    # update the input counter

        j input

continue:   move $t1, $zero
            move $t2, $zero
            addi $t2, $t2, 4
            move $s0, $zero
            addi $s0, $s0, 1    # condition check

sorting:    beq $t3, $t4, calculation
            beq $t2, $t0, continue
            lw $t5, array($t1)
            lw $t6, array($t2)
            addi $t3, $t3, 1
            slt $t7, $t5, $t6
            beq $t7, $s0, rearrange

            addi $t1, $t1, 4
            addi $t2, $t2, 40

            j sorting

rearrange:  sw $t5, array($t2)
            sw $t6, array($t1)
            addi $t1, $t1, 4
            addi $t2, $t2, 4

            j sorting

calculation:    move $t1, $zero
                move $t2, $zero
                move $t3, $zero
                move $t4, $zero
                addi $t4, $t4, 36
                move $t5, $zero
                move $t6, $zero
                move $t7, $zero  


total:  beq $t1, $t0, average
        lw $t2, array($t1)
        addi $t1, $t1, 4
        add $s1, $s1, $t2

        j total

average:    div $s1, $s5
            mfhi $s2
            mflo $s3

output:     li $v0, 4
            la $a0, nextline
            syscall

            lw $t5, array($t3)
            lw $t6, array($t4)

            li $v0,4
            la $a0, INPUT
            syscall

element:    beq $t7, $t0, next
            lw $t8, array($t7)
            addi $t7, $t7, 4
            move $a0, $t8
            li $v0, 1
            syscall

            beq $t7, $t0, element

            li $v0, 4 
            la $a0, spacing
            syscall

            j element

next:   li $v0, 4
        la $a0, nextline
        syscall

        li $v0, 4
        la $a0, SUM
        syscall

        move $a0, $s1
        li $v0, 1
        syscall

        li $v0, 4
        la $a0, nextline
        syscall

        li $v0, 4
        la $a0, AVERAGE
        syscall

        move $a0, $s3
        li $v0, 1
        syscall
        li $v0, 4
        la $a0, point
        syscall

        move $a0, $s2
        li $v0, 1
        syscall

        li $v0, 4
        la $a0, nextline
        syscall

        li $v0, 4
        la $a0, minValue
        syscall

        move $a0, $t6
        li $v0, 1
        syscall

        li $v0, 4
        la $a0,nextline
        syscall

        li $v0, 4
        la $a0,maxValue
        syscall

        move $a0, $t5
        li $v0, 1
        syscall

