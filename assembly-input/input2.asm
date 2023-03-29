;Example program to accept two numbers as input, and return the sum

* = $0801 ; SYS 4096 wedge
.byte $08, $0d, $0a, $00, $9e, $28, $34
.byte $30, $39, $36, $29, $00, $00, $00

* = $1000

SCINIT = $FF81  ; SCINIT KERNAL ROUTINE
PLOT = $FFF0    ; PLOT KERNAL ROUTINE
CHRIN = $FFCF   ; CHRIN KERNAL ROUTINE
CHROUT = $FFD2  ; CHROUT KERNAL ROUTINE
PRINTNULL = $AB1E   ; ROM routine to print null terminated string, LB in A, HB in Y
FOUT = $AABC   ; Convert FAC to null terminated string at LB in Y, HB in A
GIVAYF = $B391  ; Convert 16 bit signed int to FAC; LB in Y, HB in A
MOVFA = $BC0F   ; Move FAC to ARG
ARGFAC = $BBFC ; Move ARG to FAC?
FACARG = $BC0C 

FADDT = $B86A   ; Add FAC and ARG -> FAC



jsr SCINIT      ; clears screen
clc
ldx #0
ldy #0
jsr PLOT        ;resets cursor to top left of screen

lda #<instring1
ldy #>instring1
jsr PRINTNULL

jsr CHRIN 
sta instring3

clc
ldx #1
ldy #0
jsr PLOT

lda #<instring2
ldy #>instring2
jsr PRINTNULL

jsr CHRIN
sta instring4

lda instring3
sec 
sbc #$30
sta num1+1

lda instring4
sec
sbc #$30
sta num2+1

ldy #<num1
lda #>num1
jsr GIVAYF

jsr FACARG

;ldy #<num2
;lda #>num2 
;jsr GIVAYF

;jsr FADDT

lda #<outstr2
ldy #>outstr2
jsr FOUT

clc
ldy #00
ldx #02
jsr PLOT

lda #<outstr1
ldy #>outstr1
jsr PRINTNULL

lda #<outstr2
ldy #>outstr2
jsr PRINTNULL


rts 



instring1
.null "please input number 1: "
instring2 
.null "please input number 2: "

instring3
.null " "
instring4
.null " "

num1 .byte $00, $00
num2 .byte $00, $00

outstr1 
.null "the sum is: "
outstr2 
.null "0000000000000"