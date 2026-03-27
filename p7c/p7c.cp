#line 1 "C:/Users/looko/Desktop/trabajos uni/HAE/practicas2026HAE/p7c/p7c.c"

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

const float LAMBDA = 0.0048875;

int v = 0;
float vi = 0.0;
char txt[16];

void interrupt(){

 if(PIR1.ADIF == 1){

 v = (ADRESH << 8) + ADRESL;


 vi = v * LAMBDA;


 FloatToStr(vi,txt);


 Lcd_Cmd(_Lcd_Clear);
 Lcd_out(1,1, txt);


 T0CON.TMR0ON = 1;
 TMR0H = (3036 >> 8);
 TMR0L = 3036;


 ADCON0.ADON = 0;
 ADCON0.GO = 0;
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

 Lcd_init();


 TRISB.B0 = 0;
 TRISE.B1 = 1;


 ADCON0 = 0x71;
 ADCON1 = 0xC0;


 T0CON = 0x84;

 TMR0H = (3036 >> 8);
 TMR0L = 3036;


 INTCON.TMR0IF = 0;
 INTCON.TMR0IE = 1;


 PIR1.ADIF = 0;
 PIE1.ADIE = 1;
 INTCON.PEIE = 1;


 INTCON.GIE = 1;


 ADCON0.GO = 1;

 while(1){

 }
}
