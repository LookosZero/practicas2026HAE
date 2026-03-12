
_main:

;p1c.c,1 :: 		void main() {
;p1c.c,3 :: 		int LEDS[] = {0xFE, 0xFD, 0xFB, 0xF7, 0xEF, 0xDF, 0xBF, 0x7F};
	MOVLW       ?ICSmain_LEDS_L0+0
	MOVWF       TBLPTRL+0 
	MOVLW       hi_addr(?ICSmain_LEDS_L0+0)
	MOVWF       TBLPTRL+1 
	MOVLW       higher_addr(?ICSmain_LEDS_L0+0)
	MOVWF       TBLPTRL+2 
	MOVLW       main_LEDS_L0+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(main_LEDS_L0+0)
	MOVWF       FSR1L+1 
	MOVLW       18
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
;p1c.c,6 :: 		ADCON1 = 0x07;
	MOVLW       7
	MOVWF       ADCON1+0 
;p1c.c,8 :: 		TRISC = 0x00;
	CLRF        TRISC+0 
;p1c.c,10 :: 		TRISB.B3 = 1;
	BSF         TRISB+0, 3 
;p1c.c,12 :: 		PORTC = 0xFF;
	MOVLW       255
	MOVWF       PORTC+0 
;p1c.c,14 :: 		while(1){
L_main0:
;p1c.c,16 :: 		if(PORTB.B3 == 1){
	BTFSS       PORTB+0, 3 
	GOTO        L_main2
;p1c.c,18 :: 		PORTC = LEDS[i];
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVF        main_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       main_LEDS_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(main_LEDS_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       PORTC+0 
;p1c.c,19 :: 		delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_main3:
	DECFSZ      R13, 1, 1
	BRA         L_main3
	DECFSZ      R12, 1, 1
	BRA         L_main3
	DECFSZ      R11, 1, 1
	BRA         L_main3
	NOP
;p1c.c,20 :: 		i++;
	INFSNZ      main_i_L0+0, 1 
	INCF        main_i_L0+1, 1 
;p1c.c,22 :: 		if(i >= 8){
	MOVLW       128
	XORWF       main_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main8
	MOVLW       8
	SUBWF       main_i_L0+0, 0 
L__main8:
	BTFSS       STATUS+0, 0 
	GOTO        L_main4
;p1c.c,23 :: 		i = 0;
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
;p1c.c,24 :: 		}
L_main4:
;p1c.c,25 :: 		}else{
	GOTO        L_main5
L_main2:
;p1c.c,26 :: 		PORTC = 0xFF;
	MOVLW       255
	MOVWF       PORTC+0 
;p1c.c,27 :: 		i = 0;
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
;p1c.c,28 :: 		delay_ms(10);
	MOVLW       26
	MOVWF       R12, 0
	MOVLW       248
	MOVWF       R13, 0
L_main6:
	DECFSZ      R13, 1, 1
	BRA         L_main6
	DECFSZ      R12, 1, 1
	BRA         L_main6
	NOP
;p1c.c,29 :: 		}
L_main5:
;p1c.c,31 :: 		}
	GOTO        L_main0
;p1c.c,34 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
