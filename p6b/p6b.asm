
_floatToInt:

;p6b.c,23 :: 		int floatToInt(float num) {
;p6b.c,24 :: 		if (num >= 0.0)
	CLRF        R4 
	CLRF        R5 
	CLRF        R6 
	CLRF        R7 
	MOVF        FARG_floatToInt_num+0, 0 
	MOVWF       R0 
	MOVF        FARG_floatToInt_num+1, 0 
	MOVWF       R1 
	MOVF        FARG_floatToInt_num+2, 0 
	MOVWF       R2 
	MOVF        FARG_floatToInt_num+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_floatToInt0
;p6b.c,25 :: 		return (int)(num + 0.5);
	MOVF        FARG_floatToInt_num+0, 0 
	MOVWF       R0 
	MOVF        FARG_floatToInt_num+1, 0 
	MOVWF       R1 
	MOVF        FARG_floatToInt_num+2, 0 
	MOVWF       R2 
	MOVF        FARG_floatToInt_num+3, 0 
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
	GOTO        L_end_floatToInt
L_floatToInt0:
;p6b.c,27 :: 		return (int)(num - 0.5);
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       126
	MOVWF       R7 
	MOVF        FARG_floatToInt_num+0, 0 
	MOVWF       R0 
	MOVF        FARG_floatToInt_num+1, 0 
	MOVWF       R1 
	MOVF        FARG_floatToInt_num+2, 0 
	MOVWF       R2 
	MOVF        FARG_floatToInt_num+3, 0 
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	CALL        _double2int+0, 0
;p6b.c,28 :: 		}
L_end_floatToInt:
	RETURN      0
; end of _floatToInt

_interrupt:

;p6b.c,30 :: 		void interrupt(){
;p6b.c,32 :: 		if(PIR1.ADIF == 1){
	BTFSS       PIR1+0, 6 
	GOTO        L_interrupt2
;p6b.c,34 :: 		v = ADRESL;
	MOVF        ADRESL+0, 0 
	MOVWF       _v+0 
	MOVLW       0
	MOVWF       _v+1 
;p6b.c,35 :: 		v = v + (ADRESH << 8);
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
;p6b.c,38 :: 		aux = 100*(v*res) - 50;
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
;p6b.c,40 :: 		temp = floatToInt(aux);
	MOVF        R0, 0 
	MOVWF       FARG_floatToInt_num+0 
	MOVF        R1, 0 
	MOVWF       FARG_floatToInt_num+1 
	MOVF        R2, 0 
	MOVWF       FARG_floatToInt_num+2 
	MOVF        R3, 0 
	MOVWF       FARG_floatToInt_num+3 
	CALL        _floatToInt+0, 0
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
;p6b.c,43 :: 		Lcd_Cmd(_Lcd_Clear);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;p6b.c,44 :: 		IntToStr(temp, txt);
	MOVF        _temp+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _temp+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _txt+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;p6b.c,45 :: 		Lcd_out(1,1, txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;p6b.c,48 :: 		ADCON0.ADON = 0;
	BCF         ADCON0+0, 0 
;p6b.c,49 :: 		ADCON0.GO = 0;
	BCF         ADCON0+0, 2 
;p6b.c,50 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;p6b.c,53 :: 		T0CON.TMR0ON = 1;
	BSF         T0CON+0, 7 
;p6b.c,54 :: 		TMR0H = (28036 >> 8);
	MOVLW       109
	MOVWF       TMR0H+0 
;p6b.c,55 :: 		TMR0L = 28036;
	MOVLW       132
	MOVWF       TMR0L+0 
;p6b.c,56 :: 		}
L_interrupt2:
;p6b.c,58 :: 		if(INTCON.TMR0IF == 1){
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt3
;p6b.c,61 :: 		ADCON0.ADON = 1;
	BSF         ADCON0+0, 0 
;p6b.c,62 :: 		ADCON0.GO = 1;
	BSF         ADCON0+0, 2 
;p6b.c,63 :: 		T0CON.TMR0ON = 0;
	BCF         T0CON+0, 7 
;p6b.c,64 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;p6b.c,65 :: 		}
L_interrupt3:
;p6b.c,67 :: 		}
L_end_interrupt:
L__interrupt8:
	RETFIE      1
; end of _interrupt

_main:

;p6b.c,69 :: 		void main(){
;p6b.c,70 :: 		Lcd_init();
	CALL        _Lcd_Init+0, 0
;p6b.c,73 :: 		ADCON0 = 0x59;
	MOVLW       89
	MOVWF       ADCON0+0 
;p6b.c,74 :: 		ADCON1 = 0xC0;
	MOVLW       192
	MOVWF       ADCON1+0 
;p6b.c,77 :: 		TRISB.B3 = 1;
	BSF         TRISB+0, 3 
;p6b.c,80 :: 		T0CON = 0x85;
	MOVLW       133
	MOVWF       T0CON+0 
;p6b.c,81 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;p6b.c,82 :: 		INTCON.TMR0IE = 1;
	BSF         INTCON+0, 5 
;p6b.c,86 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;p6b.c,87 :: 		PIE1.ADIE = 1;
	BSF         PIE1+0, 6 
;p6b.c,88 :: 		INTCON.PEIE = 1;
	BSF         INTCON+0, 6 
;p6b.c,91 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;p6b.c,94 :: 		ADCON0.GO = 1;
	BSF         ADCON0+0, 2 
;p6b.c,96 :: 		while(1) {
L_main4:
;p6b.c,98 :: 		}
	GOTO        L_main4
;p6b.c,99 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
