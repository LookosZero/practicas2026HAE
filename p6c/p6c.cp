#line 1 "C:/Users/looko/Desktop/trabajos uni/HAE/practicas2026HAE/p6c/p6c.c"

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

int v = 0;
char txt[16];
int temp = 0;
float res = 0.0048875;

float tempC = 0.0;
float aux = 0.0;
int unidad = 0;

int floatToInt(float num) {
 if (num >= 0.0)
 return (int)(num + 0.5);
 else
 return (int)(num - 0.5);
}

void mostrarTemp() {
 Lcd_Cmd(_Lcd_Clear);
 IntToStr(temp, txt);
 if (unidad == 0) {
 Lcd_out(1, 1, txt);
 Lcd_out(1, 7, "C");
 } else if (unidad == 1) {
 Lcd_out(1, 1, txt);
 Lcd_out(1, 7, "F");
 } else {
 Lcd_out(1, 1, txt);
 Lcd_out(1, 7, "K");
 }
}

void interrupt() {

 if (PIR1.ADIF == 1) {

 v = ADRESL;
 v = v + (ADRESH << 8);
 tempC = 100.0 * (v * res) - 50.0;


 if (unidad == 0) {
 aux = tempC;
 } else if (unidad == 1) {
 aux = 1.8 * tempC + 32.0;
 } else {
 aux = tempC + 273.15;
 }

 temp = floatToInt(aux);
 mostrarTemp();


 ADCON0.ADON = 0;
 ADCON0.GO = 0;
 PIR1.ADIF = 0;


 T0CON.TMR0ON = 1;
 TMR0H = (28036 >> 8);
 TMR0L = 28036 & 0xFF;
 }

 if (INTCON.TMR0IF == 1) {

 T0CON.TMR0ON = 0;
 INTCON.TMR0IF = 0;
 ADCON0.ADON = 1;
 ADCON0.GO = 1;
 }

 if (INTCON.INT0IF == 1) {

 unidad = (unidad + 1) % 3;

 if (unidad == 0) {
 aux = tempC;
 } else if (unidad == 1) {
 aux = 1.8 * tempC + 32.0;
 } else {
 aux = tempC + 273.15;
 }

 temp = floatToInt(aux);
 mostrarTemp();

 INTCON.INT0IF = 0;
 }
}

void main() {
 Lcd_init();


 ADCON0 = 0x59;
 ADCON1 = 0xC0;


 TRISA.B3 = 1;
 TRISB.B0 = 1;


 T0CON = 0x85;
 INTCON.TMR0IF = 0;
 INTCON.TMR0IE = 1;


 INTCON2.INTEDG0 = 1;
 INTCON.INT0IF = 0;
 INTCON.INT0IE = 1;


 PIR1.ADIF = 0;
 PIE1.ADIE = 1;
 INTCON.PEIE = 1;


 INTCON.GIE = 1;


 ADCON0.GO = 1;

 while (1) {
 }
}
