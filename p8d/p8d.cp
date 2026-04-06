#line 1 "C:/Users/Lookos/Desktop/Trabajos Uni/practicas2026HAE/p8d/p8d.c"
const float LAMBDA = 0.0048875;

int floatToInt(float value){
 if (value >= 0.0f) {
 return (int)(value + 0.5f);
 } else {
 return (int)(value - 0.5f);
 }
}

int digitalVoltage(float v, float lambda){
 float D;
 D = v/lambda;

 return floatToInt(D);
}

void main(){

 float voltage = 0.0;
 int D = 0;
 int i = 0;


 TRISC.B0 = 0;
 TRISC.B3 = 0;
 TRISC.B5 = 0;

 SPI1_Init();

 while(1){


 voltage = 2.5;
 D = digitalVoltage(voltage, LAMBDA);


 PORTC.B0 = 0;
 SPI1_Write(D >> 6);
 SPI1_Write(D << 2);
 PORTC.B0 = 1;
 delay_ms(70);
#line 49 "C:/Users/Lookos/Desktop/Trabajos Uni/practicas2026HAE/p8d/p8d.c"
 i = 0;
 for(i = 0; i <= 512; i++){
 voltage = 2.5 + (2.5 * i) / 512.0;
 D = digitalVoltage(voltage, LAMBDA);

 PORTC.B0 = 0;
 SPI1_Write(D >> 6);
 SPI1_Write(D << 2);
 PORTC.B0 = 1;

 delay_us(56);
 }


 voltage = 0.0;
 D = digitalVoltage(voltage, LAMBDA);

 PORTC.B0 = 0;
 SPI1_Write(D >> 6);
 SPI1_Write(D << 2);
 PORTC.B0 = 1;


 i = 0;
 for(i = 0; i <= 512; i++){
 voltage = (2.5 * i) / 512.0;
 D = digitalVoltage(voltage, LAMBDA);

 PORTC.B0 = 0;
 SPI1_Write(D >> 6);
 SPI1_Write(D << 2);
 PORTC.B0 = 1;

 delay_us(56);
 }
 }
}
