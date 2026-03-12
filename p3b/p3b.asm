
_interrupt:

;p3b.c,1 :: 		void interrupt(){
;p3b.c,3 :: 		if(PORTB.B3 == 0){
	BTFSC       PORTB+0, 3 
	GOTO        L_interrupt0
;p3b.c,4 :: 		PORTB.B3 = 1;
	BSF         PORTB+0, 3 
;p3b.c,5 :: 		}else{
	GOTO        L_interrupt1
L_interrupt0:
;p3b.c,6 :: 		PORTB.B3 = 0;
	BCF         PORTB+0, 3 
;p3b.c,7 :: 		}
L_interrupt1:
;p3b.c,9 :: 		INTCON3.INT2IF = 0; // Se borra el flag de la interrupcion INT2
	BCF         INTCON3+0, 1 
;p3b.c,10 :: 		}
L_end_interrupt:
L__interrupt5:
	RETFIE      1
; end of _interrupt

_main:

;p3b.c,12 :: 		void main(){
;p3b.c,14 :: 		TRISB.B2 = 1; // Se configura RB2 como entrada
	BSF         TRISB+0, 2 
;p3b.c,15 :: 		INTCON2.INTEDG2 = 1; // Configurado a flancos de subida
	BSF         INTCON2+0, 4 
;p3b.c,16 :: 		INTCON3.INT2IF = 0; // Flag de interrupcion INT2 a 0
	BCF         INTCON3+0, 1 
;p3b.c,17 :: 		INTCON3.INT2IE = 1; // Se habilita la interrupcion INT2
	BSF         INTCON3+0, 4 
;p3b.c,18 :: 		INTCON.GIE = 1; // Se habilitan las interrupciones en general
	BSF         INTCON+0, 7 
;p3b.c,20 :: 		TRISB.B3 = 0;
	BCF         TRISB+0, 3 
;p3b.c,21 :: 		PORTB.B3 = 0;
	BCF         PORTB+0, 3 
;p3b.c,23 :: 		while(1){
L_main2:
;p3b.c,25 :: 		}
	GOTO        L_main2
;p3b.c,26 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
