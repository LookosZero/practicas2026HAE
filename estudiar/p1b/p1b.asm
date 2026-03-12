
_main:

;p1b.c,1 :: 		void main(){
;p1b.c,2 :: 		unsigned short leds[9] = {0x00,0x01,0x03,0x07,0x0F,0x1F,0x3F,0x7F,0xFF};
	CLRF        main_leds_L0+0 
	MOVLW       1
	MOVWF       main_leds_L0+1 
	MOVLW       3
	MOVWF       main_leds_L0+2 
	MOVLW       7
	MOVWF       main_leds_L0+3 
	MOVLW       15
	MOVWF       main_leds_L0+4 
	MOVLW       31
	MOVWF       main_leds_L0+5 
	MOVLW       63
	MOVWF       main_leds_L0+6 
	MOVLW       127
	MOVWF       main_leds_L0+7 
	MOVLW       255
	MOVWF       main_leds_L0+8 
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
;p1b.c,5 :: 		ADCON1 = 0x07; // Configurar las salidas como digitales
	MOVLW       7
	MOVWF       ADCON1+0 
;p1b.c,7 :: 		TRISC = 0x00; // 0 es salida y 1 es entrada
	CLRF        TRISC+0 
;p1b.c,9 :: 		PORTC = 0x00; // Enciende o apaga los pines (0 apagar, 1 encender) o comprobar estados PORTC == 0x00
	CLRF        PORTC+0 
;p1b.c,11 :: 		while(1){
L_main0:
;p1b.c,13 :: 		PORTC = leds[i];
	MOVLW       main_leds_L0+0
	ADDWF       main_i_L0+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(main_leds_L0+0)
	ADDWFC      main_i_L0+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       PORTC+0 
;p1b.c,15 :: 		i++;
	INFSNZ      main_i_L0+0, 1 
	INCF        main_i_L0+1, 1 
;p1b.c,16 :: 		if(i >= 9){
	MOVLW       128
	XORWF       main_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main5
	MOVLW       9
	SUBWF       main_i_L0+0, 0 
L__main5:
	BTFSS       STATUS+0, 0 
	GOTO        L_main2
;p1b.c,17 :: 		i = 0;
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
;p1b.c,18 :: 		}
L_main2:
;p1b.c,19 :: 		delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_main3:
	DECFSZ      R13, 1, 1
	BRA         L_main3
	DECFSZ      R12, 1, 1
	BRA         L_main3
	DECFSZ      R11, 1, 1
	BRA         L_main3
	NOP
;p1b.c,20 :: 		}
	GOTO        L_main0
;p1b.c,21 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
