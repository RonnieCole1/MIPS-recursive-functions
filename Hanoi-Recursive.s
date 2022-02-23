        # recursive Hanoi program.
        # Written by Ronnie Cole
        
        # The value in that is used by the Hanoi function is entered by the user.
    
        .data
        .align  2
        fprmpt: .asciiz "Enter the value to compute Hanoi(n): "
        fanswr: .asciiz "Hanoi(n) is: "
#--------------- Usual stuff at beginning of main -----------------
        .text
       .globl main
main:                               # main has to be a global label
#-------------------------- function body -------------------------
#------ Get integer input from the user
        li      $v0, 51              
        la      $a0 fprmpt
        syscall

        # a0 already has n
        jal     Hanoi

        #------ Display results
        move    $a1, $v0 
        la      $a0, fanswr           
        li      $v0, 56
        syscall

#----------------- Usual stuff at end of main ---------------------
        li      $v0, 10,
        syscall
#******************************************************************


#******************************************************************
        # Hanoi function
        #
        # a0 - integer value which is pluged into our Hanoi function
        
Hanoi:
#--------------- Usual stuff at function beginning  ---------------
        addi    $sp, $sp, -8        # allocate stack space for 2 values
        sw      $ra, 0($sp)         # store off the return addr, etc 
        sw      $s0, 4($sp)
        
#-------------------------- function body -------------------------
        move    $s0, $a0            # s0: set to n
        li      $t1, 1              # t1: set to 1 for base case test

        #------ base case exit
        ble     $s0, 1, done        # if base case (n == 1): t1 has result
        
        # make the recursive call
        addi    $a0, $s0, -1        # compute (h_k-1)
        jal     Hanoi
        sll	$v0, $v0, 1	    # compute 2(h_k-1)
        addi    $t1, $v0, 1         # t1 = 2(h_k-1) + 1
         
        #------ Put result in v0 and go home
done:   move    $v0, $t1

#-------------------- Usual stuff at function end -----------------
        lw      $ra, 0($sp)         # restore the return address, etc
        lw      $s0, 4($sp)
        addi    $sp, $sp, 8
        jr      $ra                 # return to the calling function
#******************************************************************
