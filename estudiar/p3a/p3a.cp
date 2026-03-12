#line 1 "C:/Users/looko/Desktop/trabajos uni/HAE/practicas/estudiar/p3a/p3a.c"
void main(){
 unsigned int estadoActual = 0;
 unsigned int estadoAnterior = 0;

 ADCON1 = 0x07;

 TRISB.B2 = 1;
 TRISB.B3 = 0;

 PORTB.B2 = 0;
 PORTB.B3 = 0;

 while(1){
 estadoActual = PORTB.B2;

 if(estadoActual == 1 && estadoAnterior == 0){
 if(PORTB.B3 == 1){
 PORTB.B3 = 0;
 }else{
 PORTB.B3 = 1;
 }
 }

 estadoAnterior = estadoActual;
 delay_ms(100);

 }
}
