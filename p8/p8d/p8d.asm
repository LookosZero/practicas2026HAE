
_sendDAC:

;p8d.c,13 :: 		void sendDAC(int D){
;p8d.c,14 :: 		PORTC.B0 = 0; // SYNC = 0
	BCF         PORTC+0, 0 
;p8d.c,15 :: 		SPI1_Write(D >> 6);
	MOVLW       6
	MOVWF       R2 
	MOVF        FARG_sendDAC_D+0, 0 
	MOVWF       R0 
	MOVF        FARG_sendDAC_D+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__sendDAC12:
	BZ          L__sendDAC13
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	ADDLW       255
	GOTO        L__sendDAC12
L__sendDAC13:
	MOVF        R0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;p8d.c,16 :: 		SPI1_Write(D << 2);
	MOVF        FARG_sendDAC_D+0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	RLCF        FARG_SPI1_Write_data_+0, 1 
	BCF         FARG_SPI1_Write_data_+0, 0 
	RLCF        FARG_SPI1_Write_data_+0, 1 
	BCF         FARG_SPI1_Write_data_+0, 0 
	CALL        _SPI1_Write+0, 0
;p8d.c,17 :: 		PORTC.B0 = 1; // SYNC = 1
	BSF         PORTC+0, 0 
;p8d.c,18 :: 		}
L_end_sendDAC:
	RETURN      0
; end of _sendDAC

_main:

;p8d.c,20 :: 		void main(){
;p8d.c,22 :: 		unsigned int D = 0;
;p8d.c,23 :: 		unsigned int i = 0;
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
;p8d.c,26 :: 		TRISC.B0 = 0;
	BCF         TRISC+0, 0 
;p8d.c,27 :: 		TRISC.B3 = 0;
	BCF         TRISC+0, 3 
;p8d.c,28 :: 		TRISC.B5 = 0;
	BCF         TRISC+0, 5 
;p8d.c,30 :: 		SPI1_Init();
	CALL        _SPI1_Init+0, 0
;p8d.c,32 :: 		while(1){
L_main0:
;p8d.c,35 :: 		for(i = 0; i < HOLD_2V5_SAMPLES; i++){
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
L_main2:
	MOVLW       4
	SUBWF       main_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main15
	MOVLW       224
	SUBWF       main_i_L0+0, 0 
L__main15:
	BTFSC       STATUS+0, 0 
	GOTO        L_main3
;p8d.c,36 :: 		sendDAC(DAC_2V5);
	MOVLW       0
	MOVWF       FARG_sendDAC_D+0 
	MOVLW       2
	MOVWF       FARG_sendDAC_D+1 
	CALL        _sendDAC+0, 0
;p8d.c,35 :: 		for(i = 0; i < HOLD_2V5_SAMPLES; i++){
	INFSNZ      main_i_L0+0, 1 
	INCF        main_i_L0+1, 1 
;p8d.c,37 :: 		}
	GOTO        L_main2
L_main3:
;p8d.c,40 :: 		for(i = 0; i < RAMP_SAMPLES; i++){
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
L_main5:
	MOVLW       2
	SUBWF       main_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main16
	MOVLW       0
	SUBWF       main_i_L0+0, 0 
L__main16:
	BTFSC       STATUS+0, 0 
	GOTO        L_main6
;p8d.c,41 :: 		D = DAC_2V5 + i;
	MOVLW       0
	ADDWF       main_i_L0+0, 0 
	MOVWF       FARG_sendDAC_D+0 
	MOVLW       2
	ADDWFC      main_i_L0+1, 0 
	MOVWF       FARG_sendDAC_D+1 
;p8d.c,42 :: 		sendDAC(D);
	CALL        _sendDAC+0, 0
;p8d.c,40 :: 		for(i = 0; i < RAMP_SAMPLES; i++){
	INFSNZ      main_i_L0+0, 1 
	INCF        main_i_L0+1, 1 
;p8d.c,43 :: 		}
	GOTO        L_main5
L_main6:
;p8d.c,46 :: 		sendDAC(DAC_0V);
	CLRF        FARG_sendDAC_D+0 
	CLRF        FARG_sendDAC_D+1 
	CALL        _sendDAC+0, 0
;p8d.c,49 :: 		for(i = 0; i < RAMP_SAMPLES; i++){
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
L_main8:
	MOVLW       2
	SUBWF       main_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main17
	MOVLW       0
	SUBWF       main_i_L0+0, 0 
L__main17:
	BTFSC       STATUS+0, 0 
	GOTO        L_main9
;p8d.c,51 :: 		sendDAC(D);
	MOVF        main_i_L0+0, 0 
	MOVWF       FARG_sendDAC_D+0 
	MOVF        main_i_L0+1, 0 
	MOVWF       FARG_sendDAC_D+1 
	CALL        _sendDAC+0, 0
;p8d.c,49 :: 		for(i = 0; i < RAMP_SAMPLES; i++){
	INFSNZ      main_i_L0+0, 1 
	INCF        main_i_L0+1, 1 
;p8d.c,52 :: 		}
	GOTO        L_main8
L_main9:
;p8d.c,53 :: 		}
	GOTO        L_main0
;p8d.c,54 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
