
_main:

;p3a.c,1 :: 		void main(){
;p3a.c,2 :: 		unsigned int estadoActual = 0;
	CLRF        main_estadoActual_L0+0 
	CLRF        main_estadoActual_L0+1 
	CLRF        main_estadoAnterior_L0+0 
	CLRF        main_estadoAnterior_L0+1 
;p3a.c,5 :: 		ADCON1 = 0x07;
	MOVLW       7
	MOVWF       ADCON1+0 
;p3a.c,7 :: 		TRISB.B2 = 1;
	BSF         TRISB+0, 2 
;p3a.c,8 :: 		TRISB.B3 = 0;
	BCF         TRISB+0, 3 
;p3a.c,10 :: 		PORTB.B2 = 0;
	BCF         PORTB+0, 2 
;p3a.c,11 :: 		PORTB.B3 = 0;
	BCF         PORTB+0, 3 
;p3a.c,13 :: 		while(1){
L_main0:
;p3a.c,14 :: 		estadoActual = PORTB.B2;
	MOVLW       0
	BTFSC       PORTB+0, 2 
	MOVLW       1
	MOVWF       main_estadoActual_L0+0 
	CLRF        main_estadoActual_L0+1 
;p3a.c,16 :: 		if(estadoActual == 1 && estadoAnterior == 0){
	MOVLW       0
	XORWF       main_estadoActual_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main10
	MOVLW       1
	XORWF       main_estadoActual_L0+0, 0 
L__main10:
	BTFSS       STATUS+0, 2 
	GOTO        L_main4
	MOVLW       0
	XORWF       main_estadoAnterior_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main11
	MOVLW       0
	XORWF       main_estadoAnterior_L0+0, 0 
L__main11:
	BTFSS       STATUS+0, 2 
	GOTO        L_main4
L__main8:
;p3a.c,17 :: 		if(PORTB.B3 == 1){
	BTFSS       PORTB+0, 3 
	GOTO        L_main5
;p3a.c,18 :: 		PORTB.B3 = 0;
	BCF         PORTB+0, 3 
;p3a.c,19 :: 		}else{
	GOTO        L_main6
L_main5:
;p3a.c,20 :: 		PORTB.B3 = 1;
	BSF         PORTB+0, 3 
;p3a.c,21 :: 		}
L_main6:
;p3a.c,22 :: 		}
L_main4:
;p3a.c,24 :: 		estadoAnterior = estadoActual;
	MOVF        main_estadoActual_L0+0, 0 
	MOVWF       main_estadoAnterior_L0+0 
	MOVF        main_estadoActual_L0+1, 0 
	MOVWF       main_estadoAnterior_L0+1 
;p3a.c,25 :: 		delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_main7:
	DECFSZ      R13, 1, 1
	BRA         L_main7
	DECFSZ      R12, 1, 1
	BRA         L_main7
	DECFSZ      R11, 1, 1
	BRA         L_main7
	NOP
;p3a.c,27 :: 		}
	GOTO        L_main0
;p3a.c,28 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
