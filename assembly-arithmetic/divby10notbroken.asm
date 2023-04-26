.include "wedge.asm"
.include "kernal.asm"
.include "macros.asm"

* = $1000

jsr SCINIT

#setcursor 0,0

lda num1
sta remainder 
lda #0 
sta quotient

ldx #0
divloop
lda remainder
sec 
sbc #$0a
bmi subend
sta remainder
inc quotient
jmp divloop
subend
lda remainder
clc 
adc #$30
sta string, x
lda quotient
cmp #0
beq divend
sta remainder
lda #0
sta quotient
inx 
jmp divloop
divend 


ldy #0 ;use x to offset the first string, y for the second
reversestring
;don't forget to write a null terminator!



#setcursor 0,0

#printstring <string2, >string2

rts

num1
.byte $7f; 105 in hex

quotient
.byte $0

remainder 
.byte $0

string 
.null "   "

string2
.null "   "

numten .byte $0a
