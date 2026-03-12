#line 1 "C:/Users/looko/Desktop/trabajos uni/HAE/practicas/p3c/p3c.c"
unsigned int unidad = 0;
unsigned int decena = 0;

void interrupt(){


 if(INTCON.INT0IF == 1){
 if(unidad <= 0){
 unidad = 9;
 if(decena <= 0){
 decena = 9;
 }else{
 decena--;
 }
 }else{
 unidad--;
 }
 INTCON.INT0IF = 0;
 }


 if(INTCON3.INT1IF == 1){
 if(unidad >= 9){
 unidad = 0;
 if(decena >= 9){
 decena = 0;
 }else{
 decena ++;
 }
 }else{
 unidad++;
 }
 INTCON3.INT1IF = 0;
 }
}

void main(){

 unsigned int numeros[] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F};

 ADCON1 = 0x07;
 TRISD = 0x00;
 TRISE.B0 = 0;
 TRISE.B1 = 0;

 PORTE.B0 = 1;
 PORTE.B1 = 1;

 PORTD = numeros[0];


 TRISB.B0 = 1;
 INTCON2.INTEDG0 = 1;
 INTCON.INT0IF = 0;
 INTCON.INT0IE = 1;


 TRISB.B1 = 1;
 INTCON2.INTEDG1 = 1;
 INTCON3.INT1IF = 0;
 INTCON3.INT1IE = 1;

 INTCON.GIE = 1;


 while(1){

 PORTE.B1 = 1;
 PORTD = numeros[decena];
 PORTE.B0 = 0;
 delay_ms(15);
 PORTE.B0 = 1;


 PORTD = numeros[unidad];
 PORTE.B1 = 0;
 delay_ms(15);
 PORTE.B1 = 1;

 }

}
