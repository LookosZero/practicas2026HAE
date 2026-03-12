
_interrupt:

;p3c.c,4 :: 		void interrupt(){
;p3c.c,7 :: 		if(INTCON.INT0IF == 1){
	BTFSS       INTCON+0, 1 
	GOTO        L_interrupt0
;p3c.c,8 :: 		if(unidad <= 0){
	MOVLW       0
	MOVWF       R0 
	MOVF        _unidad+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt16
	MOVF        _unidad+0, 0 
	SUBLW       0
L__interrupt16:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt1
;p3c.c,9 :: 		unidad = 9;
	MOVLW       9
	MOVWF       _unidad+0 
	MOVLW       0
	MOVWF       _unidad+1 
;p3c.c,10 :: 		if(decena <= 0){
	MOVLW       0
	MOVWF       R0 
	MOVF        _decena+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt17
	MOVF        _decena+0, 0 
	SUBLW       0
L__interrupt17:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt2
;p3c.c,11 :: 		decena = 9;  // Si está en 00, va a 99
	MOVLW       9
	MOVWF       _decena+0 
	MOVLW       0
	MOVWF       _decena+1 
;p3c.c,12 :: 		}else{
	GOTO        L_interrupt3
L_interrupt2:
;p3c.c,13 :: 		decena--;
	MOVLW       1
	SUBWF       _decena+0, 1 
	MOVLW       0
	SUBWFB      _decena+1, 1 
;p3c.c,14 :: 		}
L_interrupt3:
;p3c.c,15 :: 		}else{
	GOTO        L_interrupt4
L_interrupt1:
;p3c.c,16 :: 		unidad--;
	MOVLW       1
	SUBWF       _unidad+0, 1 
	MOVLW       0
	SUBWFB      _unidad+1, 1 
;p3c.c,17 :: 		}
L_interrupt4:
;p3c.c,18 :: 		INTCON.INT0IF = 0; // Limpiar flag INT0
	BCF         INTCON+0, 1 
;p3c.c,19 :: 		}
L_interrupt0:
;p3c.c,22 :: 		if(INTCON3.INT1IF == 1){
	BTFSS       INTCON3+0, 0 
	GOTO        L_interrupt5
;p3c.c,23 :: 		if(unidad >= 9){
	MOVLW       0
	SUBWF       _unidad+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt18
	MOVLW       9
	SUBWF       _unidad+0, 0 
L__interrupt18:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt6
;p3c.c,24 :: 		unidad = 0;
	CLRF        _unidad+0 
	CLRF        _unidad+1 
;p3c.c,25 :: 		if(decena >= 9){
	MOVLW       0
	SUBWF       _decena+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt19
	MOVLW       9
	SUBWF       _decena+0, 0 
L__interrupt19:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt7
;p3c.c,26 :: 		decena = 0;
	CLRF        _decena+0 
	CLRF        _decena+1 
;p3c.c,27 :: 		}else{
	GOTO        L_interrupt8
L_interrupt7:
;p3c.c,28 :: 		decena ++;
	INFSNZ      _decena+0, 1 
	INCF        _decena+1, 1 
;p3c.c,29 :: 		}
L_interrupt8:
;p3c.c,30 :: 		}else{
	GOTO        L_interrupt9
L_interrupt6:
;p3c.c,31 :: 		unidad++;
	INFSNZ      _unidad+0, 1 
	INCF        _unidad+1, 1 
;p3c.c,32 :: 		}
L_interrupt9:
;p3c.c,33 :: 		INTCON3.INT1IF = 0; // Limpiar flag INT1
	BCF         INTCON3+0, 0 
;p3c.c,34 :: 		}
L_interrupt5:
;p3c.c,35 :: 		}
L_end_interrupt:
L__interrupt15:
	RETFIE      1
; end of _interrupt

_main:

;p3c.c,37 :: 		void main(){
;p3c.c,39 :: 		unsigned int numeros[] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F};
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
	MOVLW       20
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
;p3c.c,41 :: 		ADCON1 = 0x07;
	MOVLW       7
	MOVWF       ADCON1+0 
;p3c.c,42 :: 		TRISD = 0x00;
	CLRF        TRISD+0 
;p3c.c,43 :: 		TRISE.B0 = 0;
	BCF         TRISE+0, 0 
;p3c.c,44 :: 		TRISE.B1 = 0;
	BCF         TRISE+0, 1 
;p3c.c,46 :: 		PORTE.B0 = 1;
	BSF         PORTE+0, 0 
;p3c.c,47 :: 		PORTE.B1 = 1;
	BSF         PORTE+0, 1 
;p3c.c,49 :: 		PORTD = numeros[0];
	MOVF        main_numeros_L0+0, 0 
	MOVWF       PORTD+0 
;p3c.c,52 :: 		TRISB.B0 = 1; //se configura RB0 como entrada
	BSF         TRISB+0, 0 
;p3c.c,53 :: 		INTCON2.INTEDG0 = 1; //la interrupción la provoca un flanco de subida (x=1)/ bajada (x=0)
	BSF         INTCON2+0, 6 
;p3c.c,54 :: 		INTCON.INT0IF = 0; //se pone el flag de la interrupción INT0 a 0
	BCF         INTCON+0, 1 
;p3c.c,55 :: 		INTCON.INT0IE = 1; //se habilita la interrupción INT0
	BSF         INTCON+0, 4 
;p3c.c,58 :: 		TRISB.B1 = 1; // se configura RB1 como entrada
	BSF         TRISB+0, 1 
;p3c.c,59 :: 		INTCON2.INTEDG1 = 1; //la interrupción la provoca un flanco de subida (x=1)/ bajada (x=0)
	BSF         INTCON2+0, 5 
;p3c.c,60 :: 		INTCON3.INT1IF = 0; // se pone el flag de la interrupción INT1 a 0
	BCF         INTCON3+0, 0 
;p3c.c,61 :: 		INTCON3.INT1IE = 1; // se habilita la interrupción INT1
	BSF         INTCON3+0, 3 
;p3c.c,63 :: 		INTCON.GIE = 1; // se habilitan las interrupciones en general
	BSF         INTCON+0, 7 
;p3c.c,66 :: 		while(1){
L_main10:
;p3c.c,68 :: 		PORTE.B1 = 1; // Apagar unidad
	BSF         PORTE+0, 1 
;p3c.c,69 :: 		PORTD = numeros[decena];
	MOVF        _decena+0, 0 
	MOVWF       R0 
	MOVF        _decena+1, 0 
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
	MOVWF       PORTD+0 
;p3c.c,70 :: 		PORTE.B0 = 0; // Encender decena
	BCF         PORTE+0, 0 
;p3c.c,71 :: 		delay_ms(15);
	MOVLW       39
	MOVWF       R12, 0
	MOVLW       245
	MOVWF       R13, 0
L_main12:
	DECFSZ      R13, 1, 1
	BRA         L_main12
	DECFSZ      R12, 1, 1
	BRA         L_main12
;p3c.c,72 :: 		PORTE.B0 = 1; // Apagar decena
	BSF         PORTE+0, 0 
;p3c.c,75 :: 		PORTD = numeros[unidad];
	MOVF        _unidad+0, 0 
	MOVWF       R0 
	MOVF        _unidad+1, 0 
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
	MOVWF       PORTD+0 
;p3c.c,76 :: 		PORTE.B1 = 0; // Encender unidad;
	BCF         PORTE+0, 1 
;p3c.c,77 :: 		delay_ms(15);
	MOVLW       39
	MOVWF       R12, 0
	MOVLW       245
	MOVWF       R13, 0
L_main13:
	DECFSZ      R13, 1, 1
	BRA         L_main13
	DECFSZ      R12, 1, 1
	BRA         L_main13
;p3c.c,78 :: 		PORTE.B1 = 1; // Apagar unidad
	BSF         PORTE+0, 1 
;p3c.c,80 :: 		}
	GOTO        L_main10
;p3c.c,82 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
