#line 1 "C:/Users/Lookos/Desktop/Trabajos Uni/practicas2026HAE/p8/p8d/p8d.c"


const unsigned int DAC_0V = 0;
const unsigned int DAC_2V5 = 512;
const unsigned int DAC_5V = 1023;




const unsigned int HOLD_2V5_SAMPLES = 1248;
const unsigned int RAMP_SAMPLES = 512;

void sendDAC(int D){
 PORTC.B0 = 0;
 SPI1_Write(D >> 6);
 SPI1_Write(D << 2);
 PORTC.B0 = 1;
}

void main(){

 unsigned int D = 0;
 unsigned int i = 0;


 TRISC.B0 = 0;
 TRISC.B3 = 0;
 TRISC.B5 = 0;

 SPI1_Init();

 while(1){


 for(i = 0; i < HOLD_2V5_SAMPLES; i++){
 sendDAC(DAC_2V5);
 }


 for(i = 0; i < RAMP_SAMPLES; i++){
 D = DAC_2V5 + i;
 sendDAC(D);
 }


 sendDAC(DAC_0V);


 for(i = 0; i < RAMP_SAMPLES; i++){
 D = DAC_0V + i;
 sendDAC(D);
 }
 }
}
