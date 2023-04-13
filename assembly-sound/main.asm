* = $0801
; SYS(8192) instead of SYS(4096)
.byte $08, $0d, $0a, $00, $9e, $28, $38
.byte $31, $39, $32, $29, $00, $00, $00

* = $1000
gameDataSID

.binary "Calypso_Bar.sid", $7e

.include "libSound2.asm"

* = $2000

#LIBSOUND_INIT_A gameDataSID

mainloop

    #LIBSOUND_UPDATE_A gameDataSID
    jsr delay

jmp mainloop

delay
ldx #255
delayloop
cpx #0
beq delayexit
dex 
jmp delayloop
delayexit
rts