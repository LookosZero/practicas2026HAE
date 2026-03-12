#line 1 "C:/Users/looko/Desktop/trabajos uni/HAE/practicas/estudiar/p1b/p1b.c"
void main(){
 unsigned short leds[9] = {0x00,0x01,0x03,0x07,0x0F,0x1F,0x3F,0x7F,0xFF};
 int i = 0;

 ADCON1 = 0x07;

 TRISC = 0x00;

 PORTC = 0x00;

 while(1){

 PORTC = leds[i];

 i++;
 if(i >= 9){
 i = 0;
 }
 delay_ms(100);
 }
}
