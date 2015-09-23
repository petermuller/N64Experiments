;Beetle Adventure Racing
;New Scoring System

;Redirect subroutine to my code
.org  8014fbb0
jal   80000100
.org  80000100

;Save registers to stack
addi  $K1,$ZERO,0x08
sub   $SP,$SP,$K1
sw    $T0,0($SP)
sw    $A3,4($SP)

;Get score memory address
add   $A3,$ZERO,$ZERO
lui   $A3,0x8036
addi  $A3,$A3,0x3D68

;Load current score
lw    $T0,0x0068($A3)

;New score =
; score*2 if odd, or
; score+1 if even
andi  $K1,$T0,0x01
beq   $K1,$ZERO,even
nop
sll   $T0,$T0,0x01
j     done
nop
even:
addi  $T0,$T0,0x01
done:

;Write new score to game
sw    $T0,0x0068($A3)

;Retrieve regesters from stack
lw    $T0,0x00($SP)
lw    $A3,0x04($SP)
addi  $K1,$ZERO,0x08
add   $SP,$SP,$K1

;End subroutine
jr    $RA
nop