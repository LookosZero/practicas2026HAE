
_main:

;p1d.c,1 :: 		void main() {
;p1d.c,3 :: 		int LEDS[] = {0xFE, 0xFD, 0xFB, 0xF7, 0xEF, 0xDF, 0xBF, 0x7F};
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
	MOVLW       20
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
;p1d.c,7 :: 		ADCON1 = 0x07;
	MOVLW       7
	MOVWF       ADCON1+0 
;p1d.c,9 :: 		TRISC = 0x00; // Pines C configurados como salidas
	CLRF        TRISC+0 
;p1d.c,11 :: 		TRISB.B3 = 1; // Pin B3 configurado como entrada
	BSF         TRISB+0, 3 
;p1d.c,14 :: 		while(1){
L_main0:
;p1d.c,15 :: 		if(PORTB.B3 == 0){
	BTFSC       PORTB+0, 3 
	GOTO        L_main2
;p1d.c,16 :: 		PORTC = LEDS[i];
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
;p1d.c,17 :: 		delay_ms(100);
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
;p1d.c,19 :: 		i = i + direccion;
	MOVF        main_direccion_L0+0, 0 
	ADDWF       main_i_L0+0, 0 
	MOVWF       R1 
	MOVF        main_direccion_L0+1, 0 
	ADDWFC      main_i_L0+1, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       main_i_L0+0 
	MOVF        R2, 0 
	MOVWF       main_i_L0+1 
;p1d.c,21 :: 		if(i >= 7){
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main9
	MOVLW       7
	SUBWF       R1, 0 
L__main9:
	BTFSS       STATUS+0, 0 
	GOTO        L_main4
;p1d.c,22 :: 		direccion = -1;
	MOVLW       255
	MOVWF       main_direccion_L0+0 
	MOVLW       255
	MOVWF       main_direccion_L0+1 
;p1d.c,23 :: 		}else if(i<=0){
	GOTO        L_main5
L_main4:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       main_i_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main10
	MOVF        main_i_L0+0, 0 
	SUBLW       0
L__main10:
	BTFSS       STATUS+0, 0 
	GOTO        L_main6
;p1d.c,24 :: 		direccion = 1;
	MOVLW       1
	MOVWF       main_direccion_L0+0 
	MOVLW       0
	MOVWF       main_direccion_L0+1 
;p1d.c,25 :: 		}
L_main6:
L_main5:
;p1d.c,26 :: 		}else{
	GOTO        L_main7
L_main2:
;p1d.c,27 :: 		PORTC = 0xFF;
	MOVLW       255
	MOVWF       PORTC+0 
;p1d.c,28 :: 		}
L_main7:
;p1d.c,30 :: 		}
	GOTO        L_main0
;p1d.c,31 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
