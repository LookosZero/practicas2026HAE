
_floatToInt:

;p6c.c,26 :: 		int floatToInt(float num) {
;p6c.c,27 :: 		if (num >= 0.0)
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
;p6c.c,28 :: 		return (int)(num + 0.5);
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
;p6c.c,30 :: 		return (int)(num - 0.5);
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
;p6c.c,31 :: 		}
L_end_floatToInt:
	RETURN      0
; end of _floatToInt

_mostrarTemp:

;p6c.c,33 :: 		void mostrarTemp() {
;p6c.c,34 :: 		Lcd_Cmd(_Lcd_Clear);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;p6c.c,35 :: 		IntToStr(temp, txt);
	MOVF        _temp+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _temp+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _txt+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;p6c.c,36 :: 		if (unidad == 0) {
	MOVLW       0
	XORWF       _unidad+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__mostrarTemp21
	MOVLW       0
	XORWF       _unidad+0, 0 
L__mostrarTemp21:
	BTFSS       STATUS+0, 2 
	GOTO        L_mostrarTemp2
;p6c.c,37 :: 		Lcd_out(1, 1, txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;p6c.c,38 :: 		Lcd_out(1, 7, "C");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       7
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_p6c+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_p6c+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;p6c.c,39 :: 		} else if (unidad == 1) {
	GOTO        L_mostrarTemp3
L_mostrarTemp2:
	MOVLW       0
	XORWF       _unidad+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__mostrarTemp22
	MOVLW       1
	XORWF       _unidad+0, 0 
L__mostrarTemp22:
	BTFSS       STATUS+0, 2 
	GOTO        L_mostrarTemp4
;p6c.c,40 :: 		Lcd_out(1, 1, txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;p6c.c,41 :: 		Lcd_out(1, 7, "F");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       7
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_p6c+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_p6c+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;p6c.c,42 :: 		} else {
	GOTO        L_mostrarTemp5
L_mostrarTemp4:
;p6c.c,43 :: 		Lcd_out(1, 1, txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;p6c.c,44 :: 		Lcd_out(1, 7, "K");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       7
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_p6c+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_p6c+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;p6c.c,45 :: 		}
L_mostrarTemp5:
L_mostrarTemp3:
;p6c.c,46 :: 		}
L_end_mostrarTemp:
	RETURN      0
; end of _mostrarTemp

_interrupt:

;p6c.c,48 :: 		void interrupt() {
;p6c.c,50 :: 		if (PIR1.ADIF == 1) {
	BTFSS       PIR1+0, 6 
	GOTO        L_interrupt6
;p6c.c,52 :: 		v = ADRESL;
	MOVF        ADRESL+0, 0 
	MOVWF       _v+0 
	MOVLW       0
	MOVWF       _v+1 
;p6c.c,53 :: 		v = v + (ADRESH << 8);
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
;p6c.c,54 :: 		tempC = 100.0 * (v * res) - 50.0;
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
	MOVWF       _tempC+0 
	MOVF        R1, 0 
	MOVWF       _tempC+1 
	MOVF        R2, 0 
	MOVWF       _tempC+2 
	MOVF        R3, 0 
	MOVWF       _tempC+3 
;p6c.c,57 :: 		if (unidad == 0) {
	MOVLW       0
	XORWF       _unidad+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt25
	MOVLW       0
	XORWF       _unidad+0, 0 
L__interrupt25:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt7
;p6c.c,58 :: 		aux = tempC;
	MOVF        _tempC+0, 0 
	MOVWF       _aux+0 
	MOVF        _tempC+1, 0 
	MOVWF       _aux+1 
	MOVF        _tempC+2, 0 
	MOVWF       _aux+2 
	MOVF        _tempC+3, 0 
	MOVWF       _aux+3 
;p6c.c,59 :: 		} else if (unidad == 1) {
	GOTO        L_interrupt8
L_interrupt7:
	MOVLW       0
	XORWF       _unidad+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt26
	MOVLW       1
	XORWF       _unidad+0, 0 
L__interrupt26:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt9
;p6c.c,60 :: 		aux = 1.8 * tempC + 32.0;
	MOVLW       102
	MOVWF       R0 
	MOVLW       102
	MOVWF       R1 
	MOVLW       102
	MOVWF       R2 
	MOVLW       127
	MOVWF       R3 
	MOVF        _tempC+0, 0 
	MOVWF       R4 
	MOVF        _tempC+1, 0 
	MOVWF       R5 
	MOVF        _tempC+2, 0 
	MOVWF       R6 
	MOVF        _tempC+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       132
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _aux+0 
	MOVF        R1, 0 
	MOVWF       _aux+1 
	MOVF        R2, 0 
	MOVWF       _aux+2 
	MOVF        R3, 0 
	MOVWF       _aux+3 
;p6c.c,61 :: 		} else {
	GOTO        L_interrupt10
L_interrupt9:
;p6c.c,62 :: 		aux = tempC + 273.15;
	MOVF        _tempC+0, 0 
	MOVWF       R0 
	MOVF        _tempC+1, 0 
	MOVWF       R1 
	MOVF        _tempC+2, 0 
	MOVWF       R2 
	MOVF        _tempC+3, 0 
	MOVWF       R3 
	MOVLW       51
	MOVWF       R4 
	MOVLW       147
	MOVWF       R5 
	MOVLW       8
	MOVWF       R6 
	MOVLW       135
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _aux+0 
	MOVF        R1, 0 
	MOVWF       _aux+1 
	MOVF        R2, 0 
	MOVWF       _aux+2 
	MOVF        R3, 0 
	MOVWF       _aux+3 
;p6c.c,63 :: 		}
L_interrupt10:
L_interrupt8:
;p6c.c,65 :: 		temp = floatToInt(aux);
	MOVF        _aux+0, 0 
	MOVWF       FARG_floatToInt_num+0 
	MOVF        _aux+1, 0 
	MOVWF       FARG_floatToInt_num+1 
	MOVF        _aux+2, 0 
	MOVWF       FARG_floatToInt_num+2 
	MOVF        _aux+3, 0 
	MOVWF       FARG_floatToInt_num+3 
	CALL        _floatToInt+0, 0
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
;p6c.c,66 :: 		mostrarTemp();
	CALL        _mostrarTemp+0, 0
;p6c.c,69 :: 		ADCON0.ADON = 0;
	BCF         ADCON0+0, 0 
;p6c.c,70 :: 		ADCON0.GO   = 0;
	BCF         ADCON0+0, 2 
;p6c.c,71 :: 		PIR1.ADIF   = 0;
	BCF         PIR1+0, 6 
;p6c.c,74 :: 		T0CON.TMR0ON = 1;
	BSF         T0CON+0, 7 
;p6c.c,75 :: 		TMR0H = (28036 >> 8);
	MOVLW       109
	MOVWF       TMR0H+0 
;p6c.c,76 :: 		TMR0L = 28036 & 0xFF;
	MOVLW       132
	MOVWF       TMR0L+0 
;p6c.c,77 :: 		}
L_interrupt6:
;p6c.c,79 :: 		if (INTCON.TMR0IF == 1) {
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt11
;p6c.c,81 :: 		T0CON.TMR0ON = 0;
	BCF         T0CON+0, 7 
;p6c.c,82 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;p6c.c,83 :: 		ADCON0.ADON = 1;
	BSF         ADCON0+0, 0 
;p6c.c,84 :: 		ADCON0.GO   = 1;
	BSF         ADCON0+0, 2 
;p6c.c,85 :: 		}
L_interrupt11:
;p6c.c,87 :: 		if (INTCON.INT0IF == 1) {
	BTFSS       INTCON+0, 1 
	GOTO        L_interrupt12
;p6c.c,89 :: 		unidad = (unidad + 1) % 3;
	MOVLW       1
	ADDWF       _unidad+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _unidad+1, 0 
	MOVWF       R1 
	MOVLW       3
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _unidad+0 
	MOVF        R1, 0 
	MOVWF       _unidad+1 
;p6c.c,91 :: 		if (unidad == 0) {
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt27
	MOVLW       0
	XORWF       R0, 0 
L__interrupt27:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt13
;p6c.c,92 :: 		aux = tempC;
	MOVF        _tempC+0, 0 
	MOVWF       _aux+0 
	MOVF        _tempC+1, 0 
	MOVWF       _aux+1 
	MOVF        _tempC+2, 0 
	MOVWF       _aux+2 
	MOVF        _tempC+3, 0 
	MOVWF       _aux+3 
;p6c.c,93 :: 		} else if (unidad == 1) {
	GOTO        L_interrupt14
L_interrupt13:
	MOVLW       0
	XORWF       _unidad+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt28
	MOVLW       1
	XORWF       _unidad+0, 0 
L__interrupt28:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt15
;p6c.c,94 :: 		aux = 1.8 * tempC + 32.0;
	MOVLW       102
	MOVWF       R0 
	MOVLW       102
	MOVWF       R1 
	MOVLW       102
	MOVWF       R2 
	MOVLW       127
	MOVWF       R3 
	MOVF        _tempC+0, 0 
	MOVWF       R4 
	MOVF        _tempC+1, 0 
	MOVWF       R5 
	MOVF        _tempC+2, 0 
	MOVWF       R6 
	MOVF        _tempC+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       132
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _aux+0 
	MOVF        R1, 0 
	MOVWF       _aux+1 
	MOVF        R2, 0 
	MOVWF       _aux+2 
	MOVF        R3, 0 
	MOVWF       _aux+3 
;p6c.c,95 :: 		} else {
	GOTO        L_interrupt16
L_interrupt15:
;p6c.c,96 :: 		aux = tempC + 273.15;
	MOVF        _tempC+0, 0 
	MOVWF       R0 
	MOVF        _tempC+1, 0 
	MOVWF       R1 
	MOVF        _tempC+2, 0 
	MOVWF       R2 
	MOVF        _tempC+3, 0 
	MOVWF       R3 
	MOVLW       51
	MOVWF       R4 
	MOVLW       147
	MOVWF       R5 
	MOVLW       8
	MOVWF       R6 
	MOVLW       135
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _aux+0 
	MOVF        R1, 0 
	MOVWF       _aux+1 
	MOVF        R2, 0 
	MOVWF       _aux+2 
	MOVF        R3, 0 
	MOVWF       _aux+3 
;p6c.c,97 :: 		}
L_interrupt16:
L_interrupt14:
;p6c.c,99 :: 		temp = floatToInt(aux);
	MOVF        _aux+0, 0 
	MOVWF       FARG_floatToInt_num+0 
	MOVF        _aux+1, 0 
	MOVWF       FARG_floatToInt_num+1 
	MOVF        _aux+2, 0 
	MOVWF       FARG_floatToInt_num+2 
	MOVF        _aux+3, 0 
	MOVWF       FARG_floatToInt_num+3 
	CALL        _floatToInt+0, 0
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
;p6c.c,100 :: 		mostrarTemp();
	CALL        _mostrarTemp+0, 0
;p6c.c,102 :: 		INTCON.INT0IF = 0;
	BCF         INTCON+0, 1 
;p6c.c,103 :: 		}
L_interrupt12:
;p6c.c,104 :: 		}
L_end_interrupt:
L__interrupt24:
	RETFIE      1
; end of _interrupt

_main:

;p6c.c,106 :: 		void main() {
;p6c.c,107 :: 		Lcd_init();
	CALL        _Lcd_Init+0, 0
;p6c.c,110 :: 		ADCON0 = 0x59;
	MOVLW       89
	MOVWF       ADCON0+0 
;p6c.c,111 :: 		ADCON1 = 0xC0;
	MOVLW       192
	MOVWF       ADCON1+0 
;p6c.c,114 :: 		TRISA.B3 = 1;
	BSF         TRISA+0, 3 
;p6c.c,115 :: 		TRISB.B0 = 1;
	BSF         TRISB+0, 0 
;p6c.c,118 :: 		T0CON = 0x85;
	MOVLW       133
	MOVWF       T0CON+0 
;p6c.c,119 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;p6c.c,120 :: 		INTCON.TMR0IE = 1;
	BSF         INTCON+0, 5 
;p6c.c,123 :: 		INTCON2.INTEDG0 = 1;
	BSF         INTCON2+0, 6 
;p6c.c,124 :: 		INTCON.INT0IF   = 0;
	BCF         INTCON+0, 1 
;p6c.c,125 :: 		INTCON.INT0IE   = 1;
	BSF         INTCON+0, 4 
;p6c.c,128 :: 		PIR1.ADIF  = 0;
	BCF         PIR1+0, 6 
;p6c.c,129 :: 		PIE1.ADIE  = 1;
	BSF         PIE1+0, 6 
;p6c.c,130 :: 		INTCON.PEIE = 1;
	BSF         INTCON+0, 6 
;p6c.c,133 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;p6c.c,136 :: 		ADCON0.GO = 1;
	BSF         ADCON0+0, 2 
;p6c.c,138 :: 		while (1) {
L_main17:
;p6c.c,139 :: 		}
	GOTO        L_main17
;p6c.c,140 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
