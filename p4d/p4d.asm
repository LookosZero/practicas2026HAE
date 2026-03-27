
_interrupt:

;p4d.c,7 :: 		void interrupt(){
;p4d.c,8 :: 		if(bucleLuz == true) {
	MOVF        _bucleLuz+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt0
;p4d.c,9 :: 		bucleLuz = false;
	CLRF        _bucleLuz+0 
;p4d.c,10 :: 		} else {
	GOTO        L_interrupt1
L_interrupt0:
;p4d.c,11 :: 		bucleLuz = true;
	MOVLW       1
	MOVWF       _bucleLuz+0 
;p4d.c,12 :: 		}
L_interrupt1:
;p4d.c,14 :: 		x = PORTB; // Leer el puerto B antes de borrar el flag
	MOVF        PORTB+0, 0 
	MOVWF       _x+0 
	MOVLW       0
	MOVWF       _x+1 
;p4d.c,15 :: 		INTCON.RBIF = 0; // Se borra el flag
	BCF         INTCON+0, 0 
;p4d.c,16 :: 		}
L_end_interrupt:
L__interrupt9:
	RETFIE      1
; end of _interrupt

_main:

;p4d.c,18 :: 		void main(){
;p4d.c,19 :: 		ADCON1 = 0x07;
	MOVLW       7
	MOVWF       ADCON1+0 
;p4d.c,21 :: 		TRISA.B0 = 0;
	BCF         TRISA+0, 0 
;p4d.c,23 :: 		TRISB.B5 = 1;
	BSF         TRISB+0, 5 
;p4d.c,24 :: 		x = PORTB;
	MOVF        PORTB+0, 0 
	MOVWF       _x+0 
	MOVLW       0
	MOVWF       _x+1 
;p4d.c,25 :: 		INTCON.RBIF = 0; // Se pone el flag a 0
	BCF         INTCON+0, 0 
;p4d.c,26 :: 		INTCON.RBIE = 1; // Se habilita la interrupción por cambio de nivel
	BSF         INTCON+0, 3 
;p4d.c,27 :: 		INTCON.GIE = 1; // Se habilitan las interrupciones en general
	BSF         INTCON+0, 7 
;p4d.c,29 :: 		while(1){
L_main2:
;p4d.c,30 :: 		while(bucleLuz) {
L_main4:
	MOVF        _bucleLuz+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main5
;p4d.c,31 :: 		PORTA.B0 = 0;
	BCF         PORTA+0, 0 
;p4d.c,32 :: 		delay_ms(500);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main6:
	DECFSZ      R13, 1, 1
	BRA         L_main6
	DECFSZ      R12, 1, 1
	BRA         L_main6
	DECFSZ      R11, 1, 1
	BRA         L_main6
	NOP
	NOP
;p4d.c,33 :: 		PORTA.B0 = 1;
	BSF         PORTA+0, 0 
;p4d.c,34 :: 		delay_ms(500);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main7:
	DECFSZ      R13, 1, 1
	BRA         L_main7
	DECFSZ      R12, 1, 1
	BRA         L_main7
	DECFSZ      R11, 1, 1
	BRA         L_main7
	NOP
	NOP
;p4d.c,35 :: 		}
	GOTO        L_main4
L_main5:
;p4d.c,36 :: 		PORTA.B0 = 0;
	BCF         PORTA+0, 0 
;p4d.c,37 :: 		}
	GOTO        L_main2
;p4d.c,38 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
