#line 1 "C:/Users/looko/Desktop/trabajos uni/HAE/practicas2026HAE/p7b/p7b.c"
void interrupt(){
 if(INTCON.TMR0IF == 1){
 PORTB.B0 = ~PORTB.B0;
 }

 TMR0H = (3036 >> 8);
 TMR0L = 3036;
 INTCON.TMR0IF = 0;
}

void main(){


 TRISB.B0 = 0;
 PORTB.B0 = 0;


 T0CON = 0x84;
 TMR0H = (3036 >> 8);
 TMR0L = 3036;


 INTCON.TMR0IF = 0;
 INTCON.TMR0IE = 1;


 INTCON.GIE = 1;

 while(1){

 }
}
