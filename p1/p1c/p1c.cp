#line 1 "C:/Users/looko/Desktop/trabajos uni/HAE/Apracticas/p1c/p1c.c"
void main() {

 int LEDS[] = {0xFE, 0xFD, 0xFB, 0xF7, 0xEF, 0xDF, 0xBF, 0x7F};
 int i = 0;

 ADCON1 = 0x07;

 TRISC = 0x00;

 TRISB.B3 = 1;

 PORTC = 0xFF;

 while(1){

 if(PORTB.B3 == 1){

 PORTC = LEDS[i];
 delay_ms(100);
 i++;

 if(i >= 8){
 i = 0;
 }
 }else{
 PORTC = 0xFF;
 i = 0;
 delay_ms(10);
 }

 }


}
