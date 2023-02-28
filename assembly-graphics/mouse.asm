; dancing mouse translated to assembly
; based on Dancing Mouse example from C64
; Programmer's reference manual, page 167b

; Define labels

S = $D400 ;$D400 is start of SID chip registers
V = $D000 ;$D000 is start of VIC-II chip registers
GA = $3000 ;Location of first sprite art
GB = $3040 ;Location of second sprite art
GC = $3080 ;Location of third sprite art
SD = $0900 ;Location of sprite data list
CHROUT = $FFD2 ;Location of KERNAL charout routine


* = $0900

.byte 30,0,120,63,0,252,127,129,254,127,129,254,127,189,254,127,255,254
.byte 63,255,252,31,187,248,3,187,192,1,255,128,3,189,192,1,231,128,1
.byte 255,0,31,255,0,0,124,0,0,254,0,1,199,32,3,131,224,7,1,192,1,192,0
.byte 3,192,0,30,0,120,63,0,252,127,129,254,127,129,254,127,189,254,127
.byte 255,254,63,255,252,31,221,248,3,221,192,1,255,128,3,255,192,1,195
.byte 128,1,231,3,31,255,255,0,124,0,0,254,0,1,199,0,7,1,128,7,0,204,1
.byte 128,124,7,128,56,30,0,120,63,0,252,127,129,254,127,129,254,127,189
.byte 254,127,255,254,63,255,252,31,221,248,3,221,192,1,255,134,3,189
.byte 204,1,199,152,1,255,48,1,255,224,1,252,0,3,254,0
.byte 7,14,0,204,14,0,248,56,0,112,112,0,0,60,0,255

* = $1000

; Line 5

lda #$0f
sta S+24
lda #220
sta S
lda #68
sta S+1
lda #15
sta S+5
lda #215
sta S+6

; Line 10

lda #120
sta S+7
lda #100
sta S+8
lda #15
sta S+12
lda #215
sta S+13

; Line 15 

lda #$93   ;$93 is character for "clear"
jsr CHROUT ;equivalent to print"{clr}"
lda #1
sta V+21

; Line 20

ldx #00

line20loop  lda SD,x
sta GA,x
inx
cpx #64 ; copy 63 bytes
bne line20loop

; Line 25
ldx #00
ldy #63

line25loop  lda SD,y
sta GB,x
iny
inx
cpx #64
bne line25loop

; Line 30

ldx #00
ldy #126

line30loop  lda SD,y
sta GC, x
iny
inx
cpx #64
bne line30loop

; Line 35

lda #15
sta V+39
lda #68
sta V+1

; Line 45
; Uses zero page $FB for the variable P
lda #192
sta $FB

; Line 50
ldx #$00 ; set up loop counter
ldy #$00

; Use zero page $FC and $FD for x coordinate.  $FC is lower byte
line50loop  
stx $FC
sty $FD
stx V       ; store lower byte of x coordinate
lda V+16    ; get higher order byte
ora $FD     ; bitwise or
sta V+16    ; stores high order byte

check192    
lda $FB
cmp #192
beq gotoline200
jmp check193
gotoline200 
jsr line200
jmp endloop
check193
cmp #192
beq gotoline300
jmp endloop

gotoline300 
jsr line300

endloop     
lda $FB     ;get sprite pointer
sta $07f8   ;store sprite pointer
inc $FB     ;increment sprite pointer 
lda $FB     ;grab new sprite pointer
cmp #195
bne keepgoing
lda #192
sta $FB
keepgoing   
txa 
clc
adc #03
bcc nocarry
lda #01
sta $FD
nocarry
sta $FC
tax
tya
pha 
;ldy #$ff
;delayloop
;cpy #00
;beq delayend
;dey
;jmp delayloop
delayend
pla 
tay 
jmp line50loop






line200     ; click
lda #129
sta S+4
lda #128
sta S+4
rts

line300     ; clack  
lda $129
sta S+11
lda #128
sta S+11
rts





























