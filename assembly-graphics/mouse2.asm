S = $D400 ;$D400 is start of SID chip registers
V = $D000 ;$D000 is start of VIC-II chip registers
GA = $3000 ;Location of first sprite art
GB = $3040 ;Location of second sprite art
GC = $3080 ;Location of third sprite art


* = $1000

initsprite
lda #0
sta V 
lda #50
sta V+1
lda #1
sta $D015
lda #192
sta $07F8
copydata
ldx #0
copyloop
cpx #63
beq finished
lda spritegraphics,x
sta GA,x
inx
jmp copyloop


finished

lda #0
sta $D010
moveloop
ldx #255
sta $D000
clc
adc #1
cmp #0
beq righthalf
delayloop
cpx #0
beq moveloop
dex
jmp delayloop

righthalf
lda #1
sta $D010
righthalfloop
ldx #255
sta $D000
clc
adc #1
cmp #91
beq reset
delayloop2
cpx #0
beq righthalfloop
dex
jmp delayloop2
reset
lda #0
sta $D000
sta $D010
jmp moveloop




spritegraphics
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
