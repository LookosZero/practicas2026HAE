
_interrupt:

;p7e.c,17 :: 		void interrupt(){
;p7e.c,19 :: 		}
L_end_interrupt:
L__interrupt3:
	RETFIE      1
; end of _interrupt

_main:

;p7e.c,21 :: 		void main(){
;p7e.c,22 :: 		Lcd_init();
	CALL        _Lcd_Init+0, 0
;p7e.c,24 :: 		while(1){
L_main0:
;p7e.c,26 :: 		}
	GOTO        L_main0
;p7e.c,27 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
