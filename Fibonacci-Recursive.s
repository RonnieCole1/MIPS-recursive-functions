        # recursive fibonacci program.
        # Written by Mikey G and Ronnie Cole
        
        # The value whose fibonacci is to be computed is entered by the user
    
        .data
        .align  2
        fprmpt: .asciiz "Enter the value to compute fibonacci (n): "
        fanswr: .asciiz "fibonacci (n) is: "
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
        jal     fibonacci

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
        # fibonacci function
        #
        # a0 - integer value whose fibonacci is to be computed (n)
        
fibonacci:
#--------------- Usual stuff at function beginning  ---------------
        addi    $sp, $sp, -16       # allocate stack space for 4 values
        sw      $ra, 0($sp)         # store off the return addr, etc 
        sw      $s0, 4($sp)
        sw      $s1, 8($sp)
        sw      $s2, 12($sp)
        
#-------------------------- function body -------------------------
 	move    $s0, $a0            # s0: set to n
        li      $t1, 1              # t1: set to 1 for base case test

        #------ base case exit
	ble	$s0, 0, done	    # if base case (n == 0): t1 has result
        ble     $s0, 1, done        # if base case (n == 1): t1 has result
        
        # make the recursive call
        addi	$a0, $s0, -1	    # compute (F_k-1)
        jal     fibonacci
        move	$s1, $v0	    # store result of (F_k-1) in $s1
        addi	$a0, $s0, -2	    # compute (F_k-2)
        jal     fibonacci
        move	$s2, $v0	    # store result of (F_k-2) in $s2
        sll	$s2, $s2, 2	    # compute 4(F_k-2)
        add     $t1, $s1, $s2       # t1 = (F_k-1) + 4(F_k-2)
        
        #------ Put result in v0 and go home if t1 has result
done: move    $v0, $t1


#-------------------- Usual stuff at function end -----------------
        lw      $ra, 0($sp)         # restore the return address, etc
        lw      $s0, 4($sp)
        lw      $s1, 8($sp)
        lw      $s2, 12($sp)
        addi    $sp, $sp, 16
        jr      $ra                 # return to the calling function
#******************************************************************
