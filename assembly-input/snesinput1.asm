; SNES game pad input example
; Inspired by David Murray's example program
; Requires SNES to user port adapter from TexElec
.include "wedge.asm"
.include "kernal.asm"
.include "macros.asm"
.include "io.asm"

* = $1000



init    ; initializes 6512 CIA that handles the user port
jsr SCINIT     ; clear screen
lda #%00101000  ; initialize pins 3 and 5 as input/output; all others are input only
sta PORTB_DDR

main

jsr snes_controller_read
jmp main





; to read SNES controller data, we need to read pin 6 of port b.  we need to first latch on pin 5, then
; pulse pin 3 (the clock) once to read the data for each button
; when pin 5 latches, the controller stores the status of each button at that moment
; the data for each is passed sequentially via pin 6
; so we need to read pin 6 twelve times, in the following order
; B, Y, SELECT, START, UP, DOWN, LEFT, RIGHT, A, X, BACKL, BACKR 

snes_controller_read
; first latch data
lda #%00100000
sta PORTB_DATA
lda #%00000000
sta PORTB_DATA

ldx #0
snes_read_loop
; now read a bit
lda $PORTB_DATA
sta SNES_B, x 

; pulse clock to get next bit
lda #%00001000 
sta PORTB_DATA
lda #%00000000
sta PORTB_DATA

inx 
cpx #12
bne snes_read_loop
rts




SNES_B .byte $00
SNES_Y .byte $00
SNES_SELECT .byte $00
SNES_START .byte $00
SNES_UP .byte $00
SNES_DOWN .byte $00
SNES_LEFT .byte $00
SNES_RIGHT .byte $00
SNES_A .byte $00
SNES_X .byte $00
SNES_BACKL .byte $00
SNES_BACKR .byte $00
