S = $D400 ;$D400 is start of SID chip registers
V = $D000 ;$D000 is start of VIC-II chip registers
GA = $3000 ;Location of first sprite art
GB = $3040 ;Location of second sprite art
GC = $3080 ;Location of third sprite art


* = $0801

.byte $08, $0d, $0a, $00, $9e, $28, $34
.byte $30, $39, $36, $29, $00, $00, $00


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
cpx #191
beq finished
lda spritegraphics,x
sta GA,x
inx
jmp copyloop
finished

initsound
lda #15
sta S+24    ;pokes+24, 15
lda #220
sta S       ;pokes,220
lda #68
sta S+1     ;pokes+1,68
lda #15
sta S+5     ;pokes+5,15
lda #215
sta S+6     ;pokes+6,215
lda #120
sta S+7     ;pokes+7,120
lda #100    
sta S+8     ;pokes+8,200
lda #15
sta S+12    ;pokes+12,15
lda #215
sta S+13    ;pokes+13,215

lda #0
sta $D010
moveloop
jsr incmousepointer
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
jsr incmousepointer
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

incmousepointer
pha 
checkclick
lda $07F8   ;loads sprite pointer
cmp #192
bne checkclack
jsr click
checkclack
cmp #193
bne noisefinished
jsr clack
noisefinished
clc 
adc #01
sta $07F8
cmp #195
bne keeplooping
lda #192
sta $07F8
keeplooping
pla 
rts

click
pha 
lda #129
sta S+4
lda 128
sta S+4
pla 
rts

clack
pha 
lda #129
sta S+11
lda 128
sta S+11
pla 
rts


spritegraphics
; frame 1
.byte 30,0,120,63,0,252,127,129,254,127,129,254,127,189,254,127,255,254
.byte 63,255,252,31,187,248,3,187,192,1,255,128,3,189,192,1,231,128,1
.byte 255,0,31,255,0,0,124,0,0,254,0,1,199,32,3,131,224,7,1,192,1,192,0
.byte 3,192,0,0 
;frame 2
.byte 30,0,120,63,0,252,127,129,254,127,129,254,127,189,254,127
.byte 255,254,63,255,252,31,221,248,3,221,192,1,255,128,3,255,192,1,195 ;35
.byte 128,1,231,3,31,255,255,0,124,0,0,254,0,1,199,0,7,1,128,7,0,204,1 ; 58
.byte 128,124,7,128,56,0
;frame 3
.byte 30,0,120,63,0,252,127,129,254,127,129,254,127,189
.byte 254,127,255,254,63,255,252,31,221,248,3,221,192,1,255,134,3,189
.byte 204,1,199,152,1,255,48,1,255,224,1,252,0,3,254,0
.byte 7,14,0,204,14,0,248,56,0,112,112,0,0,60,0,255,0

table
.byte $00, $00, $01, $02, $04, $06, $09, $0C