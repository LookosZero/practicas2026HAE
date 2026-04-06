
_mostrarLCD:

;p7e.c,33 :: 		void mostrarLCD(float value){
;p7e.c,34 :: 		Lcd_Cmd(_Lcd_Clear);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;p7e.c,35 :: 		FloatToStr(value, txt);
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
;p7e.c,36 :: 		Lcd_Out(1, 3, txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;p7e.c,37 :: 		}
L_end_mostrarLCD:
	RETURN      0
; end of _mostrarLCD

_vToPa:

;p7e.c,39 :: 		float vToPa(float v){
;p7e.c,40 :: 		return 54.2 * v - 14.11;
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
;p7e.c,41 :: 		}
L_end_vToPa:
	RETURN      0
; end of _vToPa

_changeUnit:

;p7e.c,43 :: 		float changeUnit(float pas, int opt){
;p7e.c,46 :: 		switch(opt){
	GOTO        L_changeUnit0
;p7e.c,47 :: 		case 0: // Pa
L_changeUnit2:
;p7e.c,48 :: 		converted = pas;
	MOVF        FARG_changeUnit_pas+0, 0 
	MOVWF       changeUnit_converted_L0+0 
	MOVF        FARG_changeUnit_pas+1, 0 
	MOVWF       changeUnit_converted_L0+1 
	MOVF        FARG_changeUnit_pas+2, 0 
	MOVWF       changeUnit_converted_L0+2 
	MOVF        FARG_changeUnit_pas+3, 0 
	MOVWF       changeUnit_converted_L0+3 
;p7e.c,49 :: 		break;
	GOTO        L_changeUnit1
;p7e.c,50 :: 		case 1: // PSI
L_changeUnit3:
;p7e.c,51 :: 		converted = pas / 6894.757;
	MOVLW       14
	MOVWF       R4 
	MOVLW       118
	MOVWF       R5 
	MOVLW       87
	MOVWF       R6 
	MOVLW       139
	MOVWF       R7 
	MOVF        FARG_changeUnit_pas+0, 0 
	MOVWF       R0 
	MOVF        FARG_changeUnit_pas+1, 0 
	MOVWF       R1 
	MOVF        FARG_changeUnit_pas+2, 0 
	MOVWF       R2 
	MOVF        FARG_changeUnit_pas+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       changeUnit_converted_L0+0 
	MOVF        R1, 0 
	MOVWF       changeUnit_converted_L0+1 
	MOVF        R2, 0 
	MOVWF       changeUnit_converted_L0+2 
	MOVF        R3, 0 
	MOVWF       changeUnit_converted_L0+3 
;p7e.c,52 :: 		break;
	GOTO        L_changeUnit1
;p7e.c,53 :: 		case 2: // Atm
L_changeUnit4:
;p7e.c,54 :: 		converted = pas / 101325.0;
	MOVLW       128
	MOVWF       R4 
	MOVLW       230
	MOVWF       R5 
	MOVLW       69
	MOVWF       R6 
	MOVLW       143
	MOVWF       R7 
	MOVF        FARG_changeUnit_pas+0, 0 
	MOVWF       R0 
	MOVF        FARG_changeUnit_pas+1, 0 
	MOVWF       R1 
	MOVF        FARG_changeUnit_pas+2, 0 
	MOVWF       R2 
	MOVF        FARG_changeUnit_pas+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       changeUnit_converted_L0+0 
	MOVF        R1, 0 
	MOVWF       changeUnit_converted_L0+1 
	MOVF        R2, 0 
	MOVWF       changeUnit_converted_L0+2 
	MOVF        R3, 0 
	MOVWF       changeUnit_converted_L0+3 
;p7e.c,55 :: 		break;
	GOTO        L_changeUnit1
;p7e.c,56 :: 		case 3: // mbar
L_changeUnit5:
;p7e.c,57 :: 		converted = pas / 100.0;
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       72
	MOVWF       R6 
	MOVLW       133
	MOVWF       R7 
	MOVF        FARG_changeUnit_pas+0, 0 
	MOVWF       R0 
	MOVF        FARG_changeUnit_pas+1, 0 
	MOVWF       R1 
	MOVF        FARG_changeUnit_pas+2, 0 
	MOVWF       R2 
	MOVF        FARG_changeUnit_pas+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       changeUnit_converted_L0+0 
	MOVF        R1, 0 
	MOVWF       changeUnit_converted_L0+1 
	MOVF        R2, 0 
	MOVWF       changeUnit_converted_L0+2 
	MOVF        R3, 0 
	MOVWF       changeUnit_converted_L0+3 
;p7e.c,58 :: 		break;
	GOTO        L_changeUnit1
;p7e.c,59 :: 		case 4: // mmHg
L_changeUnit6:
;p7e.c,60 :: 		converted = pas / 133.322;
	MOVLW       111
	MOVWF       R4 
	MOVLW       82
	MOVWF       R5 
	MOVLW       5
	MOVWF       R6 
	MOVLW       134
	MOVWF       R7 
	MOVF        FARG_changeUnit_pas+0, 0 
	MOVWF       R0 
	MOVF        FARG_changeUnit_pas+1, 0 
	MOVWF       R1 
	MOVF        FARG_changeUnit_pas+2, 0 
	MOVWF       R2 
	MOVF        FARG_changeUnit_pas+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       changeUnit_converted_L0+0 
	MOVF        R1, 0 
	MOVWF       changeUnit_converted_L0+1 
	MOVF        R2, 0 
	MOVWF       changeUnit_converted_L0+2 
	MOVF        R3, 0 
	MOVWF       changeUnit_converted_L0+3 
;p7e.c,61 :: 		break;
	GOTO        L_changeUnit1
;p7e.c,62 :: 		case 5: // N/cm^2
L_changeUnit7:
;p7e.c,63 :: 		converted = pas / 10000.0;
	MOVLW       0
	MOVWF       R4 
	MOVLW       64
	MOVWF       R5 
	MOVLW       28
	MOVWF       R6 
	MOVLW       140
	MOVWF       R7 
	MOVF        FARG_changeUnit_pas+0, 0 
	MOVWF       R0 
	MOVF        FARG_changeUnit_pas+1, 0 
	MOVWF       R1 
	MOVF        FARG_changeUnit_pas+2, 0 
	MOVWF       R2 
	MOVF        FARG_changeUnit_pas+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       changeUnit_converted_L0+0 
	MOVF        R1, 0 
	MOVWF       changeUnit_converted_L0+1 
	MOVF        R2, 0 
	MOVWF       changeUnit_converted_L0+2 
	MOVF        R3, 0 
	MOVWF       changeUnit_converted_L0+3 
;p7e.c,64 :: 		break;
	GOTO        L_changeUnit1
;p7e.c,65 :: 		case 6: // Kg/cm^2
L_changeUnit8:
;p7e.c,66 :: 		converted = pas / 98066.5;
	MOVLW       64
	MOVWF       R4 
	MOVLW       137
	MOVWF       R5 
	MOVLW       63
	MOVWF       R6 
	MOVLW       143
	MOVWF       R7 
	MOVF        FARG_changeUnit_pas+0, 0 
	MOVWF       R0 
	MOVF        FARG_changeUnit_pas+1, 0 
	MOVWF       R1 
	MOVF        FARG_changeUnit_pas+2, 0 
	MOVWF       R2 
	MOVF        FARG_changeUnit_pas+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       changeUnit_converted_L0+0 
	MOVF        R1, 0 
	MOVWF       changeUnit_converted_L0+1 
	MOVF        R2, 0 
	MOVWF       changeUnit_converted_L0+2 
	MOVF        R3, 0 
	MOVWF       changeUnit_converted_L0+3 
;p7e.c,67 :: 		break;
	GOTO        L_changeUnit1
;p7e.c,68 :: 		case 7: // Kp/cm^2
L_changeUnit9:
;p7e.c,69 :: 		converted = pas / 98066.5;
	MOVLW       64
	MOVWF       R4 
	MOVLW       137
	MOVWF       R5 
	MOVLW       63
	MOVWF       R6 
	MOVLW       143
	MOVWF       R7 
	MOVF        FARG_changeUnit_pas+0, 0 
	MOVWF       R0 
	MOVF        FARG_changeUnit_pas+1, 0 
	MOVWF       R1 
	MOVF        FARG_changeUnit_pas+2, 0 
	MOVWF       R2 
	MOVF        FARG_changeUnit_pas+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       changeUnit_converted_L0+0 
	MOVF        R1, 0 
	MOVWF       changeUnit_converted_L0+1 
	MOVF        R2, 0 
	MOVWF       changeUnit_converted_L0+2 
	MOVF        R3, 0 
	MOVWF       changeUnit_converted_L0+3 
;p7e.c,70 :: 		break;
	GOTO        L_changeUnit1
;p7e.c,71 :: 		default:
L_changeUnit10:
;p7e.c,72 :: 		converted = pas;
	MOVF        FARG_changeUnit_pas+0, 0 
	MOVWF       changeUnit_converted_L0+0 
	MOVF        FARG_changeUnit_pas+1, 0 
	MOVWF       changeUnit_converted_L0+1 
	MOVF        FARG_changeUnit_pas+2, 0 
	MOVWF       changeUnit_converted_L0+2 
	MOVF        FARG_changeUnit_pas+3, 0 
	MOVWF       changeUnit_converted_L0+3 
;p7e.c,73 :: 		break;
	GOTO        L_changeUnit1
;p7e.c,74 :: 		}
L_changeUnit0:
	MOVLW       0
	XORWF       FARG_changeUnit_opt+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__changeUnit20
	MOVLW       0
	XORWF       FARG_changeUnit_opt+0, 0 
L__changeUnit20:
	BTFSC       STATUS+0, 2 
	GOTO        L_changeUnit2
	MOVLW       0
	XORWF       FARG_changeUnit_opt+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__changeUnit21
	MOVLW       1
	XORWF       FARG_changeUnit_opt+0, 0 
L__changeUnit21:
	BTFSC       STATUS+0, 2 
	GOTO        L_changeUnit3
	MOVLW       0
	XORWF       FARG_changeUnit_opt+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__changeUnit22
	MOVLW       2
	XORWF       FARG_changeUnit_opt+0, 0 
L__changeUnit22:
	BTFSC       STATUS+0, 2 
	GOTO        L_changeUnit4
	MOVLW       0
	XORWF       FARG_changeUnit_opt+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__changeUnit23
	MOVLW       3
	XORWF       FARG_changeUnit_opt+0, 0 
L__changeUnit23:
	BTFSC       STATUS+0, 2 
	GOTO        L_changeUnit5
	MOVLW       0
	XORWF       FARG_changeUnit_opt+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__changeUnit24
	MOVLW       4
	XORWF       FARG_changeUnit_opt+0, 0 
L__changeUnit24:
	BTFSC       STATUS+0, 2 
	GOTO        L_changeUnit6
	MOVLW       0
	XORWF       FARG_changeUnit_opt+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__changeUnit25
	MOVLW       5
	XORWF       FARG_changeUnit_opt+0, 0 
L__changeUnit25:
	BTFSC       STATUS+0, 2 
	GOTO        L_changeUnit7
	MOVLW       0
	XORWF       FARG_changeUnit_opt+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__changeUnit26
	MOVLW       6
	XORWF       FARG_changeUnit_opt+0, 0 
L__changeUnit26:
	BTFSC       STATUS+0, 2 
	GOTO        L_changeUnit8
	MOVLW       0
	XORWF       FARG_changeUnit_opt+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__changeUnit27
	MOVLW       7
	XORWF       FARG_changeUnit_opt+0, 0 
L__changeUnit27:
	BTFSC       STATUS+0, 2 
	GOTO        L_changeUnit9
	GOTO        L_changeUnit10
L_changeUnit1:
;p7e.c,76 :: 		return converted;
	MOVF        changeUnit_converted_L0+0, 0 
	MOVWF       R0 
	MOVF        changeUnit_converted_L0+1, 0 
	MOVWF       R1 
	MOVF        changeUnit_converted_L0+2, 0 
	MOVWF       R2 
	MOVF        changeUnit_converted_L0+3, 0 
	MOVWF       R3 
;p7e.c,77 :: 		}
L_end_changeUnit:
	RETURN      0
; end of _changeUnit

_interrupt:

;p7e.c,79 :: 		void interrupt(){
;p7e.c,82 :: 		if(PIR1.ADIF == 1){
	BTFSS       PIR1+0, 6 
	GOTO        L_interrupt11
;p7e.c,85 :: 		v0 = (ADRESH << 8) + ADRESL;
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
;p7e.c,86 :: 		vi = v0 * LAMBDA;
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
;p7e.c,88 :: 		pa = vToPa(vi);
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
;p7e.c,89 :: 		pressure = changeUnit(pa, unitOption);
	MOVF        R0, 0 
	MOVWF       FARG_changeUnit_pas+0 
	MOVF        R1, 0 
	MOVWF       FARG_changeUnit_pas+1 
	MOVF        R2, 0 
	MOVWF       FARG_changeUnit_pas+2 
	MOVF        R3, 0 
	MOVWF       FARG_changeUnit_pas+3 
	MOVF        _unitOption+0, 0 
	MOVWF       FARG_changeUnit_opt+0 
	MOVF        _unitOption+1, 0 
	MOVWF       FARG_changeUnit_opt+1 
	CALL        _changeUnit+0, 0
	MOVF        R0, 0 
	MOVWF       _pressure+0 
	MOVF        R1, 0 
	MOVWF       _pressure+1 
	MOVF        R2, 0 
	MOVWF       _pressure+2 
	MOVF        R3, 0 
	MOVWF       _pressure+3 
;p7e.c,90 :: 		mostrarLCD(pressure);
	MOVF        R0, 0 
	MOVWF       FARG_mostrarLCD_value+0 
	MOVF        R1, 0 
	MOVWF       FARG_mostrarLCD_value+1 
	MOVF        R2, 0 
	MOVWF       FARG_mostrarLCD_value+2 
	MOVF        R3, 0 
	MOVWF       FARG_mostrarLCD_value+3 
	CALL        _mostrarLCD+0, 0
;p7e.c,93 :: 		T0CON.TMR0ON = 1;
	BSF         T0CON+0, 7 
;p7e.c,94 :: 		TMR0H = (ALFA >> 8);
	MOVLW       11
	MOVWF       TMR0H+0 
;p7e.c,95 :: 		TMR0L = ALFA;
	MOVLW       220
	MOVWF       TMR0L+0 
;p7e.c,98 :: 		ADCON0.ADON = 0;
	BCF         ADCON0+0, 0 
;p7e.c,99 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;p7e.c,100 :: 		}
L_interrupt11:
;p7e.c,103 :: 		if(INTCON.TMR0IF == 1){
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt12
;p7e.c,106 :: 		ADCON0.ADON = 1;
	BSF         ADCON0+0, 0 
;p7e.c,107 :: 		ADCON0.GO = 1;
	BSF         ADCON0+0, 2 
;p7e.c,110 :: 		T0CON.TMR0ON = 0;
	BCF         T0CON+0, 7 
;p7e.c,111 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;p7e.c,112 :: 		}
L_interrupt12:
;p7e.c,115 :: 		if(INTCON3.INT1IF == 1){
	BTFSS       INTCON3+0, 0 
	GOTO        L_interrupt13
;p7e.c,117 :: 		unitOption++;
	INFSNZ      _unitOption+0, 1 
	INCF        _unitOption+1, 1 
;p7e.c,118 :: 		if(unitOption > 7){
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _unitOption+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt30
	MOVF        _unitOption+0, 0 
	SUBLW       7
L__interrupt30:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt14
;p7e.c,119 :: 		unitOption = 0;
	CLRF        _unitOption+0 
	CLRF        _unitOption+1 
;p7e.c,120 :: 		}
L_interrupt14:
;p7e.c,122 :: 		pressure = changeUnit(pa, unitOption);
	MOVF        _pa+0, 0 
	MOVWF       FARG_changeUnit_pas+0 
	MOVF        _pa+1, 0 
	MOVWF       FARG_changeUnit_pas+1 
	MOVF        _pa+2, 0 
	MOVWF       FARG_changeUnit_pas+2 
	MOVF        _pa+3, 0 
	MOVWF       FARG_changeUnit_pas+3 
	MOVF        _unitOption+0, 0 
	MOVWF       FARG_changeUnit_opt+0 
	MOVF        _unitOption+1, 0 
	MOVWF       FARG_changeUnit_opt+1 
	CALL        _changeUnit+0, 0
	MOVF        R0, 0 
	MOVWF       _pressure+0 
	MOVF        R1, 0 
	MOVWF       _pressure+1 
	MOVF        R2, 0 
	MOVWF       _pressure+2 
	MOVF        R3, 0 
	MOVWF       _pressure+3 
;p7e.c,123 :: 		mostrarLCD(pressure);
	MOVF        R0, 0 
	MOVWF       FARG_mostrarLCD_value+0 
	MOVF        R1, 0 
	MOVWF       FARG_mostrarLCD_value+1 
	MOVF        R2, 0 
	MOVWF       FARG_mostrarLCD_value+2 
	MOVF        R3, 0 
	MOVWF       FARG_mostrarLCD_value+3 
	CALL        _mostrarLCD+0, 0
;p7e.c,126 :: 		INTCON3.INT1IF = 0;
	BCF         INTCON3+0, 0 
;p7e.c,127 :: 		}
L_interrupt13:
;p7e.c,128 :: 		}
L_end_interrupt:
L__interrupt29:
	RETFIE      1
; end of _interrupt

_main:

;p7e.c,130 :: 		void main(){
;p7e.c,131 :: 		Lcd_init();
	CALL        _Lcd_Init+0, 0
;p7e.c,134 :: 		TRISB.B0 = 0;
	BCF         TRISB+0, 0 
;p7e.c,135 :: 		TRISB.B1 = 1;
	BSF         TRISB+0, 1 
;p7e.c,136 :: 		TRISE.B2 = 1;
	BSF         TRISE+0, 2 
;p7e.c,139 :: 		ADCON0 = 0x79;
	MOVLW       121
	MOVWF       ADCON0+0 
;p7e.c,140 :: 		ADCON1 = 0xC0;
	MOVLW       192
	MOVWF       ADCON1+0 
;p7e.c,143 :: 		INTCON.PEIE = 1;
	BSF         INTCON+0, 6 
;p7e.c,146 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;p7e.c,147 :: 		PIE1.ADIE = 1;
	BSF         PIE1+0, 6 
;p7e.c,150 :: 		T0CON = 0x83;
	MOVLW       131
	MOVWF       T0CON+0 
;p7e.c,151 :: 		TMR0H = (ALFA >> 8);
	MOVLW       11
	MOVWF       TMR0H+0 
;p7e.c,152 :: 		TMR0L = ALFA;
	MOVLW       220
	MOVWF       TMR0L+0 
;p7e.c,155 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;p7e.c,156 :: 		INTCON.TMR0IE = 1;
	BSF         INTCON+0, 5 
;p7e.c,159 :: 		INTCON2.INTEDG1 = 1;
	BSF         INTCON2+0, 5 
;p7e.c,160 :: 		INTCON3.INT1IF = 0;
	BCF         INTCON3+0, 0 
;p7e.c,161 :: 		INTCON3.INT1IE = 1;
	BSF         INTCON3+0, 3 
;p7e.c,164 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;p7e.c,167 :: 		ADCON0.GO = 1;
	BSF         ADCON0+0, 2 
;p7e.c,169 :: 		while(1){
L_main15:
;p7e.c,171 :: 		}
	GOTO        L_main15
;p7e.c,172 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
