; Definitions of IO locations

; CIA#2 ports: Serial, RS232, NMI

PORTA_DATA = $DD00 ; Port A data
PORTB_DATA = $DD01 ; Port B data
PORTA_DDR = $DD02 ; data direction register for USR Port A
PORTB_DDR = $DD03 ; data direction register for USR Port B
JOYSTICK1 = $DC01 ; Joystick Port 1
JOYSTICK2 = $DC00 ; Joystick Port 2
;for joysticks, bit 0 is 0 for up, bit 1 is 0 for down, bit 2 is 0 for left, bit 3 is 0 for right
;bit 4 is 0 for fire
;so the byte reads $FF if no buttons are pressed


