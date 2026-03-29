// LCD pinout
sbit LCD_RS at RC2_bit;
sbit LCD_EN at PORTC.B3;
sbit LCD_D4 at RC4_bit;
sbit LCD_D5 at RC5_bit;
sbit LCD_D6 at RC6_bit;
sbit LCD_D7 at RC7_bit;

//LCD directions
sbit LCD_RS_Direction at TRISC2_bit;
sbit LCD_EN_Direction at TRISC.B3;
sbit LCD_D4_Direction at TRISC4_bit;
sbit LCD_D5_Direction at TRISC5_bit;
sbit LCD_D6_Direction at TRISC6_bit;
sbit LCD_D7_Direction at TRISC7_bit;

void interrupt(){

}

void main(){
    Lcd_init();

    while(1){

    }
}