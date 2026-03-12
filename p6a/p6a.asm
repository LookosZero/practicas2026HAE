
_interrupt:

;p6a.c,22 :: 		void interrupt(){
;p6a.c,24 :: 		vi = ADRESL;
	MOVF        ADRESL+0, 0 
	MOVWF       _vi+0 
	MOVLW       0
	MOVWF       _vi+1 
;p6a.c,25 :: 		vi = vi + (ADRESH << 8);
	MOVF        ADRESH+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        _vi+0, 0 
	ADDWF       R0, 1 
	MOVF        _vi+1, 0 
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       _vi+0 
	MOVF        R1, 0 
	MOVWF       _vi+1 
;p6a.c,26 :: 		aux = vi * res;
	CALL        _int2double+0, 0
	MOVF        _res+0, 0 
	MOVWF       R4 
	MOVF        _res+1, 0 
	MOVWF       R5 
	MOVF        _res+2, 0 
	MOVWF       R6 
	MOVF        _res+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _aux+0 
	MOVF        R1, 0 
	MOVWF       _aux+1 
	MOVF        R2, 0 
	MOVWF       _aux+2 
	MOVF        R3, 0 
	MOVWF       _aux+3 
;p6a.c,28 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;p6a.c,30 :: 		FloatToStr(aux,txt);
	MOVF        _aux+0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        _aux+1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        _aux+2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        _aux+3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       _txt+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;p6a.c,32 :: 		Lcd_Out(1,3,txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;p6a.c,34 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;p6a.c,35 :: 		}
L_end_interrupt:
L__interrupt4:
	RETFIE      1
; end of _interrupt

_main:

;p6a.c,37 :: 		void main(){
;p6a.c,38 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;p6a.c,39 :: 		ADCON0 = 0x59;
	MOVLW       89
	MOVWF       ADCON0+0 
;p6a.c,40 :: 		ADCON1 = 0xC0;
	MOVLW       192
	MOVWF       ADCON1+0 
;p6a.c,42 :: 		TRISA.B3 = 1;
	BSF         TRISA+0, 3 
;p6a.c,43 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;p6a.c,44 :: 		PIE1.ADIE = 1;
	BSF         PIE1+0, 6 
;p6a.c,45 :: 		INTCON.PEIE = 1;
	BSF         INTCON+0, 6 
;p6a.c,46 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;p6a.c,48 :: 		while(1){
L_main0:
;p6a.c,50 :: 		ADCON0.GO = 1;
	BSF         ADCON0+0, 2 
;p6a.c,51 :: 		delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	DECFSZ      R11, 1, 1
	BRA         L_main2
	NOP
	NOP
;p6a.c,54 :: 		}
	GOTO        L_main0
;p6a.c,56 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
