#line 1 "C:/Users/looko/Desktop/trabajos uni/HAE/Apracticas/p1d/p1d.c"
void main() {

 int LEDS[] = {0xFE, 0xFD, 0xFB, 0xF7, 0xEF, 0xDF, 0xBF, 0x7F};
 int i = 0;
 int direccion = 1;

 ADCON1 = 0x07;

 TRISC = 0x00;

 TRISB.B3 = 1;


 while(1){
 if(PORTB.B3 == 0){
 PORTC = LEDS[i];
 delay_ms(100);

 i = i + direccion;

 if(i >= 7){
 direccion = -1;
 }else if(i<=0){
 direccion = 1;
 }
 }else{
 PORTC = 0xFF;
 }

 }
}
