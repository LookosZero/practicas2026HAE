#line 1 "C:/Users/looko/Desktop/trabajos uni/HAE/practicas2026HAE/p6b/p6b.c"

sbit LCD_RS at RD2_bit;
sbit LCD_EN at PORTD.B3;
sbit LCD_D7 at RD7_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D4 at RD4_bit;


sbit LCD_RS_Direction at TRISD2_bit;
sbit LCD_EN_Direction at TRISD.B3;
sbit LCD_D7_Direction at TRISD7_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D4_Direction at TRISD4_bit;

const float LAMBDA = 0.0048875;

int v = 0;
char txt[16];
float aux = 0.0;
int temp = 0;

void FloatToInt(float aux, int *temp) {
 if (aux >= 0)
 *temp = (int)(aux + 0.5);
 else
 *temp = (int)(aux - 0.5);
}

void interrupt(){

 if(PIR1.ADIF == 1){

 v = ADRESL;
 v = v + (ADRESH << 8);


 aux = 100*(v*LAMBDA) - 50;

 FloatToInt(aux, &temp);


 Lcd_Cmd(_Lcd_Clear);
 IntToStr(temp, txt);
 Lcd_out(1,1, txt);


 ADCON0.ADON = 0;
 ADCON0.GO = 0;
 PIR1.ADIF = 0;


 T0CON.TMR0ON = 1;
 TMR0H = (28036 >> 8);
 TMR0L = 28036;
 }

 if(INTCON.TMR0IF == 1){


 ADCON0.ADON = 1;
 ADCON0.GO = 1;
 T0CON.TMR0ON = 0;
 INTCON.TMR0IF = 0;
 }

}

void main(){
 Lcd_init();


 ADCON0 = 0x59;
 ADCON1 = 0xC0;


 TRISA.B3 = 1;


 T0CON = 0x85;
 INTCON.TMR0IF = 0;
 INTCON.TMR0IE = 1;



 PIR1.ADIF = 0;
 PIE1.ADIE = 1;
 INTCON.PEIE = 1;


 INTCON.GIE = 1;


 ADCON0.GO = 1;

 while(1) {

 }
}
