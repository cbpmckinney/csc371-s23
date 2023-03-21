S = $D400 ;$D400 is start of SID chip registers
V = $D000 ;$D000 is start of VIC-II chip registers
GA = $3000 ;Location of first sprite art
GB = $3040 ;Location of second sprite art
GC = $3080 ;Location of third sprite art

IRQLB = $0314
IRQHB = $0315

pushregs .macro
pha
txa 
pha 
tya 
pha 
.endm

pullregs .macro
pla 
tay 
pla 
tax 
pla 
.endm 


* = $0801

.byte $08, $0d, $0a, $00, $9e, $28, $34
.byte $30, $39, $36, $29, $00, $00, $00


* = $1000

initirq
sei ;temporarily disable all interrupts
lda #%01111111 ;mask to turn of CIA-1 interrupts
sta $DC0D      ;turn off CIA-1 interrupts
and $D011      ;clear MSB of VIC-II raster register

lda $DC0D      ;clear any interrupts from CIA-1
lda $DC0D      ;clear any interrupts from CIA-2

lda #0         ;select raster line to trigger interrupt
sta $D012      ;set line for raster interrupt to trigger on

lda #<irq2      ;store addresses of custom IRQ handler
sta IRQLB
lda #>irq2
sta IRQHB

lda $D01A          ;mask for VIC-II interrupts
ora #$01
sta $D01A      ;turn on VIC-II raster interrupts

lda $d011       ; High bit of raster line cleared, we're
and #$7f        ; only working within single byte ranges
sta $d011

cli            ;re-enable interrupts

initsprite
lda #25
sta V
lda #50
sta V+2
lda #75
sta V+4
lda #100
sta V+6
lda #125
sta V+8
lda #150
sta V+10
lda #175
sta V+12
lda #200
sta V+14
lda #50
sta V+1
sta V+3
sta V+5
sta V+7
sta V+9
sta V+11
sta V+13
sta V+15
lda #$ff
sta $D015
lda #192
sta $07F8
sta $07F9
sta $07FA
sta $07FB
sta $07FC
sta $07FD
sta $07FE
sta $07FF

lda #01
sta $D027
sta $D028
sta $D029
sta $D02A
sta $D02B
sta $D02C
sta $D02D
sta $D02E



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

jsr $e544   ;clear screen

mainloop

jmp mainloop



irq1     ;interrupt routine 1; assumes scanline 0
#pushregs
lda #50
sta V+1
lda #<irq2
sta IRQLB
lda #>irq2
sta IRQHB
lda #150
sta $D012
jmp endirq

irq2     ;interrupt routine 2; assumes scanline 200
#pushregs
lda #200
sta V+1
lda #<irq1
sta IRQLB
lda #>irq1
sta IRQHB
lda #0
sta $D012
jmp endirq




endirq
lda #$ff
sta $D019   ;acknowledge interrupt
#pullregs
jmp $ea31   ;return to KERNAL interrupt handler






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
.byte 7,14,0,204,14,0,248,56,0,112,112,0,0,60,0,255