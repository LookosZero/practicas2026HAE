
_interrupt:

;p4c.c,25 :: 		void interrupt(){
;p4c.c,28 :: 		if(candado == false) {
	MOVF        _candado+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt0
;p4c.c,29 :: 		escribir = true;
	MOVLW       1
	MOVWF       _escribir+0 
;p4c.c,30 :: 		candado = true;
	MOVLW       1
	MOVWF       _candado+0 
;p4c.c,31 :: 		} else {
	GOTO        L_interrupt1
L_interrupt0:
;p4c.c,32 :: 		candado = false;
	CLRF        _candado+0 
;p4c.c,33 :: 		}
L_interrupt1:
;p4c.c,35 :: 		x = PORTB; // Hay que leer el puerto B antes de borrar el flag
	MOVF        PORTB+0, 0 
	MOVWF       _x+0 
	MOVLW       0
	MOVWF       _x+1 
;p4c.c,36 :: 		INTCON.RBIF = 0; // se borra el flag
	BCF         INTCON+0, 0 
;p4c.c,37 :: 		}
L_end_interrupt:
L__interrupt7:
	RETFIE      1
; end of _interrupt

_main:

;p4c.c,39 :: 		void main(){
;p4c.c,40 :: 		unsigned short numero = 0;
	CLRF        main_numero_L0+0 
;p4c.c,43 :: 		ADCON1 = 0x07;
	MOVLW       7
	MOVWF       ADCON1+0 
;p4c.c,44 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;p4c.c,46 :: 		TRISB.B5 = 1; // x = 4, 5, 6, 7
	BSF         TRISB+0, 5 
;p4c.c,47 :: 		x = PORTB;
	MOVF        PORTB+0, 0 
	MOVWF       _x+0 
	MOVLW       0
	MOVWF       _x+1 
;p4c.c,48 :: 		INTCON.RBIF = 0; // Se pone el flag a 0
	BCF         INTCON+0, 0 
;p4c.c,49 :: 		INTCON.RBIE = 1; // Se habilita la interrupción por cambio de nivel
	BSF         INTCON+0, 3 
;p4c.c,50 :: 		INTCON.GIE = 1; // Se habilitan las interrupciones en general
	BSF         INTCON+0, 7 
;p4c.c,52 :: 		Lcd_Out(1, 1, "Turno:   0");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_p4c+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_p4c+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;p4c.c,55 :: 		while(1){
L_main2:
;p4c.c,56 :: 		if(escribir == true){
	MOVF        _escribir+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main4
;p4c.c,57 :: 		numero++;
	INCF        main_numero_L0+0, 1 
;p4c.c,58 :: 		if(numero >= 20){
	MOVLW       20
	SUBWF       main_numero_L0+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main5
;p4c.c,59 :: 		numero = 0;
	CLRF        main_numero_L0+0 
;p4c.c,60 :: 		}
L_main5:
;p4c.c,62 :: 		ByteToStr(numero, txt);
	MOVF        main_numero_L0+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       main_txt_L0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;p4c.c,63 :: 		Lcd_Out(1, 8, txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       8
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_txt_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;p4c.c,64 :: 		escribir = false;
	CLRF        _escribir+0 
;p4c.c,65 :: 		}
L_main4:
;p4c.c,66 :: 		}
	GOTO        L_main2
;p4c.c,67 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
