
_interrupt:

;p5b.c,5 :: 		void interrupt() {
;p5b.c,7 :: 		if (Q == 0 && PORTB.B0 == 0) {
	MOVLW       0
	XORWF       _Q+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt21
	MOVLW       0
	XORWF       _Q+0, 0 
L__interrupt21:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt2
	BTFSC       PORTB+0, 0 
	GOTO        L_interrupt2
L__interrupt18:
;p5b.c,8 :: 		Q = 0;
	CLRF        _Q+0 
	CLRF        _Q+1 
;p5b.c,9 :: 		}
L_interrupt2:
;p5b.c,10 :: 		if (Q == 0 && PORTB.B0 == 1) {
	MOVLW       0
	XORWF       _Q+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt22
	MOVLW       0
	XORWF       _Q+0, 0 
L__interrupt22:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt5
	BTFSS       PORTB+0, 0 
	GOTO        L_interrupt5
L__interrupt17:
;p5b.c,11 :: 		Q = 1;
	MOVLW       1
	MOVWF       _Q+0 
	MOVLW       0
	MOVWF       _Q+1 
;p5b.c,12 :: 		}
L_interrupt5:
;p5b.c,13 :: 		if (Q == 1 && PORTB.B0 == 1) {
	MOVLW       0
	XORWF       _Q+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt23
	MOVLW       1
	XORWF       _Q+0, 0 
L__interrupt23:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt8
	BTFSS       PORTB+0, 0 
	GOTO        L_interrupt8
L__interrupt16:
;p5b.c,14 :: 		Q = 1;
	MOVLW       1
	MOVWF       _Q+0 
	MOVLW       0
	MOVWF       _Q+1 
;p5b.c,15 :: 		}
L_interrupt8:
;p5b.c,16 :: 		if (Q == 1 && PORTB.B0 == 0) {
	MOVLW       0
	XORWF       _Q+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt24
	MOVLW       1
	XORWF       _Q+0, 0 
L__interrupt24:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt11
	BTFSC       PORTB+0, 0 
	GOTO        L_interrupt11
L__interrupt15:
;p5b.c,17 :: 		Q = 2;
	MOVLW       2
	MOVWF       _Q+0 
	MOVLW       0
	MOVWF       _Q+1 
;p5b.c,18 :: 		m = ~m;
	COMF        _m+0, 1 
	COMF        _m+1, 1 
;p5b.c,19 :: 		}
L_interrupt11:
;p5b.c,20 :: 		if (Q == 2){
	MOVLW       0
	XORWF       _Q+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt25
	MOVLW       2
	XORWF       _Q+0, 0 
L__interrupt25:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt12
;p5b.c,21 :: 		Q = 0;
	CLRF        _Q+0 
	CLRF        _Q+1 
;p5b.c,22 :: 		}
L_interrupt12:
;p5b.c,24 :: 		PORTB.B3 = m;
	BTFSC       _m+0, 0 
	GOTO        L__interrupt26
	BCF         PORTB+0, 3 
	GOTO        L__interrupt27
L__interrupt26:
	BSF         PORTB+0, 3 
L__interrupt27:
;p5b.c,25 :: 		TMR0H = (30536 >> 8);
	MOVLW       119
	MOVWF       TMR0H+0 
;p5b.c,26 :: 		TMR0L = 30536;
	MOVLW       72
	MOVWF       TMR0L+0 
;p5b.c,27 :: 		INTCON.TMR0IF = 0; // se borra el flag
	BCF         INTCON+0, 2 
;p5b.c,29 :: 		}
L_end_interrupt:
L__interrupt20:
	RETFIE      1
; end of _interrupt

_main:

;p5b.c,31 :: 		void main() {
;p5b.c,33 :: 		ADCON1 = 0x07;
	MOVLW       7
	MOVWF       ADCON1+0 
;p5b.c,36 :: 		TRISA.B0 = 1;
	BSF         TRISA+0, 0 
;p5b.c,37 :: 		TRISA.B3 = 0;
	BCF         TRISA+0, 3 
;p5b.c,38 :: 		PORTA.B3 = 0;
	BCF         PORTA+0, 3 
;p5b.c,41 :: 		T0CON = 0xB4;
	MOVLW       180
	MOVWF       T0CON+0 
;p5b.c,42 :: 		INTCON.TMR0IF = 0; // Se pone el flag a 0
	BCF         INTCON+0, 2 
;p5b.c,43 :: 		INTCON.TMR0IE = 1; // Se habilita la interrupción del Timer 0
	BSF         INTCON+0, 5 
;p5b.c,44 :: 		INTCON.GIE = 1; // Se habilitan las interrupciones en general
	BSF         INTCON+0, 7 
;p5b.c,46 :: 		TMR0H = (30536 >> 8);
	MOVLW       119
	MOVWF       TMR0H+0 
;p5b.c,47 :: 		TMR0L = 30536; //se carga el valor inicial (alfa) del contador
	MOVLW       72
	MOVWF       TMR0L+0 
;p5b.c,49 :: 		while(1) {
L_main13:
;p5b.c,51 :: 		}
	GOTO        L_main13
;p5b.c,52 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
