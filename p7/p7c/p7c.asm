
_interrupt:

;p7c.c,23 :: 		void interrupt(){
;p7c.c,25 :: 		if(PIR1.ADIF == 1){
	BTFSS       PIR1+0, 6 
	GOTO        L_interrupt0
;p7c.c,27 :: 		v = (ADRESH << 8) + ADRESL;
	MOVF        ADRESH+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        ADRESL+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       _v+0 
	MOVF        R1, 0 
	MOVWF       _v+1 
;p7c.c,30 :: 		vi = v * LAMBDA;
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
;p7c.c,33 :: 		FloatToStr(vi,txt);
	MOVF        R0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        R1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        R2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        R3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       _txt+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;p7c.c,36 :: 		Lcd_Cmd(_Lcd_Clear);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;p7c.c,37 :: 		Lcd_out(1,1, txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;p7c.c,40 :: 		T0CON.TMR0ON = 1;
	BSF         T0CON+0, 7 
;p7c.c,41 :: 		TMR0H = (3036 >> 8);
	MOVLW       11
	MOVWF       TMR0H+0 
;p7c.c,42 :: 		TMR0L = 3036;
	MOVLW       220
	MOVWF       TMR0L+0 
;p7c.c,45 :: 		ADCON0.ADON = 0;
	BCF         ADCON0+0, 0 
;p7c.c,46 :: 		ADCON0.GO = 0;
	BCF         ADCON0+0, 2 
;p7c.c,47 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;p7c.c,48 :: 		}
L_interrupt0:
;p7c.c,50 :: 		if(INTCON.TMR0IF == 1){
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt1
;p7c.c,53 :: 		ADCON0.ADON = 1;
	BSF         ADCON0+0, 0 
;p7c.c,54 :: 		ADCON0.GO = 1;
	BSF         ADCON0+0, 2 
;p7c.c,57 :: 		T0CON.TMR0ON = 0;
	BCF         T0CON+0, 7 
;p7c.c,58 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;p7c.c,59 :: 		}
L_interrupt1:
;p7c.c,61 :: 		}
L_end_interrupt:
L__interrupt5:
	RETFIE      1
; end of _interrupt

_main:

;p7c.c,63 :: 		void main(){
;p7c.c,65 :: 		Lcd_init();
	CALL        _Lcd_Init+0, 0
;p7c.c,68 :: 		TRISB.B0 = 0;
	BCF         TRISB+0, 0 
;p7c.c,69 :: 		TRISE.B1 = 1;
	BSF         TRISE+0, 1 
;p7c.c,72 :: 		ADCON0 = 0x71;
	MOVLW       113
	MOVWF       ADCON0+0 
;p7c.c,73 :: 		ADCON1 = 0xC0;
	MOVLW       192
	MOVWF       ADCON1+0 
;p7c.c,76 :: 		T0CON = 0x84;
	MOVLW       132
	MOVWF       T0CON+0 
;p7c.c,78 :: 		TMR0H = (3036 >> 8);
	MOVLW       11
	MOVWF       TMR0H+0 
;p7c.c,79 :: 		TMR0L = 3036;
	MOVLW       220
	MOVWF       TMR0L+0 
;p7c.c,82 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;p7c.c,83 :: 		INTCON.TMR0IE = 1;
	BSF         INTCON+0, 5 
;p7c.c,86 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;p7c.c,87 :: 		PIE1.ADIE = 1;
	BSF         PIE1+0, 6 
;p7c.c,88 :: 		INTCON.PEIE = 1;
	BSF         INTCON+0, 6 
;p7c.c,91 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;p7c.c,94 :: 		ADCON0.GO = 1;
	BSF         ADCON0+0, 2 
;p7c.c,96 :: 		while(1){
L_main2:
;p7c.c,98 :: 		}
	GOTO        L_main2
;p7c.c,99 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
