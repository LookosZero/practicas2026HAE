#line 1 "C:/Users/looko/Desktop/trabajos uni/HAE/practicas2026HAE/p4d/p4d.c"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/stdbool.h"



 typedef char _Bool;
#line 3 "C:/Users/looko/Desktop/trabajos uni/HAE/practicas2026HAE/p4d/p4d.c"
int x;
 _Bool  bucleLuz =  0 ;


void interrupt(){
 if(bucleLuz ==  1 ) {
 bucleLuz =  0 ;
 } else {
 bucleLuz =  1 ;
 }

 x = PORTB;
 INTCON.RBIF = 0;
}

void main(){
 ADCON1 = 0x07;

 TRISA.B0 = 0;

 TRISB.B5 = 1;
 x = PORTB;
 INTCON.RBIF = 0;
 INTCON.RBIE = 1;
 INTCON.GIE = 1;

 while(1){
 while(bucleLuz) {
 PORTA.B0 = 0;
 delay_ms(500);
 PORTA.B0 = 1;
 delay_ms(500);
 }
 PORTA.B0 = 0;
 }
}
