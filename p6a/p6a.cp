#line 1 "C:/Users/looko/Desktop/trabajos uni/HAE/practicas2026HAE/p6a/p6a.c"

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

int vi;
char txt[16];
float res = 0.0048828;
float aux = 0.0;

void interrupt(){

 vi = ADRESL;
 vi = vi + (ADRESH << 8);
 aux = vi * res;

 Lcd_Cmd(_LCD_CLEAR);

 FloatToStr(aux,txt);

 Lcd_Out(1,3,txt);

 PIR1.ADIF = 0;
}

void main(){
 Lcd_Init();
 ADCON0 = 0x59;
 ADCON1 = 0xC0;

 TRISA.B3 = 1;
 PIR1.ADIF = 0;
 PIE1.ADIE = 1;
 INTCON.PEIE = 1;
 INTCON.GIE = 1;

 while(1){

 ADCON0.GO = 1;
 delay_ms(1000);


 }

}
