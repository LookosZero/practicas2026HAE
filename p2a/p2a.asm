
_main:

;p2a.c,1 :: 		void main(){
;p2a.c,2 :: 		unsigned char numeros[] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F};
	MOVLW       63
	MOVWF       main_numeros_L0+0 
	MOVLW       6
	MOVWF       main_numeros_L0+1 
	MOVLW       91
	MOVWF       main_numeros_L0+2 
	MOVLW       79
	MOVWF       main_numeros_L0+3 
	MOVLW       102
	MOVWF       main_numeros_L0+4 
	MOVLW       109
	MOVWF       main_numeros_L0+5 
	MOVLW       125
	MOVWF       main_numeros_L0+6 
	MOVLW       7
	MOVWF       main_numeros_L0+7 
	MOVLW       127
	MOVWF       main_numeros_L0+8 
	MOVLW       111
	MOVWF       main_numeros_L0+9 
	CLRF        main_unidades_L0+0 
	CLRF        main_decenas_L0+0 
	CLRF        main_contador_L0+0 
	CLRF        main_contador_L0+1 
;p2a.c,7 :: 		ADCON1 = 0x07;
	MOVLW       7
	MOVWF       ADCON1+0 
;p2a.c,8 :: 		TRISA.B0 = 0;
	BCF         TRISA+0, 0 
;p2a.c,9 :: 		TRISA.B1 = 0;
	BCF         TRISA+0, 1 
;p2a.c,10 :: 		TRISD = 0x00;
	CLRF        TRISD+0 
;p2a.c,12 :: 		PORTA.B0 = 0;
	BCF         PORTA+0, 0 
;p2a.c,13 :: 		PORTA.B0 = 0;
	BCF         PORTA+0, 0 
;p2a.c,15 :: 		PORTD = 0x00;
	CLRF        PORTD+0 
;p2a.c,17 :: 		while(1){
L_main0:
;p2a.c,22 :: 		PORTA.B1 = 1;  // Apaga decenas primero
	BSF         PORTA+0, 1 
;p2a.c,23 :: 		PORTD = numeros[unidades];
	MOVLW       main_numeros_L0+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(main_numeros_L0+0)
	MOVWF       FSR0L+1 
	MOVF        main_unidades_L0+0, 0 
	ADDWF       FSR0L+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0L+1, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       PORTD+0 
;p2a.c,24 :: 		PORTA.B0 = 0;  // Enciende unidades
	BCF         PORTA+0, 0 
;p2a.c,25 :: 		delay_ms(20);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	NOP
	NOP
;p2a.c,28 :: 		PORTA.B0 = 1;  // Apaga unidades primero
	BSF         PORTA+0, 0 
;p2a.c,29 :: 		PORTD = numeros[decenas];
	MOVLW       main_numeros_L0+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(main_numeros_L0+0)
	MOVWF       FSR0L+1 
	MOVF        main_decenas_L0+0, 0 
	ADDWF       FSR0L+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0L+1, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       PORTD+0 
;p2a.c,30 :: 		PORTA.B1 = 0;  // Enciende decenas
	BCF         PORTA+0, 1 
;p2a.c,31 :: 		delay_ms(20);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main3:
	DECFSZ      R13, 1, 1
	BRA         L_main3
	DECFSZ      R12, 1, 1
	BRA         L_main3
	NOP
	NOP
;p2a.c,34 :: 		contador++;
	INFSNZ      main_contador_L0+0, 1 
	INCF        main_contador_L0+1, 1 
;p2a.c,37 :: 		if(contador >= 25){
	MOVLW       0
	SUBWF       main_contador_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main8
	MOVLW       25
	SUBWF       main_contador_L0+0, 0 
L__main8:
	BTFSS       STATUS+0, 0 
	GOTO        L_main4
;p2a.c,38 :: 		contador = 0;
	CLRF        main_contador_L0+0 
	CLRF        main_contador_L0+1 
;p2a.c,39 :: 		unidades++;
	INCF        main_unidades_L0+0, 1 
;p2a.c,42 :: 		if(unidades >= 10){
	MOVLW       10
	SUBWF       main_unidades_L0+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main5
;p2a.c,43 :: 		unidades = 0;
	CLRF        main_unidades_L0+0 
;p2a.c,44 :: 		decenas++;
	INCF        main_decenas_L0+0, 1 
;p2a.c,47 :: 		if(decenas >= 6){
	MOVLW       6
	SUBWF       main_decenas_L0+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main6
;p2a.c,48 :: 		decenas = 0;
	CLRF        main_decenas_L0+0 
;p2a.c,49 :: 		}
L_main6:
;p2a.c,50 :: 		}
L_main5:
;p2a.c,51 :: 		}
L_main4:
;p2a.c,52 :: 		}
	GOTO        L_main0
;p2a.c,53 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
