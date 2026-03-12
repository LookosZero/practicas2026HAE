#line 1 "C:/Users/looko/Desktop/trabajos uni/HAE/practicas/p5c/p5c.c"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/stdbool.h"



 typedef char _Bool;
#line 3 "C:/Users/looko/Desktop/trabajos uni/HAE/practicas/p5c/p5c.c"
 _Bool  lock =  0 ;

void interrupt(){


 if(lock ==  0 ){


 if(INTCON.INT0IF == 1 && INTCON.INT0IE == 1 && PORTB.B0 == 1){
 PORTC.B0 = 1;


 T0CON.TMR0ON = 1;
 TMR0H = (18661 >> 8);
 TMR0L = 18661;


 lock =  1 ;
 INTCON.INT0IF = 0;
 INTCON.INT0IE = 0;

 }


 if(INTCON3.INT1IF == 1 && INTCON3.INT1IE == 1 && PORTB.B1 == 1){
 PORTC.B7 = 1;


 T0CON.TMR0ON = 1;
 TMR0H = (3036 >> 8);
 TMR0L = 3036;


 lock =  1 ;
 INTCON3.INT1IF = 0;
 INTCON3.INT1IE = 0;

 }
 }


 if (INTCON.TMR0IF == 1) {

 lock =  0 ;
 PORTC.B0 = 0;
 PORTC.B7 = 0;


 INTCON.INT0IE = 1;
 INTCON3.INT1IE = 1;


 T0CON.TMR0ON = 0;
 INTCON.TMR0IF = 0;
 }
}

void main(){
 ADCON1 = 0x07;

 TRISB.B0 = 1;
 TRISB.B1 = 1;

 TRISC.B0 = 0;
 TRISC.B7 = 0;


 INTCON2.INTEDG0 = 1;
 INTCON.INT0IF = 0;
 INTCON.INT0IE = 1;


 INTCON2.INTEDG1 = 1;
 INTCON3.INT1IF = 0;
 INTCON3.INT1IE = 1;


 T0CON = 0x06;
 INTCON.TMR0IF = 0;
 INTCON.TMR0IE = 1;

 INTCON.GIE = 1;

 PORTC.B0 = 0;
 PORTC.B7 = 0;

 while(1){

 }
}
