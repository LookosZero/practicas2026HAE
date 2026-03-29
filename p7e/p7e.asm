
_mostrarLCD:

;p7e.c,27 :: 		void mostrarLCD(float value){
;p7e.c,28 :: 		Lcd_Cmd(_Lcd_Clear);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;p7e.c,29 :: 		FloatToStr(value, txt);
	MOVF        FARG_mostrarLCD_value+0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        FARG_mostrarLCD_value+1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        FARG_mostrarLCD_value+2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        FARG_mostrarLCD_value+3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       _txt+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;p7e.c,30 :: 		Lcd_Out(1, 3, txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;p7e.c,31 :: 		}
L_end_mostrarLCD:
	RETURN      0
; end of _mostrarLCD

_vToPa:

;p7e.c,33 :: 		float vToPa(float v){
;p7e.c,34 :: 		return 54.2 * v - 14.11;
	MOVLW       205
	MOVWF       R0 
	MOVLW       204
	MOVWF       R1 
	MOVLW       88
	MOVWF       R2 
	MOVLW       132
	MOVWF       R3 
	MOVF        FARG_vToPa_v+0, 0 
	MOVWF       R4 
	MOVF        FARG_vToPa_v+1, 0 
	MOVWF       R5 
	MOVF        FARG_vToPa_v+2, 0 
	MOVWF       R6 
	MOVF        FARG_vToPa_v+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       143
	MOVWF       R4 
	MOVLW       194
	MOVWF       R5 
	MOVLW       97
	MOVWF       R6 
	MOVLW       130
	MOVWF       R7 
	CALL        _Sub_32x32_FP+0, 0
;p7e.c,35 :: 		}
L_end_vToPa:
	RETURN      0
; end of _vToPa

_interrupt:

;p7e.c,37 :: 		void interrupt(){
;p7e.c,39 :: 		if(PIR1.ADIF == 1){
	BTFSS       PIR1+0, 6 
	GOTO        L_interrupt0
;p7e.c,42 :: 		v0 = (ADRESH << 8) + ADRESL;
	MOVF        ADRESH+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        ADRESL+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       _v0+0 
	MOVF        R1, 0 
	MOVWF       _v0+1 
;p7e.c,43 :: 		vi = v0 * LAMBDA;
	CALL        _int2double+0, 0
	MOVLW       82
	MOVWF       R4 
	MOVLW       39
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       119
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _vi+0 
	MOVF        R1, 0 
	MOVWF       _vi+1 
	MOVF        R2, 0 
	MOVWF       _vi+2 
	MOVF        R3, 0 
	MOVWF       _vi+3 
;p7e.c,45 :: 		pa = vToPa(vi);
	MOVF        R0, 0 
	MOVWF       FARG_vToPa_v+0 
	MOVF        R1, 0 
	MOVWF       FARG_vToPa_v+1 
	MOVF        R2, 0 
	MOVWF       FARG_vToPa_v+2 
	MOVF        R3, 0 
	MOVWF       FARG_vToPa_v+3 
	CALL        _vToPa+0, 0
	MOVF        R0, 0 
	MOVWF       _pa+0 
	MOVF        R1, 0 
	MOVWF       _pa+1 
	MOVF        R2, 0 
	MOVWF       _pa+2 
	MOVF        R3, 0 
	MOVWF       _pa+3 
;p7e.c,47 :: 		mostrarLCD(pa);
	MOVF        R0, 0 
	MOVWF       FARG_mostrarLCD_value+0 
	MOVF        R1, 0 
	MOVWF       FARG_mostrarLCD_value+1 
	MOVF        R2, 0 
	MOVWF       FARG_mostrarLCD_value+2 
	MOVF        R3, 0 
	MOVWF       FARG_mostrarLCD_value+3 
	CALL        _mostrarLCD+0, 0
;p7e.c,50 :: 		T0CON.TMR0ON = 1;
	BSF         T0CON+0, 7 
;p7e.c,51 :: 		TMR0H = (ALFA >> 8);
	MOVLW       11
	MOVWF       TMR0H+0 
;p7e.c,52 :: 		TMR0L = ALFA;
	MOVLW       220
	MOVWF       TMR0L+0 
;p7e.c,55 :: 		ADCON0.ADON = 0;
	BCF         ADCON0+0, 0 
;p7e.c,56 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;p7e.c,57 :: 		}
L_interrupt0:
;p7e.c,59 :: 		if(INTCON.TMR0IF == 1){
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt1
;p7e.c,62 :: 		ADCON0.ADON = 1;
	BSF         ADCON0+0, 0 
;p7e.c,63 :: 		ADCON0.GO = 1;
	BSF         ADCON0+0, 2 
;p7e.c,66 :: 		T0CON.TMR0ON = 0;
	BCF         T0CON+0, 7 
;p7e.c,67 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;p7e.c,68 :: 		}
L_interrupt1:
;p7e.c,69 :: 		}
L_end_interrupt:
L__interrupt7:
	RETFIE      1
; end of _interrupt

_main:

;p7e.c,71 :: 		void main(){
;p7e.c,72 :: 		Lcd_init();
	CALL        _Lcd_Init+0, 0
;p7e.c,75 :: 		TRISB.B0 = 0;
	BCF         TRISB+0, 0 
;p7e.c,76 :: 		TRISB.B1 = 1;
	BSF         TRISB+0, 1 
;p7e.c,77 :: 		TRISE.B2 = 1;
	BSF         TRISE+0, 2 
;p7e.c,80 :: 		ADCON0 = 0x79;
	MOVLW       121
	MOVWF       ADCON0+0 
;p7e.c,81 :: 		ADCON1 = 0xC0;
	MOVLW       192
	MOVWF       ADCON1+0 
;p7e.c,84 :: 		INTCON.PEIE = 1;
	BSF         INTCON+0, 6 
;p7e.c,87 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;p7e.c,88 :: 		PIE1.ADIE = 1;
	BSF         PIE1+0, 6 
;p7e.c,91 :: 		T0CON = 0x83;
	MOVLW       131
	MOVWF       T0CON+0 
;p7e.c,92 :: 		TMR0H = (ALFA >> 8);
	MOVLW       11
	MOVWF       TMR0H+0 
;p7e.c,93 :: 		TMR0L = ALFA;
	MOVLW       220
	MOVWF       TMR0L+0 
;p7e.c,96 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;p7e.c,97 :: 		INTCON.TMR0IE = 1;
	BSF         INTCON+0, 5 
;p7e.c,100 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;p7e.c,103 :: 		ADCON0.GO = 1;
	BSF         ADCON0+0, 2 
;p7e.c,105 :: 		while(1){
L_main2:
;p7e.c,107 :: 		}
	GOTO        L_main2
;p7e.c,108 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
