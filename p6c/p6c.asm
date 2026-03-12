
_floatToInt:

;p6c.c,23 :: 		int floatToInt(float num) {
;p6c.c,24 :: 		if (num >= 0.0)
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
;p6c.c,25 :: 		return (int)(num + 0.5);
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
;p6c.c,27 :: 		return (int)(num - 0.5);
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
;p6c.c,28 :: 		}
L_end_floatToInt:
	RETURN      0
; end of _floatToInt

_interrupt:

;p6c.c,30 :: 		void interrupt(){
;p6c.c,32 :: 		if(PIR1.ADIF == 1){
	BTFSS       PIR1+0, 6 
	GOTO        L_interrupt2
;p6c.c,34 :: 		v = ADRESL;
	MOVF        ADRESL+0, 0 
	MOVWF       _v+0 
	MOVLW       0
	MOVWF       _v+1 
;p6c.c,35 :: 		v = v + (ADRESH << 8);
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
;p6c.c,38 :: 		aux = 100*(v*0.0048875) - 50;
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
;p6c.c,40 :: 		temp = floatToInt(aux);
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
;p6c.c,43 :: 		Lcd_Cmd(_Lcd_Clear);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;p6c.c,44 :: 		IntToStr(temp, txt);
	MOVF        _temp+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _temp+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _txt+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;p6c.c,45 :: 		Lcd_out(1,1, txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;p6c.c,48 :: 		ADCON0.ADON = 0;
	BCF         ADCON0+0, 0 
;p6c.c,49 :: 		ADCON0.GO = 0;
	BCF         ADCON0+0, 2 
;p6c.c,50 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;p6c.c,53 :: 		T0CON.TMR0ON = 1;
	BSF         T0CON+0, 7 
;p6c.c,54 :: 		TMR0H = (28036 >> 8);
	MOVLW       109
	MOVWF       TMR0H+0 
;p6c.c,55 :: 		TMR0L = 28036;
	MOVLW       132
	MOVWF       TMR0L+0 
;p6c.c,56 :: 		}
L_interrupt2:
;p6c.c,58 :: 		if(INTCON.TMR0IF == 1){
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt3
;p6c.c,61 :: 		ADCON0.ADON = 1;
	BSF         ADCON0+0, 0 
;p6c.c,62 :: 		ADCON0.GO = 1;
	BSF         ADCON0+0, 2 
;p6c.c,63 :: 		T0CON.TMR0ON = 0;
	BCF         T0CON+0, 7 
;p6c.c,64 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;p6c.c,65 :: 		}
L_interrupt3:
;p6c.c,67 :: 		if (INTCON.INT0IF == 1 && PORTB.B0 == 1) {
	BTFSS       INTCON+0, 1 
	GOTO        L_interrupt6
	BTFSS       PORTB+0, 0 
	GOTO        L_interrupt6
L__interrupt14:
;p6c.c,69 :: 		switch(unidad) {
	GOTO        L_interrupt7
;p6c.c,70 :: 		case 0 :
L_interrupt9:
;p6c.c,71 :: 		aux = (aux - 32) / 1.8;
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       132
	MOVWF       R7 
	MOVF        _aux+0, 0 
	MOVWF       R0 
	MOVF        _aux+1, 0 
	MOVWF       R1 
	MOVF        _aux+2, 0 
	MOVWF       R2 
	MOVF        _aux+3, 0 
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	MOVLW       102
	MOVWF       R4 
	MOVLW       102
	MOVWF       R5 
	MOVLW       102
	MOVWF       R6 
	MOVLW       127
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _aux+0 
	MOVF        R1, 0 
	MOVWF       _aux+1 
	MOVF        R2, 0 
	MOVWF       _aux+2 
	MOVF        R3, 0 
	MOVWF       _aux+3 
;p6c.c,72 :: 		unidad++;
	INFSNZ      _unidad+0, 1 
	INCF        _unidad+1, 1 
;p6c.c,73 :: 		break;
	GOTO        L_interrupt8
;p6c.c,74 :: 		case 1 :
L_interrupt10:
;p6c.c,75 :: 		aux = aux + 273,15;
	MOVF        _aux+0, 0 
	MOVWF       R0 
	MOVF        _aux+1, 0 
	MOVWF       R1 
	MOVF        _aux+2, 0 
	MOVWF       R2 
	MOVF        _aux+3, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	MOVLW       128
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
;p6c.c,76 :: 		unidad++;
	INFSNZ      _unidad+0, 1 
	INCF        _unidad+1, 1 
;p6c.c,77 :: 		break;
	GOTO        L_interrupt8
;p6c.c,78 :: 		default :
L_interrupt11:
;p6c.c,79 :: 		aux = 1,8*(aux-273,15) + 32;
	MOVLW       0
	MOVWF       _aux+0 
	MOVLW       0
	MOVWF       _aux+1 
	MOVLW       0
	MOVWF       _aux+2 
	MOVLW       127
	MOVWF       _aux+3 
;p6c.c,80 :: 		unidad = 0;
	CLRF        _unidad+0 
	CLRF        _unidad+1 
;p6c.c,81 :: 		break;
	GOTO        L_interrupt8
;p6c.c,83 :: 		}
L_interrupt7:
	MOVLW       0
	XORWF       _unidad+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt18
	MOVLW       0
	XORWF       _unidad+0, 0 
L__interrupt18:
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt9
	MOVLW       0
	XORWF       _unidad+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt19
	MOVLW       1
	XORWF       _unidad+0, 0 
L__interrupt19:
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt10
	GOTO        L_interrupt11
L_interrupt8:
;p6c.c,84 :: 		INTCON.INT0IF = 0;
	BCF         INTCON+0, 1 
;p6c.c,85 :: 		}
L_interrupt6:
;p6c.c,87 :: 		}
L_end_interrupt:
L__interrupt17:
	RETFIE      1
; end of _interrupt

_main:

;p6c.c,89 :: 		void main(){
;p6c.c,90 :: 		Lcd_init();
	CALL        _Lcd_Init+0, 0
;p6c.c,93 :: 		ADCON0 = 0x59;
	MOVLW       89
	MOVWF       ADCON0+0 
;p6c.c,94 :: 		ADCON1 = 0xC0;
	MOVLW       192
	MOVWF       ADCON1+0 
;p6c.c,97 :: 		TRISA.B3 = 1;
	BSF         TRISA+0, 3 
;p6c.c,100 :: 		TRISB.B0 = 1;
	BSF         TRISB+0, 0 
;p6c.c,103 :: 		T0CON = 0x85;
	MOVLW       133
	MOVWF       T0CON+0 
;p6c.c,104 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;p6c.c,105 :: 		INTCON.TMR0IE = 1;
	BSF         INTCON+0, 5 
;p6c.c,108 :: 		INTCON.INT0IE = 1;
	BSF         INTCON+0, 4 
;p6c.c,109 :: 		INTCON.INT0IF = 0;
	BCF         INTCON+0, 1 
;p6c.c,110 :: 		INTCON2.INTEDG0 = 1;
	BSF         INTCON2+0, 6 
;p6c.c,113 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;p6c.c,114 :: 		PIE1.ADIE = 1;
	BSF         PIE1+0, 6 
;p6c.c,115 :: 		INTCON.PEIE = 1;
	BSF         INTCON+0, 6 
;p6c.c,118 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;p6c.c,121 :: 		ADCON0.GO = 1;
	BSF         ADCON0+0, 2 
;p6c.c,123 :: 		while(1) {
L_main12:
;p6c.c,125 :: 		}
	GOTO        L_main12
;p6c.c,126 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
