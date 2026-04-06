
_FloatToInt:

;p6b.c,24 :: 		void FloatToInt(float aux, int *temp) {
;p6b.c,25 :: 		if (aux >= 0)
	CLRF        R4 
	CLRF        R5 
	CLRF        R6 
	CLRF        R7 
	MOVF        FARG_FloatToInt_aux+0, 0 
	MOVWF       R0 
	MOVF        FARG_FloatToInt_aux+1, 0 
	MOVWF       R1 
	MOVF        FARG_FloatToInt_aux+2, 0 
	MOVWF       R2 
	MOVF        FARG_FloatToInt_aux+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_FloatToInt0
;p6b.c,26 :: 		*temp = (int)(aux + 0.5);
	MOVF        FARG_FloatToInt_aux+0, 0 
	MOVWF       R0 
	MOVF        FARG_FloatToInt_aux+1, 0 
	MOVWF       R1 
	MOVF        FARG_FloatToInt_aux+2, 0 
	MOVWF       R2 
	MOVF        FARG_FloatToInt_aux+3, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       126
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	CALL        _double2int+0, 0
	MOVFF       FARG_FloatToInt_temp+0, FSR1
	MOVFF       FARG_FloatToInt_temp+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	GOTO        L_FloatToInt1
L_FloatToInt0:
;p6b.c,28 :: 		*temp = (int)(aux - 0.5);
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       126
	MOVWF       R7 
	MOVF        FARG_FloatToInt_aux+0, 0 
	MOVWF       R0 
	MOVF        FARG_FloatToInt_aux+1, 0 
	MOVWF       R1 
	MOVF        FARG_FloatToInt_aux+2, 0 
	MOVWF       R2 
	MOVF        FARG_FloatToInt_aux+3, 0 
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	CALL        _double2int+0, 0
	MOVFF       FARG_FloatToInt_temp+0, FSR1
	MOVFF       FARG_FloatToInt_temp+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
L_FloatToInt1:
;p6b.c,29 :: 		}
L_end_FloatToInt:
	RETURN      0
; end of _FloatToInt

_interrupt:

;p6b.c,31 :: 		void interrupt(){
;p6b.c,33 :: 		if(PIR1.ADIF == 1){
	BTFSS       PIR1+0, 6 
	GOTO        L_interrupt2
;p6b.c,35 :: 		v = ADRESL;
	MOVF        ADRESL+0, 0 
	MOVWF       _v+0 
	MOVLW       0
	MOVWF       _v+1 
;p6b.c,36 :: 		v = v + (ADRESH << 8);
	MOVF        ADRESH+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        _v+0, 0 
	ADDWF       R0, 1 
	MOVF        _v+1, 0 
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       _v+0 
	MOVF        R1, 0 
	MOVWF       _v+1 
;p6b.c,39 :: 		aux = 100*(v*LAMBDA) - 50;
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
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       72
	MOVWF       R6 
	MOVLW       133
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       72
	MOVWF       R6 
	MOVLW       132
	MOVWF       R7 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _aux+0 
	MOVF        R1, 0 
	MOVWF       _aux+1 
	MOVF        R2, 0 
	MOVWF       _aux+2 
	MOVF        R3, 0 
	MOVWF       _aux+3 
;p6b.c,41 :: 		FloatToInt(aux, &temp);
	MOVF        R0, 0 
	MOVWF       FARG_FloatToInt_aux+0 
	MOVF        R1, 0 
	MOVWF       FARG_FloatToInt_aux+1 
	MOVF        R2, 0 
	MOVWF       FARG_FloatToInt_aux+2 
	MOVF        R3, 0 
	MOVWF       FARG_FloatToInt_aux+3 
	MOVLW       _temp+0
	MOVWF       FARG_FloatToInt_temp+0 
	MOVLW       hi_addr(_temp+0)
	MOVWF       FARG_FloatToInt_temp+1 
	CALL        _FloatToInt+0, 0
;p6b.c,44 :: 		Lcd_Cmd(_Lcd_Clear);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;p6b.c,45 :: 		IntToStr(temp, txt);
	MOVF        _temp+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _temp+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _txt+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;p6b.c,46 :: 		Lcd_out(1,1, txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;p6b.c,49 :: 		ADCON0.ADON = 0;
	BCF         ADCON0+0, 0 
;p6b.c,50 :: 		ADCON0.GO = 0;
	BCF         ADCON0+0, 2 
;p6b.c,51 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;p6b.c,54 :: 		T0CON.TMR0ON = 1;
	BSF         T0CON+0, 7 
;p6b.c,55 :: 		TMR0H = (28036 >> 8);
	MOVLW       109
	MOVWF       TMR0H+0 
;p6b.c,56 :: 		TMR0L = 28036;
	MOVLW       132
	MOVWF       TMR0L+0 
;p6b.c,57 :: 		}
L_interrupt2:
;p6b.c,59 :: 		if(INTCON.TMR0IF == 1){
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt3
;p6b.c,62 :: 		ADCON0.ADON = 1;
	BSF         ADCON0+0, 0 
;p6b.c,63 :: 		ADCON0.GO = 1;
	BSF         ADCON0+0, 2 
;p6b.c,64 :: 		T0CON.TMR0ON = 0;
	BCF         T0CON+0, 7 
;p6b.c,65 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;p6b.c,66 :: 		}
L_interrupt3:
;p6b.c,68 :: 		}
L_end_interrupt:
L__interrupt8:
	RETFIE      1
; end of _interrupt

_main:

;p6b.c,70 :: 		void main(){
;p6b.c,71 :: 		Lcd_init();
	CALL        _Lcd_Init+0, 0
;p6b.c,74 :: 		ADCON0 = 0x59;
	MOVLW       89
	MOVWF       ADCON0+0 
;p6b.c,75 :: 		ADCON1 = 0xC0;
	MOVLW       192
	MOVWF       ADCON1+0 
;p6b.c,78 :: 		TRISA.B3 = 1;
	BSF         TRISA+0, 3 
;p6b.c,81 :: 		T0CON = 0x85;
	MOVLW       133
	MOVWF       T0CON+0 
;p6b.c,82 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;p6b.c,83 :: 		INTCON.TMR0IE = 1;
	BSF         INTCON+0, 5 
;p6b.c,87 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;p6b.c,88 :: 		PIE1.ADIE = 1;
	BSF         PIE1+0, 6 
;p6b.c,89 :: 		INTCON.PEIE = 1;
	BSF         INTCON+0, 6 
;p6b.c,92 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;p6b.c,95 :: 		ADCON0.GO = 1;
	BSF         ADCON0+0, 2 
;p6b.c,97 :: 		while(1) {
L_main4:
;p6b.c,99 :: 		}
	GOTO        L_main4
;p6b.c,100 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
