
_interrupt:

;p5c.c,5 :: 		void interrupt(){
;p5c.c,8 :: 		if(lock == false){
	MOVF        _lock+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt0
;p5c.c,11 :: 		if(INTCON.INT0IF == 1 && INTCON.INT0IE == 1 && PORTB.B0 == 1){
	BTFSS       INTCON+0, 1 
	GOTO        L_interrupt3
	BTFSS       INTCON+0, 4 
	GOTO        L_interrupt3
	BTFSS       PORTB+0, 0 
	GOTO        L_interrupt3
L__interrupt11:
;p5c.c,12 :: 		PORTC.B0 = 1;
	BSF         PORTC+0, 0 
;p5c.c,15 :: 		T0CON.TMR0ON = 1;
	BSF         T0CON+0, 7 
;p5c.c,16 :: 		TMR0H = (18661 >> 8);
	MOVLW       72
	MOVWF       TMR0H+0 
;p5c.c,17 :: 		TMR0L = 18661;
	MOVLW       229
	MOVWF       TMR0L+0 
;p5c.c,20 :: 		lock = true;
	MOVLW       1
	MOVWF       _lock+0 
;p5c.c,21 :: 		INTCON.INT0IF = 0;
	BCF         INTCON+0, 1 
;p5c.c,22 :: 		INTCON.INT0IE = 0;
	BCF         INTCON+0, 4 
;p5c.c,24 :: 		}
L_interrupt3:
;p5c.c,27 :: 		if(INTCON3.INT1IF == 1 && INTCON3.INT1IE == 1 && PORTB.B1 == 1){
	BTFSS       INTCON3+0, 0 
	GOTO        L_interrupt6
	BTFSS       INTCON3+0, 3 
	GOTO        L_interrupt6
	BTFSS       PORTB+0, 1 
	GOTO        L_interrupt6
L__interrupt10:
;p5c.c,28 :: 		PORTC.B7 = 1;
	BSF         PORTC+0, 7 
;p5c.c,31 :: 		T0CON.TMR0ON = 1;
	BSF         T0CON+0, 7 
;p5c.c,32 :: 		TMR0H = (3036 >> 8);
	MOVLW       11
	MOVWF       TMR0H+0 
;p5c.c,33 :: 		TMR0L = 3036;
	MOVLW       220
	MOVWF       TMR0L+0 
;p5c.c,36 :: 		lock = true;
	MOVLW       1
	MOVWF       _lock+0 
;p5c.c,37 :: 		INTCON3.INT1IF = 0;
	BCF         INTCON3+0, 0 
;p5c.c,38 :: 		INTCON3.INT1IE = 0;
	BCF         INTCON3+0, 3 
;p5c.c,40 :: 		}
L_interrupt6:
;p5c.c,41 :: 		}
L_interrupt0:
;p5c.c,44 :: 		if (INTCON.TMR0IF == 1) {
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt7
;p5c.c,46 :: 		lock = false;
	CLRF        _lock+0 
;p5c.c,47 :: 		PORTC.B0 = 0;
	BCF         PORTC+0, 0 
;p5c.c,48 :: 		PORTC.B7 = 0;
	BCF         PORTC+0, 7 
;p5c.c,51 :: 		INTCON.INT0IE = 1;
	BSF         INTCON+0, 4 
;p5c.c,52 :: 		INTCON3.INT1IE = 1;
	BSF         INTCON3+0, 3 
;p5c.c,55 :: 		T0CON.TMR0ON = 0;
	BCF         T0CON+0, 7 
;p5c.c,56 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;p5c.c,57 :: 		}
L_interrupt7:
;p5c.c,58 :: 		}
L_end_interrupt:
L__interrupt13:
	RETFIE      1
; end of _interrupt

_main:

;p5c.c,60 :: 		void main(){
;p5c.c,61 :: 		ADCON1 = 0x07;
	MOVLW       7
	MOVWF       ADCON1+0 
;p5c.c,63 :: 		TRISB.B0 = 1;
	BSF         TRISB+0, 0 
;p5c.c,64 :: 		TRISB.B1 = 1;
	BSF         TRISB+0, 1 
;p5c.c,66 :: 		TRISC.B0 = 0;
	BCF         TRISC+0, 0 
;p5c.c,67 :: 		TRISC.B7 = 0;
	BCF         TRISC+0, 7 
;p5c.c,70 :: 		INTCON2.INTEDG0 = 1;
	BSF         INTCON2+0, 6 
;p5c.c,71 :: 		INTCON.INT0IF = 0;
	BCF         INTCON+0, 1 
;p5c.c,72 :: 		INTCON.INT0IE = 1;
	BSF         INTCON+0, 4 
;p5c.c,75 :: 		INTCON2.INTEDG1 = 1;
	BSF         INTCON2+0, 5 
;p5c.c,76 :: 		INTCON3.INT1IF = 0;
	BCF         INTCON3+0, 0 
;p5c.c,77 :: 		INTCON3.INT1IE = 1;
	BSF         INTCON3+0, 3 
;p5c.c,80 :: 		T0CON = 0x06;
	MOVLW       6
	MOVWF       T0CON+0 
;p5c.c,81 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;p5c.c,82 :: 		INTCON.TMR0IE = 1;
	BSF         INTCON+0, 5 
;p5c.c,84 :: 		INTCON.GIE = 1; // se habilitan las interrupciones en general
	BSF         INTCON+0, 7 
;p5c.c,86 :: 		PORTC.B0 = 0;
	BCF         PORTC+0, 0 
;p5c.c,87 :: 		PORTC.B7 = 0;
	BCF         PORTC+0, 7 
;p5c.c,89 :: 		while(1){
L_main8:
;p5c.c,91 :: 		}
	GOTO        L_main8
;p5c.c,92 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
