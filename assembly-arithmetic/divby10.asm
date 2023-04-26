.include "wedge.asm"
.include "kernal.asm"
.include "macros.asm"

* = $1000

jsr SCINIT

#setcursor 0,0

lda num1
lsr a 
divbyfive ;assume the number we want to divide by 5 is in the accumulator

lsr a 
lsr a 
sta num2 

lsr a 
lsr a
sta num2+1

lsr a 
lsr a
sta num2+2

lda num2
sec 
sbc num2+1
clc 
adc num2+2

sta quotient
asl a 
sta num3 
asl a 
asl a
sta num3+1
clc 
adc num3
sta num3+2

lda num1
sec 
sbc num3+2
sta remainder

lda remainder 
clc 
adc #$30
sta string

#setcursor 0,0

#printstring <string, >string

rts

num1
.byte $09; 105 in hex

num2
.byte $0, $0, $0

num3 
.byte $0, $0, $0

quotient
.byte $0

remainder 
.byte $0

string 
.null " "

