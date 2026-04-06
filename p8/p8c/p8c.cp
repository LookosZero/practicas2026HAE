#line 1 "C:/Users/Lookos/Desktop/Trabajos Uni/practicas2026HAE/p8c/p8c.c"
void main(){
 int D = 757;


 TRISC.B0 = 0;
 TRISC.B3 = 0;
 TRISC.B5 = 0;

 SPI1_Init();

 PORTC.B0 = 0;
 SPI1_Write(D >> 6);
 SPI1_Write(D << 2);
 PORTC.B0 = 1;

 while(1){

 }
}
