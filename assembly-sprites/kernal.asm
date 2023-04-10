SCINIT = $FF81  ; SCINIT KERNAL ROUTINE
PLOT = $FFF0    ; PLOT KERNAL ROUTINE
CHRIN = $FFCF   ; CHRIN KERNAL ROUTINE
CHROUT = $FFD2  ; CHROUT KERNAL ROUTINE
GETIN = $FFE4
PRINTNULL = $AB1E   ; ROM routine to print null terminated string, LB in A, HB in Y
FOUT = $BDDD   ; Convert FAC to null terminated string, starting in $0101.  Whack.
GIVAYF = $B391  ; Convert 16 bit signed int to FAC; LB in Y, HB in A.  NOT ADDRESSES
MOVFA = $BC0F   ; Move FAC to ARG
ARGFAC = $BBFC  ; Move ARG to FAC?
FACARG = $BC0C  ; Moves FAC to ARG
MOVMF = $BBD4   ; Moves FAC to memory

FADDT = $B86A   ; Add FAC and ARG -> FAC