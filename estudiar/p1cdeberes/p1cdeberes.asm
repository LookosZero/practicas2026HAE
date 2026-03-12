
_main:

;p1cdeberes.c,1 :: 		void main() {
;p1cdeberes.c,2 :: 		int secuencia[14] = {0xFE,0xFD,0xFB,0xF7,0xEF,0xDF,0xBF,0x7F,0xBF,0xDF,0xEF,0xF7,0xFB,0xFD};
	MOVLW       ?ICSmain_secuencia_L0+0
	MOVWF       TBLPTRL+0 
	MOVLW       hi_addr(?ICSmain_secuencia_L0+0)
	MOVWF       TBLPTRL+1 
	MOVLW       higher_addr(?ICSmain_secuencia_L0+0)
	MOVWF       TBLPTRL+2 
	MOVLW       main_secuencia_L0+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(main_secuencia_L0+0)
	MOVWF       FSR1L+1 
	MOVLW       30
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
;p1cdeberes.c,5 :: 		TRISB.B3 = 1;
	BSF         TRISB+0, 3 
;p1cdeberes.c,6 :: 		TRISC = 0;
	CLRF        TRISC+0 
;p1cdeberes.c,7 :: 		PORTC = 0;
	CLRF        PORTC+0 
;p1cdeberes.c,9 :: 		while(1)
L_main0:
;p1cdeberes.c,12 :: 		if(PORTB.B3 == 1) {
	BTFSS       PORTB+0, 3 
	GOTO        L_main2
;p1cdeberes.c,14 :: 		PORTC = secuencia[i];
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVF        main_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       main_secuencia_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(main_secuencia_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       PORTC+0 
;p1cdeberes.c,15 :: 		i++;
	INFSNZ      main_i_L0+0, 1 
	INCF        main_i_L0+1, 1 
;p1cdeberes.c,18 :: 		if(i>=14) {
	MOVLW       128
	XORWF       main_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main6
	MOVLW       14
	SUBWF       main_i_L0+0, 0 
L__main6:
	BTFSS       STATUS+0, 0 
	GOTO        L_main3
;p1cdeberes.c,19 :: 		i = 0;
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
;p1cdeberes.c,20 :: 		}
L_main3:
;p1cdeberes.c,23 :: 		delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_main4:
	DECFSZ      R13, 1, 1
	BRA         L_main4
	DECFSZ      R12, 1, 1
	BRA         L_main4
	DECFSZ      R11, 1, 1
	BRA         L_main4
	NOP
;p1cdeberes.c,24 :: 		}
L_main2:
;p1cdeberes.c,25 :: 		}
	GOTO        L_main0
;p1cdeberes.c,26 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
