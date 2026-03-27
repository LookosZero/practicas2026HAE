
_main:

;p1b.c,1 :: 		void main() {
;p1b.c,4 :: 		int LED[] = {0x01,0x03,0x07,0x0F,0x1F,0x3F,0x7F,0xFF,0x00};
	MOVLW       ?ICSmain_LED_L0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICSmain_LED_L0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICSmain_LED_L0+0)
	MOVWF       TBLPTRU 
	MOVLW       main_LED_L0+0
	MOVWF       FSR1 
	MOVLW       hi_addr(main_LED_L0+0)
	MOVWF       FSR1H 
	MOVLW       20
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
;p1b.c,9 :: 		ADCON1 = 0x07;
	MOVLW       7
	MOVWF       ADCON1+0 
;p1b.c,12 :: 		TRISC = 0x00;
	CLRF        TRISC+0 
;p1b.c,16 :: 		while(1){
L_main0:
;p1b.c,19 :: 		PORTC = LED[i];
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVF        main_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       main_LED_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(main_LED_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       PORTC+0 
;p1b.c,20 :: 		delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	DECFSZ      R11, 1, 1
	BRA         L_main2
	NOP
;p1b.c,21 :: 		i++;
	INFSNZ      main_i_L0+0, 1 
	INCF        main_i_L0+1, 1 
;p1b.c,23 :: 		if(i>8){
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       main_i_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main5
	MOVF        main_i_L0+0, 0 
	SUBLW       8
L__main5:
	BTFSC       STATUS+0, 0 
	GOTO        L_main3
;p1b.c,24 :: 		i = 0;
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
;p1b.c,25 :: 		}
L_main3:
;p1b.c,27 :: 		}
	GOTO        L_main0
;p1b.c,30 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
