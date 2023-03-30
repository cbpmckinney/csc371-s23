setcursor  .macro
clc 
ldx #\1
ldy #\2
jsr PLOT
.endm 