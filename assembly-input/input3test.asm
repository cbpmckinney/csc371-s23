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
FOUT = $BDDD   ; Convert FAC to null terminated string at LB in Y, HB in A
GIVAYF = $B391  ; Convert 16 bit signed int to FAC; LB in Y, HB in A
MOVFA = $BC0F   ; Move FAC to ARG
ARGFAC = $BBFC ; Move ARG to FAC?
FACARG = $BC0C 
MOVMF = $BBD4

FADDT = $B86A   ; Add FAC and ARG -> FAC



jsr SCINIT      ; clears screen

ldy #5
lda #0 
jsr GIVAYF
jsr FACARG

ldy #3
lda #0
jsr GIVAYF

jsr FADDT



ldx #<num3
ldy #>num3
jsr MOVMF

lda #<outstr2
ldy #>outstr2
jsr FOUT
;lda #<outstr2
;ldy #>outstr2
;jsr PRINTNULL


rts 



instring1
.null "please input number 1: "
instring2 
.null "please input number 2: "

instring3
.null " "
instring4
.null " "

num1 .byte $00, $02
num2 .byte $00, $00

outstr1 
.null "the sum is: "
outstr2 
.null "0000000000000"

two .byte $82, $00, $00, $00, $00
num3 .byte $0, $0, $0, $0, $0