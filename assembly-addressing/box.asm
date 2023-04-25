

.include "kernal.asm"
.include "macros.asm"
.include "io.asm"

.include "wedge.asm"


* = $2000

jsr SCINIT

ldx #1

loop
lda #67
sta $450, x
inx
cpx #39
bne loop 


ldy #0
lda #00
sta $FB
lda #04
sta $FC 


lda #66
sta ($FB), Y





endless
jmp endless