#line 1 "C:/Users/looko/Desktop/trabajos uni/HAE/practicas/estudiar/p1cdeberes/p1cdeberes.c"
void main() {
 int secuencia[14] = {0xFE,0xFD,0xFB,0xF7,0xEF,0xDF,0xBF,0x7F,0xBF,0xDF,0xEF,0xF7,0xFB,0xFD};
 int i=0;

 TRISB.B3 = 1;
 TRISC = 0;
 PORTC = 0;

 while(1)
 {

 if(PORTB.B3 == 1) {

 PORTC = secuencia[i];
 i++;


 if(i>=14) {
 i = 0;
 }


 delay_ms(100);
 }
 }
}
