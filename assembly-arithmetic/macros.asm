setcursor  .macro
clc 
ldx #\1
ldy #\2
jsr PLOT
.endm

printstring .macro
lda #\1
ldy #\2
jsr PRINTNULL
.endm