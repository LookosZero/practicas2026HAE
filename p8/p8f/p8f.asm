
_floatToInt:

;p8f.c,6 :: 		int floatToInt(float value){
;p8f.c,7 :: 		if(value >= 0.0f){
	CLRF        R4 
	CLRF        R5 
	CLRF        R6 
	CLRF        R7 
	MOVF        FARG_floatToInt_value+0, 0 
	MOVWF       R0 
	MOVF        FARG_floatToInt_value+1, 0 
	MOVWF       R1 
	MOVF        FARG_floatToInt_value+2, 0 
	MOVWF       R2 
	MOVF        FARG_floatToInt_value+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_floatToInt0
;p8f.c,8 :: 		return (int)(value + 0.05f);
	MOVF        FARG_floatToInt_value+0, 0 
	MOVWF       R0 
	MOVF        FARG_floatToInt_value+1, 0 
	MOVWF       R1 
	MOVF        FARG_floatToInt_value+2, 0 
	MOVWF       R2 
	MOVF        FARG_floatToInt_value+3, 0 
	MOVWF       R3 
	MOVLW       205
	MOVWF       R4 
	MOVLW       204
	MOVWF       R5 
	MOVLW       76
	MOVWF       R6 
	MOVLW       122
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	CALL        _double2int+0, 0
	GOTO        L_end_floatToInt
;p8f.c,9 :: 		}else{
L_floatToInt0:
;p8f.c,10 :: 		return (int)(value - 0.05f);
	MOVLW       205
	MOVWF       R4 
	MOVLW       204
	MOVWF       R5 
	MOVLW       76
	MOVWF       R6 
	MOVLW       122
	MOVWF       R7 
	MOVF        FARG_floatToInt_value+0, 0 
	MOVWF       R0 
	MOVF        FARG_floatToInt_value+1, 0 
	MOVWF       R1 
	MOVF        FARG_floatToInt_value+2, 0 
	MOVWF       R2 
	MOVF        FARG_floatToInt_value+3, 0 
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	CALL        _double2int+0, 0
;p8f.c,12 :: 		}
L_end_floatToInt:
	RETURN      0
; end of _floatToInt

_writeDAC:

;p8f.c,14 :: 		void writeDAC(int D){
;p8f.c,15 :: 		if(D > 1023){
	MOVLW       128
	XORLW       3
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_writeDAC_D+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__writeDAC9
	MOVF        FARG_writeDAC_D+0, 0 
	SUBLW       255
L__writeDAC9:
	BTFSC       STATUS+0, 0 
	GOTO        L_writeDAC2
;p8f.c,16 :: 		D = 1023;
	MOVLW       255
	MOVWF       FARG_writeDAC_D+0 
	MOVLW       3
	MOVWF       FARG_writeDAC_D+1 
;p8f.c,17 :: 		}
L_writeDAC2:
;p8f.c,18 :: 		SPI1_Init();
	CALL        _SPI1_Init+0, 0
;p8f.c,19 :: 		PORTC.B0 = 0;
	BCF         PORTC+0, 0 
;p8f.c,20 :: 		SPI1_Write(D >> 6);
	MOVLW       6
	MOVWF       R2 
	MOVF        FARG_writeDAC_D+0, 0 
	MOVWF       R0 
	MOVF        FARG_writeDAC_D+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__writeDAC10:
	BZ          L__writeDAC11
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	ADDLW       255
	GOTO        L__writeDAC10
L__writeDAC11:
	MOVF        R0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;p8f.c,21 :: 		SPI1_Write(D << 2);
	MOVF        FARG_writeDAC_D+0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	RLCF        FARG_SPI1_Write_data_+0, 1 
	BCF         FARG_SPI1_Write_data_+0, 0 
	RLCF        FARG_SPI1_Write_data_+0, 1 
	BCF         FARG_SPI1_Write_data_+0, 0 
	CALL        _SPI1_Write+0, 0
;p8f.c,22 :: 		PORTC.B0 = 1;
	BSF         PORTC+0, 0 
;p8f.c,23 :: 		}
L_end_writeDAC:
	RETURN      0
; end of _writeDAC

_interrupt:

;p8f.c,25 :: 		void interrupt(){
;p8f.c,27 :: 		if(PIR1.ADIF == 1){
	BTFSS       PIR1+0, 6 
	GOTO        L_interrupt3
;p8f.c,30 :: 		aux = (ADRESH << 8) + ADRESL;
	MOVF        ADRESH+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        ADRESL+0, 0 
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVF        R2, 0 
	MOVWF       _aux+0 
	MOVF        R3, 0 
	MOVWF       _aux+1 
;p8f.c,33 :: 		writeDAC(aux * 4);
	MOVF        R2, 0 
	MOVWF       FARG_writeDAC_D+0 
	MOVF        R3, 0 
	MOVWF       FARG_writeDAC_D+1 
	RLCF        FARG_writeDAC_D+0, 1 
	BCF         FARG_writeDAC_D+0, 0 
	RLCF        FARG_writeDAC_D+1, 1 
	RLCF        FARG_writeDAC_D+0, 1 
	BCF         FARG_writeDAC_D+0, 0 
	RLCF        FARG_writeDAC_D+1, 1 
	CALL        _writeDAC+0, 0
;p8f.c,36 :: 		T0CON.TMR0ON = 1;
	BSF         T0CON+0, 7 
;p8f.c,37 :: 		TMR0H = (ALFA >> 8);
	CLRF        TMR0H+0 
;p8f.c,38 :: 		TMR0L = ALFA;
	MOVLW       6
	MOVWF       TMR0L+0 
;p8f.c,41 :: 		ADCON0.ADON = 0;
	BCF         ADCON0+0, 0 
;p8f.c,42 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;p8f.c,43 :: 		}
L_interrupt3:
;p8f.c,45 :: 		if(INTCON.TMR0IF == 1){
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt4
;p8f.c,48 :: 		ADCON0.ADON = 1;
	BSF         ADCON0+0, 0 
;p8f.c,49 :: 		ADCON0.GO = 1;
	BSF         ADCON0+0, 2 
;p8f.c,52 :: 		T0CON.TMR0ON = 0;
	BCF         T0CON+0, 7 
;p8f.c,53 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;p8f.c,54 :: 		}
L_interrupt4:
;p8f.c,56 :: 		}
L_end_interrupt:
L__interrupt13:
	RETFIE      1
; end of _interrupt

_main:

;p8f.c,58 :: 		void main(){
;p8f.c,61 :: 		TRISA.B2 = 1;
	BSF         TRISA+0, 2 
;p8f.c,62 :: 		TRISC.B0 = 0;
	BCF         TRISC+0, 0 
;p8f.c,63 :: 		TRISC.B3 = 0;
	BCF         TRISC+0, 3 
;p8f.c,64 :: 		TRISC.B5 = 0;
	BCF         TRISC+0, 5 
;p8f.c,67 :: 		T0CON = 0x42;
	MOVLW       66
	MOVWF       T0CON+0 
;p8f.c,70 :: 		TMR0H = (ALFA >> 8);
	CLRF        TMR0H+0 
;p8f.c,71 :: 		TMR0L = ALFA;
	MOVLW       6
	MOVWF       TMR0L+0 
;p8f.c,74 :: 		ADCON0 = 0x51;
	MOVLW       81
	MOVWF       ADCON0+0 
;p8f.c,75 :: 		ADCON1 = 0xC0;
	MOVLW       192
	MOVWF       ADCON1+0 
;p8f.c,78 :: 		INTCON.PEIE = 1;
	BSF         INTCON+0, 6 
;p8f.c,79 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;p8f.c,80 :: 		PIE1.ADIE = 1;
	BSF         PIE1+0, 6 
;p8f.c,83 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;p8f.c,84 :: 		INTCON.TMR0IE = 1;
	BSF         INTCON+0, 5 
;p8f.c,87 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;p8f.c,90 :: 		ADCON0.GO = 1;
	BSF         ADCON0+0, 2 
;p8f.c,92 :: 		while(1){
L_main5:
;p8f.c,94 :: 		}
	GOTO        L_main5
;p8f.c,95 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
