#line 1 "C:/Users/looko/Desktop/trabajos uni/HAE/Apracticas/p1b/p1b.c"
void main() {


 int LED[] = {0x01,0x03,0x07,0x0F,0x1F,0x3F,0x7F,0xFF,0x00};

 int i = 0;


 ADCON1 = 0x07;


 TRISC = 0x00;



 while(1){


 PORTC = LED[i];
 delay_ms(100);
 i++;

 if(i>8){
 i = 0;
 }

 }


}
