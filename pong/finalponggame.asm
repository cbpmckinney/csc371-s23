.include "wedge.asm"
.include "kernal.asm"
.include "macros.asm"
.include "io.asm"

spritex = $D000
spritey = $D001
paddley = $D003
paddle2y = $D005
GA = $3000 ;Location of first sprite art
GB = $3040 ;Location of second sprite art
GC = $3080 ;Location of third sprite art
S = $D400


* = $1000

init    ; initializes 6512 CIA that handles the user port
jsr SCINIT     ; clear screen
lda #%00101000  ; initialize pins 3 and 5 as input/output; all others are input only
sta PORTB_DDR

SNES_B		=$C000
SNES_Y		=$C001
SNES_SELECT	=$C002
SNES_START	=$C003
SNES_UP		=$C004
SNES_DOWN	=$C005
SNES_LEFT	=$C006
SNES_RIGHT	=$C007
SNES_A		=$C008
SNES_X		=$C009
SNES_BACK_L	=$C00A
SNES_BACK_R	=$C00B

SNES_B_2		=$C010
SNES_Y_2		=$C011
SNES_SELECT_2	=$C012
SNES_START_2	=$C013
SNES_UP_2		=$C014
SNES_DOWN_2	    =$C015
SNES_LEFT_2	    =$C016
SNES_RIGHT_2	=$C017
SNES_A_2		=$C018
SNES_X_2		=$C019
SNES_BACK_L_2	=$C01A
SNES_BACK_R_2	=$C01B


lda #0
sta $d020
sta $d021

#setcursor 5,12
#printstring <welcomestring, >welcomestring

#setcursor 8,8
#printstring <onepstring, >onepstring

#setcursor 10,7
#printstring <twopstring, >twopstring


mainmenuloop
jsr snes_controller_read
jsr checkifpressed
jmp mainmenuloop



snes_controller_read
;now latch data
LDA	#%00100000	    ;latch on pin 5
STA	$DD01	
LDA	#%00000000
STA	PORTB_DATA	
LDX	#0

DBLOOP
LDA	PORTB_DATA
AND	#%01000000	    ;READ pin 6
CMP	#%01000000
BEQ	DB1
LDA	#1
JMP	DB5

DB1	
LDA	#0

DB5	
STA	SNES_B,X         ;$c000 start of snes mem stuff          
;pulse the clock line
LDA	#%00001000      ;CLOCK on pin 3
STA	$DD01
LDA	#%00000000
STA	$DD01
INX
CPX	#12
BNE	DBLOOP
RTS

checkifpressed
lda	SNES_UP
cmp	#0
bne	oneplayerinit
lda SNES_DOWN
cmp #0
bne twoplayerinit
rts

oneplayerinit
ldy #0
cpy #0
beq fullinit

twoplayerinit
ldy #1

fullinit
jsr SCINIT     ; clear screen
lda #0
sta $d020
sta $d021
lda #7
sta $D015
lda #1
sta $D027
lda #2
sta $D028
lda #6
sta $D029
lda #192
sta $07F8
lda #193
sta $07F9
lda #194
sta $07FA


#setcursor 0,5
#printstring <p1string, >p1string
#setcursor 0,14
#printstring <p1score, >p1score

#setcursor 0,17
#printstring <string, >string

#setcursor 0,23
#printstring <p2string, >p2string
#setcursor 0,32
#printstring <p2score, >p2score

ldx #0
lda #$6f
sta borderstring1
inx

border1loop
cpx #39
beq endborder1loop
lda #$f7
sta borderstring1,x
inx
jmp border1loop

endborder1loop
lda #$70
sta borderstring1,x

#setcursor 1,0
#printstring <borderstring1, >borderstring1

ldx #0
lda #$6c
sta borderstring2
inx

border2loop
cpx #39
beq endborder2loop
lda #$ef
sta borderstring2,x
inx
jmp border2loop

endborder2loop
lda #$ba
sta borderstring2,x

#setcursor 23,0
#printstring <borderstring2, >borderstring2


lda #$e5
sta leftborder
#setcursor 2,0
#printstring <leftborder, >leftborder
#setcursor 3,0
#printstring <leftborder, >leftborder
#setcursor 4,0
#printstring <leftborder, >leftborder
#setcursor 5,0
#printstring <leftborder, >leftborder
#setcursor 6,0
#printstring <leftborder, >leftborder
#setcursor 7,0
#printstring <leftborder, >leftborder
#setcursor 8,0
#printstring <leftborder, >leftborder
#setcursor 9,0
#printstring <leftborder, >leftborder
#setcursor 10,0
#printstring <leftborder, >leftborder
#setcursor 11,0
#printstring <leftborder, >leftborder
#setcursor 12,0
#printstring <leftborder, >leftborder
#setcursor 13,0
#printstring <leftborder, >leftborder
#setcursor 14,0
#printstring <leftborder, >leftborder
#setcursor 15,0
#printstring <leftborder, >leftborder
#setcursor 16,0
#printstring <leftborder, >leftborder
#setcursor 17,0
#printstring <leftborder, >leftborder
#setcursor 18,0
#printstring <leftborder, >leftborder
#setcursor 19,0
#printstring <leftborder, >leftborder
#setcursor 20,0
#printstring <leftborder, >leftborder
#setcursor 21,0
#printstring <leftborder, >leftborder
#setcursor 22,0
#printstring <leftborder, >leftborder

lda #$ea
sta rightborder
#setcursor 2,39
#printstring <rightborder, >rightborder
#setcursor 3,39
#printstring <rightborder, >rightborder
#setcursor 4,39
#printstring <rightborder, >rightborder
#setcursor 5,39
#printstring <rightborder, >rightborder
#setcursor 6,39
#printstring <rightborder, >rightborder
#setcursor 7,39
#printstring <rightborder, >rightborder
#setcursor 8,39
#printstring <rightborder, >rightborder
#setcursor 9,39
#printstring <rightborder, >rightborder
#setcursor 10,39
#printstring <rightborder, >rightborder
#setcursor 11,39
#printstring <rightborder, >rightborder
#setcursor 12,39
#printstring <rightborder, >rightborder
#setcursor 13,39
#printstring <rightborder, >rightborder
#setcursor 14,39
#printstring <rightborder, >rightborder
#setcursor 15,39
#printstring <rightborder, >rightborder
#setcursor 16,39
#printstring <rightborder, >rightborder
#setcursor 17,39
#printstring <rightborder, >rightborder
#setcursor 18,39
#printstring <rightborder, >rightborder
#setcursor 19,39
#printstring <rightborder, >rightborder
#setcursor 20,39
#printstring <rightborder, >rightborder
#setcursor 21,39
#printstring <rightborder, >rightborder
#setcursor 22,39
#printstring <rightborder, >rightborder



copydata
ldx #0

copyloop
cpx #63
beq initsound
lda sprite1graphics,x
sta GA,x
lda sprite23graphics,x
sta GB,x
sta GC,x
inx
jmp copyloop

initsound
lda #15
sta S+24    ;pokes+24, 15
lda #220
sta S       ;pokes,220
lda #68
sta S+1     ;pokes+1,68
lda #15
sta S+5     ;pokes+5,15
lda #255
sta S+6     ;pokes+6,215
lda #200
sta S+7     ;pokes+7,120
lda #100    
sta S+8     ;pokes+8,200
lda #255
sta S+12    ;pokes+12,15
lda #255
sta S+13    ;pokes+13,215

lda #170
sta $D000
lda #100
sta $D001
lda #30
sta $D002
lda #100
sta $D003
lda #4
sta $D010
lda #58
sta $D004
lda #100
sta $D005

cpy #1
beq twoplayermain





oneplayermain
jsr snes_controller_read
jsr movepaddle
jsr moveaipaddle
jsr checkscore
jsr checkbouncey
jsr checkbouncex
jsr moveball
jsr delayloop
jsr delayloop
jmp oneplayermain



twoplayermain
jsr snes_controller_read
jsr joystickread
jsr movepaddle
jsr movep2paddle
jsr checkscore
jsr checkbouncey
jsr checkbouncex
jsr moveball
jsr delayloop
jsr delayloop
jmp twoplayermain

joystickread

lda JOYSTICK2
eor #$ff 
and #$01
sta SNES_UP_2
lda JOYSTICK2
eor #$ff
and #$02
sta SNES_DOWN_2
rts 



movep2paddle

db1_2	
lda	SNES_UP_2
cmp	#0
bne	db1move_2
JMP	db2_2

db1move_2
lda paddle2y
cmp #60
beq db2
sec
sbc #1
sta paddle2y

db2_2
lda	SNES_DOWN_2
cmp	#0
bne	db2move_2
JMP	endpaddle_2

db2move_2
lda paddle2y
cmp #219
beq endpaddle_2
clc
adc #1
sta paddle2y

endpaddle_2
rts



movepaddle

db1	
lda	SNES_UP
cmp	#0
bne	db1move
JMP	db2

db1move
lda paddley
cmp #60
beq db2
sec
sbc #1
sta paddley

db2
lda	SNES_DOWN
cmp	#0
bne	db2move
JMP	endpaddle

db2move
lda paddley
cmp #219
beq endpaddle
clc
adc #1
sta paddley

endpaddle
rts

moveaipaddle
lda $D005
cmp #60
beq otherway
cmp #219
beq otherway
clc
adc paddlevel
sta $D005
jmp endmoveai

otherway
lda #$ff
eor paddlevel
sta paddlevel
inc paddlevel
lda $D005
clc
adc paddlevel
sta $D005
endmoveai
rts

checkscore
lda $D010
cmp #5
beq checkp1score
lda $D000
cmp #0
beq p2scored
jmp endcheckscore

checkp1score
lda $D000
cmp #88
beq p1scored
jmp endcheckscore

p1scored
lda p1
cmp #9
beq p1win
lda #4
sta $D010
lda #50
sta $D000
lda $D003
sta $D001
jsr scoresound
inc p1
lda p1
sta remainder 
lda #0
sta quotient

ldx #0
jmp divloop

p1win
jsr SCINIT
lda #0
sta $d020
sta $d021
#setcursor 10,14
#printstring <p1winner, >p1winner
loop
jmp loop

p2scored
jmp p2scored2

divloop
lda remainder
sec 
sbc #$0a
bmi subend
sta remainder
inc quotient
jmp divloop
subend
lda remainder
clc 
adc #$30
sta intstring,x
lda quotient
cmp #0
beq divend
sta remainder
lda #0
sta quotient
inx 
jmp divloop
divend 


ldy #0 ;use x to offset the first string, y for the second
reversestring
lda intstring,x
sta p1score,y
iny
dex
cpx #255
beq done
jmp reversestring

done
lda #0
sta p1score,y



#setcursor 0,14
#printstring <p1score, >p1score

ldx #2
resetloop
lda #$20
sta intstring,x
cpx #0
beq endcheckscore2
dex
jmp resetloop

endcheckscore2
rts

p2scored2
lda p2
cmp #9
beq p2win
lda #5
sta $D010
lda #38
sta $D000
lda $D005
sta $D001
jsr scoresound
inc p2
lda p2
sta remainder 
lda #0
sta quotient

ldx #0
divloop2
lda remainder
sec 
sbc #$0a
bmi subend2
sta remainder
inc quotient
jmp divloop2
subend2
lda remainder
clc 
adc #$30
sta intstring,x
lda quotient
cmp #0
beq divend2
sta remainder
lda #0
sta quotient
inx 
jmp divloop2

p2win
jsr SCINIT
lda #0
sta $d020
sta $d021
#setcursor 10,14
#printstring <p2winner, >p2winner
loop2
jmp loop2


divend2


ldy #0 ;use x to offset the first string, y for the second
reversestring2
lda intstring,x
sta p2score,y
iny
dex
cpx #255
beq done2
jmp reversestring

done2
lda #0
sta p2score,y

#setcursor 0,32
#printstring <p2score, >p2score

ldx #2
resetloop2
lda #$20
sta intstring,x
cpx #0
beq endcheckscore
dex
jmp resetloop2

endcheckscore
rts



checkbouncey
lda spritey
cmp #225
beq ybounce
cmp #55
bne ybounceexit

ybounce
lda #$ff
eor vely 
sta vely 
inc vely
jsr bouncesound


ybounceexit
rts

checkbouncex
lda $D01E
cmp #0
bne xbounce
jmp xbounceexit

xbounce
lda #$ff
eor velx
sta velx 
inc velx
jsr bouncesound


xbounceexit
rts


moveball
lda $D010
cmp #5
beq rightside
lda velx
bpl checkrighthalf
lda spritex
clc
adc velx
sta spritex
lda spritey
clc
adc vely
sta spritey
jmp moveballend

checkrighthalf
lda spritex
cmp #255
beq righthalfon
clc
adc velx
sta spritex
lda spritey
clc
adc vely
sta spritey
jmp moveballend

rightside
lda velx
bmi rightsideleft
lda spritex
clc
adc velx
sta spritex
lda spritey
clc
adc vely
sta spritey
jmp moveballend

rightsideleft
lda $D000
cmp #0
beq righthalfoff
clc
adc velx
sta spritex
lda spritey
clc
adc vely
sta spritey
jmp moveballend

righthalfon
lda #0
sta $D000
lda #5
sta $D010
lda spritey
clc
adc vely
sta spritey
jmp moveballend

righthalfoff
lda #255
sta $D000
lda #4
sta $D010
lda spritey
clc
adc vely
sta spritey


moveballend
rts



scoresound
pha 
lda #129
sta S+4
ldx #255
sounddelay
cpx #0
beq delayexit3
dex 
jmp sounddelay
delayexit3
lda 128
sta S+4
pla 
rts

bouncesound
pha 
lda #129
sta S+11
ldx #255
sounddelay2
cpx #0
beq delayexit2
dex 
jmp sounddelay2
delayexit2
lda 128
sta S+11
pla 
rts



delayloop
ldy #255
ldx #255
delayloop2
cpx #0
beq delayy
dex 
jmp delayloop2
delayy
cpy #0
beq delayexit
dey
jmp delayloop2
delayexit
rts


JOYMASK
.byte $01

welcomestring 
.null "welcome to pong"

onepstring 
.null "press up for one player"

twopstring 
.null "press down for two player"

p1
.byte $00
p2
.byte $00

paddlevel
.byte $01 
velx
.byte $ff
vely
.byte $01

quotient
.byte $0

remainder 
.byte $0

intstring 
.null "   "

string 
.null "pong"

p1string
.null "p1 score:"

p1score
.null "0  "

p2string
.null "p2 score:"

p2score
.null "0  "

borderstring1
.null "                                        "

borderstring2
.null "                                        "

leftborder
.null " "

rightborder
.null " "

p1winner
.null "player 1 wins!"

p2winner
.null "player 2 wins!"

sprite1graphics
.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
.byte 60,0,0,126,0,0,255,0,1,255,128,1,255,128,1,255
.byte 128,1,255,128,0,255,0,0,126,0,0,60,0,0,0,0
.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1

sprite23graphics
.byte 0,60,0,0,60,0,0,60,0,0,60,0,0,60,0,0
.byte 60,0,0,60,0,0,60,0,0,60,0,0,60,0,0,60
.byte 0,0,60,0,0,60,0,0,60,0,0,60,0,0,60,0
.byte 0,60,0,0,60,0,0,60,0,0,60,0,0,60,0,3