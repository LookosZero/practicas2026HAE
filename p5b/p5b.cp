#line 1 "C:/Users/looko/Desktop/trabajos uni/HAE/practicas2026HAE/p5b/p5b.c"

int Q = 0;
int m = 0;

void interrupt() {

 if (Q == 0 && PORTB.B0 == 0) {
 Q = 0;
 }
 if (Q == 0 && PORTB.B0 == 1) {
 Q = 1;
 }
 if (Q == 1 && PORTB.B0 == 1) {
 Q = 1;
 }
 if (Q == 1 && PORTB.B0 == 0) {
 Q = 2;
 m = ~m;
 }
 if (Q == 2){
 Q = 0;
 }

 PORTB.B3 = m;
 TMR0H = (30536 >> 8);
 TMR0L = 30536;
 INTCON.TMR0IF = 0;

}

void main() {

 ADCON1 = 0x07;


 TRISA.B0 = 1;
 TRISA.B3 = 0;
 PORTA.B3 = 0;


 T0CON = 0xB4;
 INTCON.TMR0IF = 0;
 INTCON.TMR0IE = 1;
 INTCON.GIE = 1;

 TMR0H = (30536 >> 8);
 TMR0L = 30536;

 while(1) {

 }
}
