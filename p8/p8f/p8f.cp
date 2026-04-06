#line 1 "C:/Users/Lookos/Desktop/Trabajos Uni/practicas2026HAE/p8/p8f/p8f.c"
const int ALFA = 6;

int aux = 0;

void sendDAC(int D){
 if(D > 1023){
 D = 1023;
 }
 SPI1_Init();
 PORTC.B0 = 0;
 SPI1_Write(D >> 6);
 SPI1_Write(D << 2);
 PORTC.B0 = 1;
}

void interrupt(){

 if(PIR1.ADIF == 1){


 aux = (ADRESH << 8) + ADRESL;


 sendDAC(aux * 4);


 T0CON.TMR0ON = 1;
 TMR0H = (ALFA >> 8);
 TMR0L = ALFA;


 ADCON0.ADON = 0;
 PIR1.ADIF = 0;
 }

 if(INTCON.TMR0IF == 1){


 ADCON0.ADON = 1;
 ADCON0.GO = 1;


 T0CON.TMR0ON = 0;
 INTCON.TMR0IF = 0;
 }

}

void main(){


 TRISA.B2 = 1;
 TRISC.B0 = 0;
 TRISC.B3 = 0;
 TRISC.B5 = 0;


 T0CON = 0x42;


 TMR0H = (ALFA >> 8);
 TMR0L = ALFA;


 ADCON0 = 0x51;
 ADCON1 = 0xC0;


 INTCON.PEIE = 1;
 PIR1.ADIF = 0;
 PIE1.ADIE = 1;


 INTCON.TMR0IF = 0;
 INTCON.TMR0IE = 1;


 INTCON.GIE = 1;


 ADCON0.GO = 1;

 while(1){

 }
}
