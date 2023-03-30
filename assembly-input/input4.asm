.include "wedge.asm"
.include "kernal.asm"
.include "macros.asm"


* = $1000

jsr SCINIT

#setcursor 0,0
#printstring <string1,>string1

jsr CHRIN
sta instring1
sec 
sbc #$30
sta num1

#setcursor 1,0
#printstring <string2,>string2

jsr CHRIN
sta instring2
sec 
sbc #$30
sta num2

clc 
adc num1 
sta num3

ldy num3 
lda num3+1
jsr GIVAYF
jsr FOUT
#setcursor 2,0
#printstring $01,$01


rts 


string1
.null "please type number a: "
string2 
.null "please type number b: "

instring1
.null " "
instring2
.null " "

num1
.byte $0, $0
num2
.byte $0, $0
num3 
.byte $0, $0