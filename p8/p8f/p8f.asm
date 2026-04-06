
_sendDAC:

;p8f.c,5 :: 		void sendDAC(int D){
;p8f.c,6 :: 		if(D > 1023){
	MOVLW       128
	XORLW       3
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_sendDAC_D+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__sendDAC6
	MOVF        FARG_sendDAC_D+0, 0 
	SUBLW       255
L__sendDAC6:
	BTFSC       STATUS+0, 0 
	GOTO        L_sendDAC0
;p8f.c,7 :: 		D = 1023;
	MOVLW       255
	MOVWF       FARG_sendDAC_D+0 
	MOVLW       3
	MOVWF       FARG_sendDAC_D+1 
;p8f.c,8 :: 		}
L_sendDAC0:
;p8f.c,9 :: 		SPI1_Init();
	CALL        _SPI1_Init+0, 0
;p8f.c,10 :: 		PORTC.B0 = 0;
	BCF         PORTC+0, 0 
;p8f.c,11 :: 		SPI1_Write(D >> 6);
	MOVLW       6
	MOVWF       R2 
	MOVF        FARG_sendDAC_D+0, 0 
	MOVWF       R0 
	MOVF        FARG_sendDAC_D+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__sendDAC7:
	BZ          L__sendDAC8
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	ADDLW       255
	GOTO        L__sendDAC7
L__sendDAC8:
	MOVF        R0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;p8f.c,12 :: 		SPI1_Write(D << 2);
	MOVF        FARG_sendDAC_D+0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	RLCF        FARG_SPI1_Write_data_+0, 1 
	BCF         FARG_SPI1_Write_data_+0, 0 
	RLCF        FARG_SPI1_Write_data_+0, 1 
	BCF         FARG_SPI1_Write_data_+0, 0 
	CALL        _SPI1_Write+0, 0
;p8f.c,13 :: 		PORTC.B0 = 1;
	BSF         PORTC+0, 0 
;p8f.c,14 :: 		}
L_end_sendDAC:
	RETURN      0
; end of _sendDAC

_interrupt:

;p8f.c,16 :: 		void interrupt(){
;p8f.c,18 :: 		if(PIR1.ADIF == 1){
	BTFSS       PIR1+0, 6 
	GOTO        L_interrupt1
;p8f.c,21 :: 		aux = (ADRESH << 8) + ADRESL;
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
;p8f.c,24 :: 		sendDAC(aux * 4);
	MOVF        R2, 0 
	MOVWF       FARG_sendDAC_D+0 
	MOVF        R3, 0 
	MOVWF       FARG_sendDAC_D+1 
	RLCF        FARG_sendDAC_D+0, 1 
	BCF         FARG_sendDAC_D+0, 0 
	RLCF        FARG_sendDAC_D+1, 1 
	RLCF        FARG_sendDAC_D+0, 1 
	BCF         FARG_sendDAC_D+0, 0 
	RLCF        FARG_sendDAC_D+1, 1 
	CALL        _sendDAC+0, 0
;p8f.c,27 :: 		T0CON.TMR0ON = 1;
	BSF         T0CON+0, 7 
;p8f.c,28 :: 		TMR0H = (ALFA >> 8);
	CLRF        TMR0H+0 
;p8f.c,29 :: 		TMR0L = ALFA;
	MOVLW       6
	MOVWF       TMR0L+0 
;p8f.c,32 :: 		ADCON0.ADON = 0;
	BCF         ADCON0+0, 0 
;p8f.c,33 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;p8f.c,34 :: 		}
L_interrupt1:
;p8f.c,36 :: 		if(INTCON.TMR0IF == 1){
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt2
;p8f.c,39 :: 		ADCON0.ADON = 1;
	BSF         ADCON0+0, 0 
;p8f.c,40 :: 		ADCON0.GO = 1;
	BSF         ADCON0+0, 2 
;p8f.c,43 :: 		T0CON.TMR0ON = 0;
	BCF         T0CON+0, 7 
;p8f.c,44 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;p8f.c,45 :: 		}
L_interrupt2:
;p8f.c,47 :: 		}
L_end_interrupt:
L__interrupt10:
	RETFIE      1
; end of _interrupt

_main:

;p8f.c,49 :: 		void main(){
;p8f.c,52 :: 		TRISA.B2 = 1;
	BSF         TRISA+0, 2 
;p8f.c,53 :: 		TRISC.B0 = 0;
	BCF         TRISC+0, 0 
;p8f.c,54 :: 		TRISC.B3 = 0;
	BCF         TRISC+0, 3 
;p8f.c,55 :: 		TRISC.B5 = 0;
	BCF         TRISC+0, 5 
;p8f.c,58 :: 		T0CON = 0x42;
	MOVLW       66
	MOVWF       T0CON+0 
;p8f.c,61 :: 		TMR0H = (ALFA >> 8);
	CLRF        TMR0H+0 
;p8f.c,62 :: 		TMR0L = ALFA;
	MOVLW       6
	MOVWF       TMR0L+0 
;p8f.c,65 :: 		ADCON0 = 0x51;
	MOVLW       81
	MOVWF       ADCON0+0 
;p8f.c,66 :: 		ADCON1 = 0xC0;
	MOVLW       192
	MOVWF       ADCON1+0 
;p8f.c,69 :: 		INTCON.PEIE = 1;
	BSF         INTCON+0, 6 
;p8f.c,70 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;p8f.c,71 :: 		PIE1.ADIE = 1;
	BSF         PIE1+0, 6 
;p8f.c,74 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;p8f.c,75 :: 		INTCON.TMR0IE = 1;
	BSF         INTCON+0, 5 
;p8f.c,78 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;p8f.c,81 :: 		ADCON0.GO = 1;
	BSF         ADCON0+0, 2 
;p8f.c,83 :: 		while(1){
L_main3:
;p8f.c,85 :: 		}
	GOTO        L_main3
;p8f.c,86 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
