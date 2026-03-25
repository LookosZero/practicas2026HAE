
_interrupt:

;p7b.c,1 :: 		void interrupt(){
;p7b.c,2 :: 		if(INTCON.TMR0IF == 1){
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt0
;p7b.c,3 :: 		PORTB.B0 = ~PORTB.B0;
	BTG         PORTB+0, 0 
;p7b.c,4 :: 		}
L_interrupt0:
;p7b.c,6 :: 		TMR0H = (3036 >> 8);
	MOVLW       11
	MOVWF       TMR0H+0 
;p7b.c,7 :: 		TMR0L = 3036;
	MOVLW       220
	MOVWF       TMR0L+0 
;p7b.c,8 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;p7b.c,9 :: 		}
L_end_interrupt:
L__interrupt4:
	RETFIE      1
; end of _interrupt

_main:

;p7b.c,11 :: 		void main(){
;p7b.c,14 :: 		TRISB.B0 = 0;
	BCF         TRISB+0, 0 
;p7b.c,15 :: 		PORTB.B0 = 0;
	BCF         PORTB+0, 0 
;p7b.c,18 :: 		T0CON = 0x84;
	MOVLW       132
	MOVWF       T0CON+0 
;p7b.c,19 :: 		TMR0H = (3036 >> 8);
	MOVLW       11
	MOVWF       TMR0H+0 
;p7b.c,20 :: 		TMR0L = 3036;
	MOVLW       220
	MOVWF       TMR0L+0 
;p7b.c,23 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;p7b.c,24 :: 		INTCON.TMR0IE = 1;
	BSF         INTCON+0, 5 
;p7b.c,27 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;p7b.c,29 :: 		while(1){
L_main1:
;p7b.c,31 :: 		}
	GOTO        L_main1
;p7b.c,32 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
