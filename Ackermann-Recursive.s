        # recursive Ackermann program.
        # Written by Ronnie Cole
        
        # The value whose factorial is to be computed is entered by the user
    
        .data
        .align  2
        fprmpt1: .asciiz "Enter the value x for Ackermann function A(x,y): "
        fprmpt2: .asciiz "Enter the value y for Ackermann function A(x,y): "
        fanswr: .asciiz "A(x,y): "
#--------------- Usual stuff at beginning of main -----------------
        .text
       .globl main
main:                               # main has to be a global label
#-------------------------- function body -------------------------
	la	$a0, fprmpt1
	li	$v0, 4
	syscall
	
	li	$v0, 5
	syscall
	move	$t0, $v0
	
	la	$a0, fprmpt2
	li	$v0, 4
	syscall
	
	li	$v0, 5
	syscall
	move	$a1, $v0
	move	$a0, $t0
        jal     Ackermann

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
        # Ackermann function
        #
        # a0 - integer x in A(x,y)
        # a1 - integer y in A(x,y)
        
Ackermann:
#--------------- Usual stuff at function beginning  ---------------
        addi    $sp, $sp, -8       # allocate stack space for 4 values
        sw	$ra, 0($sp)
        sw      $s0, 4($sp)         # store off the return addr, etc 

        
#-------------------------- function body -------------------------	
#--------- if x = 0 -----------------------------------
 	bne 	$a0, $0, jump1	
 	addi	$v0, $a1, 1	    # increment y
 	j	done
#--------- if y = 0 -----------------------------------
jump1:  bne 	$a1, $0, jump2	    # if y = 0, compute A(x-1,1) and finish.
 	addi	$a0, $a0, -1	    # let x-1 be a parameter x of A(x,y)
 	li	$a1, 1		    # let 1 be a parameter y of A(x,y)
 	jal	Ackermann
 	j	done
#--------- otherwise... -----------------------------------
jump2:	# keep x as a parameter of A(x,y)
	move	$s0, $a0
	addi	$a1, $a1, -1	    # let y-1 be a parameter y of A(x,y)
	jal 	Ackermann	            # Compute A(x,y-1)
	addi	$a0, $s0, -1	    # let s3 be a parameter x of A(x,y)
	move	$a1, $v0	    # let A(x,y-1) be a parameter y of A(x,y)
	jal 	Ackermann
	
done:

#-------------------- Usual stuff at function end -----------------
        lw      $ra, 0($sp)         # restore the return address, etc
        lw	$s0, 4($sp)
        addi    $sp, $sp, 8
        jr      $ra                 # return to the calling function
#******************************************************************
