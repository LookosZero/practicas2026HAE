#line 1 "C:/Users/looko/Desktop/trabajos uni/HAE/practicas/p4b/p4b.c"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/stdbool.h"



 typedef char _Bool;
#line 4 "C:/Users/looko/Desktop/trabajos uni/HAE/practicas/p4b/p4b.c"
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

int x;


 _Bool  candado =  0 ;

void interrupt(){

 if(candado ==  0 ) {
 unsigned short numero;
 char txt[4];

 numero++;
 if(numero >= 20){
 numero = 0;
 }

 ByteToStr(numero, txt);

 Lcd_out(1, 1, txt);
 candado =  1 ;
 } else {
 candado =  0 ;
 }

 x = PORTB;
 INTCON.RBIF = 0;
}

void main(){
 ADCON1 = 0x07;
 Lcd_Init();

 TRISB.B5 = 1;
 x = PORTB;
 INTCON.RBIF = 0;
 INTCON.RBIE = 1;
 INTCON.GIE = 1;

 while(1){

 }
}
