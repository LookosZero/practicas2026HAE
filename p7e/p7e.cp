#line 1 "C:/Users/looko/Desktop/trabajos uni/HAE/practicas2026HAE/p7e/p7e.c"

sbit LCD_RS at RC2_bit;
sbit LCD_EN at PORTC.B3;
sbit LCD_D4 at RC4_bit;
sbit LCD_D5 at RC5_bit;
sbit LCD_D6 at RC6_bit;
sbit LCD_D7 at RC7_bit;


sbit LCD_RS_Direction at TRISC2_bit;
sbit LCD_EN_Direction at TRISC.B3;
sbit LCD_D4_Direction at TRISC4_bit;
sbit LCD_D5_Direction at TRISC5_bit;
sbit LCD_D6_Direction at TRISC6_bit;
sbit LCD_D7_Direction at TRISC7_bit;


const int ALFA = 3036;
const float LAMBDA = 0.0048875;


int v0 = 0;
float vi = 0.0;


float pa = 0.0;
float pressure = 0.0;
int unitOption = 0;


char txt[16];

void mostrarLCD(float value){
 Lcd_Cmd(_Lcd_Clear);
 FloatToStr(value, txt);
 Lcd_Out(1, 3, txt);
}

float vToPa(float v){
 return 54.2 * v - 14.11;
}

float changeUnit(float pas, int opt){
 float converted;

 switch(opt){
 case 0:
 converted = pas;
 break;
 case 1:
 converted = pas / 6894.757;
 break;
 case 2:
 converted = pas / 101325.0;
 break;
 case 3:
 converted = pas / 100.0;
 break;
 case 4:
 converted = pas / 133.322;
 break;
 case 5:
 converted = pas / 10000.0;
 break;
 case 6:
 converted = pas / 98066.5;
 break;
 case 7:
 converted = pas / 98066.5;
 break;
 default:
 converted = pas;
 break;
 }

 return converted;
}

void interrupt(){


 if(PIR1.ADIF == 1){


 v0 = (ADRESH << 8) + ADRESL;
 vi = v0 * LAMBDA;

 pa = vToPa(vi);
 pressure = changeUnit(pa, unitOption);
 mostrarLCD(pressure);


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


 if(INTCON3.INT1IF == 1){

 unitOption++;
 if(unitOption > 7){
 unitOption = 0;
 }

 pressure = changeUnit(pa, unitOption);
 mostrarLCD(pressure);


 INTCON3.INT1IF = 0;
 }
}

void main(){
 Lcd_init();


 TRISB.B0 = 0;
 TRISB.B1 = 1;
 TRISE.B2 = 1;


 ADCON0 = 0x79;
 ADCON1 = 0xC0;


 INTCON.PEIE = 1;


 PIR1.ADIF = 0;
 PIE1.ADIE = 1;


 T0CON = 0x83;
 TMR0H = (ALFA >> 8);
 TMR0L = ALFA;


 INTCON.TMR0IF = 0;
 INTCON.TMR0IE = 1;


 INTCON2.INTEDG1 = 1;
 INTCON3.INT1IF = 0;
 INTCON3.INT1IE = 1;


 INTCON.GIE = 1;


 ADCON0.GO = 1;

 while(1){

 }
}
