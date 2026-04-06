
_main:

;p2b.c,1 :: 		void main(){
;p2b.c,2 :: 		unsigned int numeros[] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F};
	MOVLW       ?ICSmain_numeros_L0+0
	MOVWF       TBLPTRL+0 
	MOVLW       hi_addr(?ICSmain_numeros_L0+0)
	MOVWF       TBLPTRL+1 
	MOVLW       higher_addr(?ICSmain_numeros_L0+0)
	MOVWF       TBLPTRL+2 
	MOVLW       main_numeros_L0+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(main_numeros_L0+0)
	MOVWF       FSR1L+1 
	MOVLW       30
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
;p2b.c,9 :: 		ADCON1 = 0x07;
	MOVLW       7
	MOVWF       ADCON1+0 
;p2b.c,10 :: 		TRISB = 0xFF;
	MOVLW       255
	MOVWF       TRISB+0 
;p2b.c,11 :: 		TRISC = 0x00;
	CLRF        TRISC+0 
;p2b.c,12 :: 		TRISD = 0x00;
	CLRF        TRISD+0 
;p2b.c,14 :: 		PORTD = 0x0F;
	MOVLW       15
	MOVWF       PORTD+0 
;p2b.c,15 :: 		PORTC = 0x00;
	CLRF        PORTC+0 
;p2b.c,17 :: 		while(1){
L_main0:
;p2b.c,18 :: 		valor = PORTB;
	MOVF        PORTB+0, 0 
	MOVWF       main_valor_L0+0 
	MOVLW       0
	MOVWF       main_valor_L0+1 
;p2b.c,19 :: 		temp = valor;
	MOVF        main_valor_L0+0, 0 
	MOVWF       main_temp_L0+0 
	MOVF        main_valor_L0+1, 0 
	MOVWF       main_temp_L0+1 
;p2b.c,21 :: 		for(i = 0; i < 4; i++){
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
L_main2:
	MOVLW       0
	SUBWF       main_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main10
	MOVLW       4
	SUBWF       main_i_L0+0, 0 
L__main10:
	BTFSC       STATUS+0, 0 
	GOTO        L_main3
;p2b.c,22 :: 		digito[i] = temp % 10;
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVF        main_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       main_digito_L0+0
	ADDWF       R0, 0 
	MOVWF       FLOC__main+0 
	MOVLW       hi_addr(main_digito_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__main+1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        main_temp_L0+0, 0 
	MOVWF       R0 
	MOVF        main_temp_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVFF       FLOC__main+0, FSR1L+0
	MOVFF       FLOC__main+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;p2b.c,23 :: 		temp = temp / 10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        main_temp_L0+0, 0 
	MOVWF       R0 
	MOVF        main_temp_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       main_temp_L0+0 
	MOVF        R1, 0 
	MOVWF       main_temp_L0+1 
;p2b.c,21 :: 		for(i = 0; i < 4; i++){
	INFSNZ      main_i_L0+0, 1 
	INCF        main_i_L0+1, 1 
;p2b.c,24 :: 		}
	GOTO        L_main2
L_main3:
;p2b.c,26 :: 		for(i = 0; i < 4; i++){
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
L_main5:
	MOVLW       0
	SUBWF       main_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main11
	MOVLW       4
	SUBWF       main_i_L0+0, 0 
L__main11:
	BTFSC       STATUS+0, 0 
	GOTO        L_main6
;p2b.c,27 :: 		PORTD = 0x0F;
	MOVLW       15
	MOVWF       PORTD+0 
;p2b.c,29 :: 		PORTC = numeros[digito[i]];
	MOVF        main_i_L0+0, 0 
	MOVWF       R5 
	MOVF        main_i_L0+1, 0 
	MOVWF       R6 
	RLCF        R5, 1 
	BCF         R5, 0 
	RLCF        R6, 1 
	MOVLW       main_digito_L0+0
	ADDWF       R5, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(main_digito_L0+0)
	ADDWFC      R6, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       main_numeros_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(main_numeros_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       PORTC+0 
;p2b.c,31 :: 		PORTD = led[i];
	MOVLW       main_led_L0+0
	ADDWF       R5, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(main_led_L0+0)
	ADDWFC      R6, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       PORTD+0 
;p2b.c,33 :: 		delay_ms(15);
	MOVLW       39
	MOVWF       R12, 0
	MOVLW       245
	MOVWF       R13, 0
L_main8:
	DECFSZ      R13, 1, 1
	BRA         L_main8
	DECFSZ      R12, 1, 1
	BRA         L_main8
;p2b.c,26 :: 		for(i = 0; i < 4; i++){
	INFSNZ      main_i_L0+0, 1 
	INCF        main_i_L0+1, 1 
;p2b.c,35 :: 		}
	GOTO        L_main5
L_main6:
;p2b.c,36 :: 		}
	GOTO        L_main0
;p2b.c,37 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
