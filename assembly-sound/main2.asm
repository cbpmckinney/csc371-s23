* = $0801
; SYS(8192) instead of SYS(4096)
.byte $08, $0d, $0a, $00, $9e, $28, $38
.byte $31, $39, $32, $29, $00, $00, $00

IRQLB = $0314
IRQHB = $0315

* = $1000
gameDataSID

.binary "Calypso_Bar.sid", $7e

.include "libSound2.asm"

* = $2000


; Set up custom IRQ handler for timings
initirq
ldy #$7f    ; $7f = %01111111
sty $dc0d   ; Turn off CIAs Timer interrupts
sty $dd0d   ; Turn off CIAs Timer interrupts
lda $dc0d   ; cancel all CIA-IRQs in queue/unprocessed
lda $dd0d   ; cancel all CIA-IRQs in queue/unprocessed
          
lda #$01    ; Set Interrupt Request Mask...
sta $d01a   ; ...we want IRQ by Rasterbeam

lda #<irq   ; point IRQ Vector to our custom irq routine
ldx #>irq 
sta $314    ; store in $314/$315
stx $315   

lda #$00    ; trigger first interrupt at row zero
sta $d012

lda $d011   ; Bit#0 of $d011 is basically...
and #$7f    ; ...the 9th Bit for $d012
sta $d011   ; we need to make sure it is set to zero 

cli         ; clear interrupt disable flag       

; Call the Libsound initialization
#LIBSOUND_INIT_A gameDataSID


mainloop
jmp mainloop


irq
#LIBSOUND_UPDATE_A gameDataSID

endirq
dec $D019   ;acknowledge interrupt
;rti 
jmp $ea81   ;return to KERNAL interrupt handler