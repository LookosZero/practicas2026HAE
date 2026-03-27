
_interrupt:

;p4b.c,23 :: 		void interrupt(){
;p4b.c,25 :: 		if(candado == false) {
	MOVF        _candado+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt0
;p4b.c,29 :: 		numero++;
	INCF        interrupt_numero_L1+0, 1 
;p4b.c,30 :: 		if(numero >= 20){
	MOVLW       20
	SUBWF       interrupt_numero_L1+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt1
;p4b.c,31 :: 		numero = 0;
	CLRF        interrupt_numero_L1+0 
;p4b.c,32 :: 		}
L_interrupt1:
;p4b.c,34 :: 		ByteToStr(numero, txt);
	MOVF        interrupt_numero_L1+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       interrupt_txt_L1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(interrupt_txt_L1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;p4b.c,36 :: 		Lcd_out(1, 1, txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       interrupt_txt_L1+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(interrupt_txt_L1+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;p4b.c,37 :: 		candado = true;
	MOVLW       1
	MOVWF       _candado+0 
;p4b.c,38 :: 		} else {
	GOTO        L_interrupt2
L_interrupt0:
;p4b.c,39 :: 		candado = false;
	CLRF        _candado+0 
;p4b.c,40 :: 		}
L_interrupt2:
;p4b.c,42 :: 		x = PORTB; // Hay que leer el puerto B antes de borrar el flag
	MOVF        PORTB+0, 0 
	MOVWF       _x+0 
	MOVLW       0
	MOVWF       _x+1 
;p4b.c,43 :: 		INTCON.RBIF = 0; // Se borra el flag
	BCF         INTCON+0, 0 
;p4b.c,44 :: 		}
L_end_interrupt:
L__interrupt6:
	RETFIE      1
; end of _interrupt

_main:

;p4b.c,46 :: 		void main(){
;p4b.c,47 :: 		ADCON1 = 0x07;
	MOVLW       7
	MOVWF       ADCON1+0 
;p4b.c,48 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;p4b.c,50 :: 		TRISB.B5 = 1;
	BSF         TRISB+0, 5 
;p4b.c,51 :: 		x = PORTB;
	MOVF        PORTB+0, 0 
	MOVWF       _x+0 
	MOVLW       0
	MOVWF       _x+1 
;p4b.c,52 :: 		INTCON.RBIF = 0; // Se pone el flag a 0
	BCF         INTCON+0, 0 
;p4b.c,53 :: 		INTCON.RBIE = 1; // Se habilita la interrupción por cambio de nivel
	BSF         INTCON+0, 3 
;p4b.c,54 :: 		INTCON.GIE = 1; // Se habilitan las interrupciones en general
	BSF         INTCON+0, 7 
;p4b.c,56 :: 		while(1){
L_main3:
;p4b.c,58 :: 		}
	GOTO        L_main3
;p4b.c,59 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
