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
sei ;temporarily disable all interrupts
lda #%01111111 ;mask to turn of CIA-1 interrupts
sta $DC0D      ;turn off CIA-1 interrupts
and $D011      ;clear MSB of VIC-II raster register

lda $DC0D      ;clear any interrupts from CIA-1
lda $DC0D      ;clear any interrupts from CIA-2

lda #250       ;select raster line to trigger interrupt
sta $D012      ;set line for raster interrupt to trigger on

lda #<irq      ;store addresses of custom IRQ handler
sta IRQLB
lda #>irq
sta IRQHB
cli 

; Call the Libsound initialization
#LIBSOUND_INIT_A gameDataSID


mainloop
jmp mainloop


irq
#LIBSOUND_UPDATE_A gameDataSID

endirq
lda #$ff
sta $D019   ;acknowledge interrupt
;rti 
jmp $ea31   ;return to KERNAL interrupt handler