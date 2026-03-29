
_vToLux:

;p7d.c,27 :: 		float vToLux(float v){
;p7d.c,28 :: 		float rldr = 15 * pow(10, 3) * ((5/v) - 1);
	MOVLW       0
	MOVWF       FARG_pow_x+0 
	MOVLW       0
	MOVWF       FARG_pow_x+1 
	MOVLW       32
	MOVWF       FARG_pow_x+2 
	MOVLW       130
	MOVWF       FARG_pow_x+3 
	MOVLW       0
	MOVWF       FARG_pow_y+0 
	MOVLW       0
	MOVWF       FARG_pow_y+1 
	MOVLW       64
	MOVWF       FARG_pow_y+2 
	MOVLW       128
	MOVWF       FARG_pow_y+3 
	CALL        _pow+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       112
	MOVWF       R6 
	MOVLW       130
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__vToLux+0 
	MOVF        R1, 0 
	MOVWF       FLOC__vToLux+1 
	MOVF        R2, 0 
	MOVWF       FLOC__vToLux+2 
	MOVF        R3, 0 
	MOVWF       FLOC__vToLux+3 
	MOVF        FARG_vToLux_v+0, 0 
	MOVWF       R4 
	MOVF        FARG_vToLux_v+1, 0 
	MOVWF       R5 
	MOVF        FARG_vToLux_v+2, 0 
	MOVWF       R6 
	MOVF        FARG_vToLux_v+3, 0 
	MOVWF       R7 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       32
	MOVWF       R2 
	MOVLW       129
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       127
	MOVWF       R7 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        FLOC__vToLux+0, 0 
	MOVWF       R4 
	MOVF        FLOC__vToLux+1, 0 
	MOVWF       R5 
	MOVF        FLOC__vToLux+2, 0 
	MOVWF       R6 
	MOVF        FLOC__vToLux+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
;p7d.c,30 :: 		float l = pow((rldr/127410), (-1/0.8582));
	MOVLW       0
	MOVWF       R4 
	MOVLW       217
	MOVWF       R5 
	MOVLW       120
	MOVWF       R6 
	MOVLW       143
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_pow_x+0 
	MOVF        R1, 0 
	MOVWF       FARG_pow_x+1 
	MOVF        R2, 0 
	MOVWF       FARG_pow_x+2 
	MOVF        R3, 0 
	MOVWF       FARG_pow_x+3 
	MOVLW       62
	MOVWF       FARG_pow_y+0 
	MOVLW       38
	MOVWF       FARG_pow_y+1 
	MOVLW       149
	MOVWF       FARG_pow_y+2 
	MOVLW       127
	MOVWF       FARG_pow_y+3 
	CALL        _pow+0, 0
;p7d.c,32 :: 		return l;
;p7d.c,33 :: 		}
L_end_vToLux:
	RETURN      0
; end of _vToLux

_mostrarLCD:

;p7d.c,35 :: 		void mostrarLCD(float value){
;p7d.c,36 :: 		FloatToStr(value, txt);
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
;p7d.c,37 :: 		Lcd_Cmd(_Lcd_Clear);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;p7d.c,38 :: 		Lcd_Out(1,1,txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;p7d.c,39 :: 		}
L_end_mostrarLCD:
	RETURN      0
; end of _mostrarLCD

_interrupt:

;p7d.c,41 :: 		void interrupt(){
;p7d.c,43 :: 		if(PIR1.ADIF == 1){
	BTFSS       PIR1+0, 6 
	GOTO        L_interrupt0
;p7d.c,46 :: 		v0 = (ADRESH << 8) + ADRESL;
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
;p7d.c,47 :: 		vi = v0 * LAMBDA;
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
;p7d.c,49 :: 		lux = vToLux(vi);
	MOVF        R0, 0 
	MOVWF       FARG_vToLux_v+0 
	MOVF        R1, 0 
	MOVWF       FARG_vToLux_v+1 
	MOVF        R2, 0 
	MOVWF       FARG_vToLux_v+2 
	MOVF        R3, 0 
	MOVWF       FARG_vToLux_v+3 
	CALL        _vToLux+0, 0
	MOVF        R0, 0 
	MOVWF       _lux+0 
	MOVF        R1, 0 
	MOVWF       _lux+1 
	MOVF        R2, 0 
	MOVWF       _lux+2 
	MOVF        R3, 0 
	MOVWF       _lux+3 
;p7d.c,50 :: 		mostrarLCD(lux);
	MOVF        R0, 0 
	MOVWF       FARG_mostrarLCD_value+0 
	MOVF        R1, 0 
	MOVWF       FARG_mostrarLCD_value+1 
	MOVF        R2, 0 
	MOVWF       FARG_mostrarLCD_value+2 
	MOVF        R3, 0 
	MOVWF       FARG_mostrarLCD_value+3 
	CALL        _mostrarLCD+0, 0
;p7d.c,53 :: 		T0CON.TMR0ON = 1;
	BSF         T0CON+0, 7 
;p7d.c,54 :: 		TMR0H = (ALFA >> 8);
	MOVLW       11
	MOVWF       TMR0H+0 
;p7d.c,55 :: 		TMR0L = ALFA;
	MOVLW       220
	MOVWF       TMR0L+0 
;p7d.c,58 :: 		ADCON0.ADON = 0;
	BCF         ADCON0+0, 0 
;p7d.c,59 :: 		ADCON0.GO = 0;
	BCF         ADCON0+0, 2 
;p7d.c,60 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;p7d.c,61 :: 		}
L_interrupt0:
;p7d.c,63 :: 		if(INTCON.TMR0IF == 1){
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt1
;p7d.c,66 :: 		ADCON0.ADON = 1;
	BSF         ADCON0+0, 0 
;p7d.c,67 :: 		ADCON0.GO = 1;
	BSF         ADCON0+0, 2 
;p7d.c,70 :: 		T0CON.TMR0ON = 0;
	BCF         T0CON+0, 7 
;p7d.c,71 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;p7d.c,72 :: 		}
L_interrupt1:
;p7d.c,73 :: 		}
L_end_interrupt:
L__interrupt7:
	RETFIE      1
; end of _interrupt

_main:

;p7d.c,75 :: 		void main(){
;p7d.c,76 :: 		Lcd_init();
	CALL        _Lcd_Init+0, 0
;p7d.c,79 :: 		TRISB.B0 = 0;
	BCF         TRISB+0, 0 
;p7d.c,80 :: 		TRISE.B1 = 1;
	BSF         TRISE+0, 1 
;p7d.c,83 :: 		ADCON0 = 0x71;
	MOVLW       113
	MOVWF       ADCON0+0 
;p7d.c,84 :: 		ADCON1 = 0xC0;
	MOVLW       192
	MOVWF       ADCON1+0 
;p7d.c,87 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;p7d.c,88 :: 		PIE1.ADIE = 1;
	BSF         PIE1+0, 6 
;p7d.c,89 :: 		INTCON.PEIE = 1;
	BSF         INTCON+0, 6 
;p7d.c,92 :: 		T0CON = 0x84;
	MOVLW       132
	MOVWF       T0CON+0 
;p7d.c,93 :: 		TMR0H = (ALFA >> 8);
	MOVLW       11
	MOVWF       TMR0H+0 
;p7d.c,94 :: 		TMR0L = ALFA;
	MOVLW       220
	MOVWF       TMR0L+0 
;p7d.c,97 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;p7d.c,98 :: 		INTCON.TMR0IE = 1;
	BSF         INTCON+0, 5 
;p7d.c,101 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;p7d.c,104 :: 		ADCON0.GO = 1;
	BSF         ADCON0+0, 2 
;p7d.c,106 :: 		while(1){
L_main2:
;p7d.c,108 :: 		}
	GOTO        L_main2
;p7d.c,109 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
