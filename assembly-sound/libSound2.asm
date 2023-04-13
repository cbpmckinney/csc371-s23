soundIsPAL         .byte 0
soundNTSCTimer     .byte 0


LIBSOUND_INIT_A .macro
    
    lda $02A6
    sta soundIsPAL  ; Get system type
    lda #0          
    tax 
    tay 
    jsr \1   ; initialize music

.endm 

  
;LIBSOUND_PLAYSFX_AA(wSidfile, wSound)   
LIBSOUND_PLAYSFX_AA .macro 
    lda #<\2
    ldy #>\2
    ldx #14
    jsr \1+6
.endm 

;.macro LIBSOUND_UPDATE_A(wSidfile)
LIBSOUND_UPDATE_A .macro 

    lda soundIsPAL
    cmp #1 ;Is system PAL?
    beq pal ;Yes.
    ;System is NTSC
    inc soundNTSCTimer
    lda soundNTSCTimer
    cmp #6 ;Music delay
    beq resetNTSCTimer  
pal
    jsr \1+3
    jmp end
resetNTSCTimer
    lda #0
    sta soundNTSCTimer
end  
.endm