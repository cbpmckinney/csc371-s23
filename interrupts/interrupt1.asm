; Interrupt demonstration #1: CIA timer interrupt

* = $1000

init
jsr $ff81       ;clear screen
sei             ;disable interrupts to get stuff set up
lda $0314       ;store old interrupt vector
sta oldaddr
lda $0315
sta oldaddr+1
lda <irq
sta $0314
lda >irq 
sta $0315
lda #2
sta $d021
cli             ;clear interrupt flag

ldx $0
ldy $0
clc
jsr $fff0

main

jsr $ffe4
beq main 
sec 
sbc #$40
sta $400,x
inx  
jmp main    ;endless loop


exit
lda oldaddr
sta $0314
lda oldaddr+1
sta $0315
rts


irq     ;interrupt handler
pha
txa
pha
tya
pha

jsr $ffe4   ;jump to KERNAL routine
;beq stop 
clc 
ldx #0
ldy #0
jsr $fff0
sec 
sbc #$40
sta $400

;jsr $ffd2

jmp finish 

stop
jsr exit 

finish
pla
tay 
pla
tax 
pla 
rti

oldaddr 
.word $0
