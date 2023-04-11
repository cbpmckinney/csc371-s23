; Sprite collisions example
; Uses joystick controls too as example
; Instead of SNES controller 

.include "wedge.asm"
.include "io.asm"
.include "macros.asm"
.include "kernal.asm"

* = $1000

init 
jsr SCINIT
lda #192
sta $07F8
sta $07F9
lda #3
sta $D015

ldx #0
initloop
lda #$ff
sta $3000,x 
inx
cpx #63
bne initloop

lda #100
sta $D000
sta $D001
sta $D002
lda #200
sta $D003
lda #4
sta $D028


main 
jsr polljoystick
jsr checkcollision
jsr movesprite
jsr delayloop
jmp main



checkcollision
lda $D01E
cmp #3
bne checkcollision_clear
checkcollision_notclear
#setcursor 0, 0
#printstring <COLLISION_STRING, >COLLISION_STRING
dec $D001
jmp checkcollision_exit

checkcollision_clear
#setcursor 0, 0
#printstring <BLANK_STRING, >BLANK_STRING


checkcollision_exit
rts 





delayloop
ldx #255
delayloop2
cpx #0
beq delayexit
dex 
jmp delayloop2
delayexit
rts



movesprite
check_up
lda JOYSTATUS2
cmp #01
bne check_down
jsr decr_ycoord
check_down
lda JOYSTATUS2+1
cmp #02
bne check_left
jsr incr_ycoord
check_left
lda JOYSTATUS2+2
cmp #04
bne check_right
jsr decr_xcoord
check_right
lda JOYSTATUS2+3
cmp #08
bne check_fire
jsr incr_xcoord 
check_fire
rts 


decr_ycoord 
dec $D001
rts 

incr_ycoord
inc $D001
rts 

incr_xcoord
rts

decr_xcoord
rts 



polljoystick
; joystick 1 register is $DC01
ldx #0
lda #$01
sta JOYMASK ;reset joymask back to #$01
polljoystickloop
lda JOYSTICK2
eor #$ff  ; flips bits so 1 is on and 0 is off 
and JOYMASK 
sta JOYSTATUS2,x
asl JOYMASK  
inx 
cpx #5 
bne polljoystickloop
rts 


JOYSTATUS2
.byte $00, $00, $00, $00, $00 ;up, down, left, right, fire
JOYMASK
.byte $01
COLLISION_STRING
.null "collision!"
BLANK_STRING
.null "          "