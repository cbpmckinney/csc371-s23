* = $0801
; SYS(8192) instead of SYS(4096)
.byte $08, $0d, $0a, $00, $9e, $28, $38
.byte $31, $39, $32, $29, $00, $00, $00

IRQLB = $0314
IRQHB = $0315

* = $1000

.binary "nyan-ntsc2.sid", $7c

;.include "libSound2.asm"

* = $2000


; Set up custom IRQ handler for timings
initirq
ldy #$7f    ; $7f = %01111111
sty $dc0d   ; Turn off CIAs Timer interrupts
sty $dd0d   ; Turn off CIAs Timer interrupts
lda $dc0d   ; cancel all CIA-IRQs in queue/unprocessed
lda $dd0d   ; cancel all CIA-IRQs in queue/unprocessed
          
lda #$01    ; Set Interrupt Request Mask...
sta $d01a   ; ...we want IRQ by raster line 

lda #<irq   ; point IRQ Vector to our custom irq routine
ldx #>irq 
sta $314    ; store in $314/$315
stx $315   

lda #250    ; trigger interrupt where?  line 250, or 0, or whatever we want perhaps
sta $d012

lda $d011   ; Bit#0 of $d011 is basically...
and #$7f    ; ...the 9th Bit for $d012
sta $d011   ; we need to make sure it is set to zero 

cli         ; clear interrupt disable flag       

;Manual sound init
    lda #0
    jsr $1106   ; initialize music


mainloop
jmp mainloop

irq

; We can put other stuff to go here during the interrupt, such as checking input
; Moving sprites, etc.

jsr $1000


endirq
;dec $D019   ;acknowledge interrupt
rti

;jmp $ea81   ;return to KERNAL interrupt handler



soundIsPAL         .byte 0
soundNTSCTimer     .byte 0