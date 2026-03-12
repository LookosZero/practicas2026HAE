#line 1 "C:/Users/Arturo/Desktop/trabajos uni/HAE/practicas/p2a/p2a.c"
void main(){
 unsigned char numeros[] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F};
 unsigned char unidades = 0;
 unsigned char decenas = 0;
 unsigned int contador = 0;

 ADCON1 = 0x07;
 TRISA.B0 = 0;
 TRISA.B1 = 0;
 TRISD = 0x00;

 PORTA.B0 = 0;
 PORTA.B0 = 0;

 PORTD = 0x00;

 while(1){




 PORTA.B1 = 1;
 PORTD = numeros[unidades];
 PORTA.B0 = 0;
 delay_ms(20);


 PORTA.B0 = 1;
 PORTD = numeros[decenas];
 PORTA.B1 = 0;
 delay_ms(20);


 contador++;


 if(contador >= 25){
 contador = 0;
 unidades++;


 if(unidades >= 10){
 unidades = 0;
 decenas++;


 if(decenas >= 6){
 decenas = 0;
 }
 }
 }
 }
}
