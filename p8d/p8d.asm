
_floatToInt:

;p8d.c,3 :: 		int floatToInt(float value){
;p8d.c,4 :: 		if (value >= 0.0f) {
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
;p8d.c,5 :: 		return (int)(value + 0.5f);
	MOVF        FARG_floatToInt_value+0, 0 
	MOVWF       R0 
	MOVF        FARG_floatToInt_value+1, 0 
	MOVWF       R1 
	MOVF        FARG_floatToInt_value+2, 0 
	MOVWF       R2 
	MOVF        FARG_floatToInt_value+3, 0 
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
;p8d.c,6 :: 		} else {
L_floatToInt0:
;p8d.c,7 :: 		return (int)(value - 0.5f);
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       126
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
;p8d.c,9 :: 		}
L_end_floatToInt:
	RETURN      0
; end of _floatToInt

_digitalVoltage:

;p8d.c,11 :: 		int digitalVoltage(float v, float lambda){
;p8d.c,13 :: 		D = v/lambda;
	MOVF        FARG_digitalVoltage_lambda+0, 0 
	MOVWF       R4 
	MOVF        FARG_digitalVoltage_lambda+1, 0 
	MOVWF       R5 
	MOVF        FARG_digitalVoltage_lambda+2, 0 
	MOVWF       R6 
	MOVF        FARG_digitalVoltage_lambda+3, 0 
	MOVWF       R7 
	MOVF        FARG_digitalVoltage_v+0, 0 
	MOVWF       R0 
	MOVF        FARG_digitalVoltage_v+1, 0 
	MOVWF       R1 
	MOVF        FARG_digitalVoltage_v+2, 0 
	MOVWF       R2 
	MOVF        FARG_digitalVoltage_v+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
;p8d.c,15 :: 		return floatToInt(D);
	MOVF        R0, 0 
	MOVWF       FARG_floatToInt_value+0 
	MOVF        R1, 0 
	MOVWF       FARG_floatToInt_value+1 
	MOVF        R2, 0 
	MOVWF       FARG_floatToInt_value+2 
	MOVF        R3, 0 
	MOVWF       FARG_floatToInt_value+3 
	CALL        _floatToInt+0, 0
;p8d.c,16 :: 		}
L_end_digitalVoltage:
	RETURN      0
; end of _digitalVoltage

_main:

;p8d.c,18 :: 		void main(){
;p8d.c,20 :: 		float voltage = 0.0;
;p8d.c,21 :: 		int D = 0;
	CLRF        main_D_L0+0 
	CLRF        main_D_L0+1 
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
;p8d.c,25 :: 		TRISC.B0 = 0;
	BCF         TRISC+0, 0 
;p8d.c,26 :: 		TRISC.B3 = 0;
	BCF         TRISC+0, 3 
;p8d.c,27 :: 		TRISC.B5 = 0;
	BCF         TRISC+0, 5 
;p8d.c,29 :: 		SPI1_Init();
	CALL        _SPI1_Init+0, 0
;p8d.c,31 :: 		while(1){
L_main2:
;p8d.c,35 :: 		D = digitalVoltage(voltage, LAMBDA);
	MOVLW       0
	MOVWF       FARG_digitalVoltage_v+0 
	MOVLW       0
	MOVWF       FARG_digitalVoltage_v+1 
	MOVLW       32
	MOVWF       FARG_digitalVoltage_v+2 
	MOVLW       128
	MOVWF       FARG_digitalVoltage_v+3 
	MOVLW       82
	MOVWF       FARG_digitalVoltage_lambda+0 
	MOVLW       39
	MOVWF       FARG_digitalVoltage_lambda+1 
	MOVLW       32
	MOVWF       FARG_digitalVoltage_lambda+2 
	MOVLW       119
	MOVWF       FARG_digitalVoltage_lambda+3 
	CALL        _digitalVoltage+0, 0
	MOVF        R0, 0 
	MOVWF       main_D_L0+0 
	MOVF        R1, 0 
	MOVWF       main_D_L0+1 
;p8d.c,38 :: 		PORTC.B0 = 0; // SYNC = 0
	BCF         PORTC+0, 0 
;p8d.c,39 :: 		SPI1_Write(D >> 6);
	MOVLW       6
	MOVWF       R4 
	MOVF        R0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       R3 
	MOVF        R4, 0 
L__main16:
	BZ          L__main17
	RRCF        R3, 1 
	RRCF        R2, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
	ADDLW       255
	GOTO        L__main16
L__main17:
	MOVF        R2, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;p8d.c,40 :: 		SPI1_Write(D << 2);
	MOVF        main_D_L0+0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	RLCF        FARG_SPI1_Write_data_+0, 1 
	BCF         FARG_SPI1_Write_data_+0, 0 
	RLCF        FARG_SPI1_Write_data_+0, 1 
	BCF         FARG_SPI1_Write_data_+0, 0 
	CALL        _SPI1_Write+0, 0
;p8d.c,41 :: 		PORTC.B0 = 1; // SYNC = 1
	BSF         PORTC+0, 0 
;p8d.c,42 :: 		delay_ms(70);
	MOVLW       182
	MOVWF       R12, 0
	MOVLW       208
	MOVWF       R13, 0
L_main4:
	DECFSZ      R13, 1, 1
	BRA         L_main4
	DECFSZ      R12, 1, 1
	BRA         L_main4
	NOP
;p8d.c,49 :: 		i = 0;
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
;p8d.c,50 :: 		for(i = 0; i <= 512; i++){
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
L_main5:
	MOVLW       128
	XORLW       2
	MOVWF       R0 
	MOVLW       128
	XORWF       main_i_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main18
	MOVF        main_i_L0+0, 0 
	SUBLW       0
L__main18:
	BTFSS       STATUS+0, 0 
	GOTO        L_main6
;p8d.c,51 :: 		voltage = 2.5 + (2.5 * i) / 512.0;
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVF        main_i_L0+1, 0 
	MOVWF       R1 
	CALL        _int2double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       128
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       136
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       128
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
;p8d.c,52 :: 		D = digitalVoltage(voltage, LAMBDA);
	MOVF        R0, 0 
	MOVWF       FARG_digitalVoltage_v+0 
	MOVF        R1, 0 
	MOVWF       FARG_digitalVoltage_v+1 
	MOVF        R2, 0 
	MOVWF       FARG_digitalVoltage_v+2 
	MOVF        R3, 0 
	MOVWF       FARG_digitalVoltage_v+3 
	MOVLW       82
	MOVWF       FARG_digitalVoltage_lambda+0 
	MOVLW       39
	MOVWF       FARG_digitalVoltage_lambda+1 
	MOVLW       32
	MOVWF       FARG_digitalVoltage_lambda+2 
	MOVLW       119
	MOVWF       FARG_digitalVoltage_lambda+3 
	CALL        _digitalVoltage+0, 0
	MOVF        R0, 0 
	MOVWF       main_D_L0+0 
	MOVF        R1, 0 
	MOVWF       main_D_L0+1 
;p8d.c,54 :: 		PORTC.B0 = 0;
	BCF         PORTC+0, 0 
;p8d.c,55 :: 		SPI1_Write(D >> 6);
	MOVLW       6
	MOVWF       R4 
	MOVF        R0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       R3 
	MOVF        R4, 0 
L__main19:
	BZ          L__main20
	RRCF        R3, 1 
	RRCF        R2, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
	ADDLW       255
	GOTO        L__main19
L__main20:
	MOVF        R2, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;p8d.c,56 :: 		SPI1_Write(D << 2);
	MOVF        main_D_L0+0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	RLCF        FARG_SPI1_Write_data_+0, 1 
	BCF         FARG_SPI1_Write_data_+0, 0 
	RLCF        FARG_SPI1_Write_data_+0, 1 
	BCF         FARG_SPI1_Write_data_+0, 0 
	CALL        _SPI1_Write+0, 0
;p8d.c,57 :: 		PORTC.B0 = 1;
	BSF         PORTC+0, 0 
;p8d.c,59 :: 		delay_us(56);  // espera aprox. 56 microsegundos para que la subida dure 28.75 ms
	MOVLW       37
	MOVWF       R13, 0
L_main8:
	DECFSZ      R13, 1, 1
	BRA         L_main8
;p8d.c,50 :: 		for(i = 0; i <= 512; i++){
	INFSNZ      main_i_L0+0, 1 
	INCF        main_i_L0+1, 1 
;p8d.c,60 :: 		}
	GOTO        L_main5
L_main6:
;p8d.c,64 :: 		D = digitalVoltage(voltage, LAMBDA);
	CLRF        FARG_digitalVoltage_v+0 
	CLRF        FARG_digitalVoltage_v+1 
	CLRF        FARG_digitalVoltage_v+2 
	CLRF        FARG_digitalVoltage_v+3 
	MOVLW       82
	MOVWF       FARG_digitalVoltage_lambda+0 
	MOVLW       39
	MOVWF       FARG_digitalVoltage_lambda+1 
	MOVLW       32
	MOVWF       FARG_digitalVoltage_lambda+2 
	MOVLW       119
	MOVWF       FARG_digitalVoltage_lambda+3 
	CALL        _digitalVoltage+0, 0
	MOVF        R0, 0 
	MOVWF       main_D_L0+0 
	MOVF        R1, 0 
	MOVWF       main_D_L0+1 
;p8d.c,66 :: 		PORTC.B0 = 0; // SYNC = 0
	BCF         PORTC+0, 0 
;p8d.c,67 :: 		SPI1_Write(D >> 6);
	MOVLW       6
	MOVWF       R4 
	MOVF        R0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       R3 
	MOVF        R4, 0 
L__main21:
	BZ          L__main22
	RRCF        R3, 1 
	RRCF        R2, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
	ADDLW       255
	GOTO        L__main21
L__main22:
	MOVF        R2, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;p8d.c,68 :: 		SPI1_Write(D << 2);
	MOVF        main_D_L0+0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	RLCF        FARG_SPI1_Write_data_+0, 1 
	BCF         FARG_SPI1_Write_data_+0, 0 
	RLCF        FARG_SPI1_Write_data_+0, 1 
	BCF         FARG_SPI1_Write_data_+0, 0 
	CALL        _SPI1_Write+0, 0
;p8d.c,69 :: 		PORTC.B0 = 1; // SYNC = 1
	BSF         PORTC+0, 0 
;p8d.c,72 :: 		i = 0;
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
;p8d.c,73 :: 		for(i = 0; i <= 512; i++){
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
L_main9:
	MOVLW       128
	XORLW       2
	MOVWF       R0 
	MOVLW       128
	XORWF       main_i_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main23
	MOVF        main_i_L0+0, 0 
	SUBLW       0
L__main23:
	BTFSS       STATUS+0, 0 
	GOTO        L_main10
;p8d.c,74 :: 		voltage = (2.5 * i) / 512.0;
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVF        main_i_L0+1, 0 
	MOVWF       R1 
	CALL        _int2double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       128
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       136
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
;p8d.c,75 :: 		D = digitalVoltage(voltage, LAMBDA);
	MOVF        R0, 0 
	MOVWF       FARG_digitalVoltage_v+0 
	MOVF        R1, 0 
	MOVWF       FARG_digitalVoltage_v+1 
	MOVF        R2, 0 
	MOVWF       FARG_digitalVoltage_v+2 
	MOVF        R3, 0 
	MOVWF       FARG_digitalVoltage_v+3 
	MOVLW       82
	MOVWF       FARG_digitalVoltage_lambda+0 
	MOVLW       39
	MOVWF       FARG_digitalVoltage_lambda+1 
	MOVLW       32
	MOVWF       FARG_digitalVoltage_lambda+2 
	MOVLW       119
	MOVWF       FARG_digitalVoltage_lambda+3 
	CALL        _digitalVoltage+0, 0
	MOVF        R0, 0 
	MOVWF       main_D_L0+0 
	MOVF        R1, 0 
	MOVWF       main_D_L0+1 
;p8d.c,77 :: 		PORTC.B0 = 0;
	BCF         PORTC+0, 0 
;p8d.c,78 :: 		SPI1_Write(D >> 6);
	MOVLW       6
	MOVWF       R4 
	MOVF        R0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       R3 
	MOVF        R4, 0 
L__main24:
	BZ          L__main25
	RRCF        R3, 1 
	RRCF        R2, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
	ADDLW       255
	GOTO        L__main24
L__main25:
	MOVF        R2, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;p8d.c,79 :: 		SPI1_Write(D << 2);
	MOVF        main_D_L0+0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	RLCF        FARG_SPI1_Write_data_+0, 1 
	BCF         FARG_SPI1_Write_data_+0, 0 
	RLCF        FARG_SPI1_Write_data_+0, 1 
	BCF         FARG_SPI1_Write_data_+0, 0 
	CALL        _SPI1_Write+0, 0
;p8d.c,80 :: 		PORTC.B0 = 1;
	BSF         PORTC+0, 0 
;p8d.c,82 :: 		delay_us(56);  // espera aprox. 56 microsegundos para que la subida dure 28.75 ms
	MOVLW       37
	MOVWF       R13, 0
L_main12:
	DECFSZ      R13, 1, 1
	BRA         L_main12
;p8d.c,73 :: 		for(i = 0; i <= 512; i++){
	INFSNZ      main_i_L0+0, 1 
	INCF        main_i_L0+1, 1 
;p8d.c,83 :: 		}
	GOTO        L_main9
L_main10:
;p8d.c,84 :: 		}
	GOTO        L_main2
;p8d.c,85 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
