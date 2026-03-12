#include <stdbool.h>

// LCD pinout settings
sbit LCD_RS at RD2_bit;
sbit LCD_EN at PORTD.B3;
sbit LCD_D7 at RD7_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D4 at RD4_bit;

// Pin direction
sbit LCD_RS_Direction at TRISD2_bit;
sbit LCD_EN_Direction at TRISD.B3;
sbit LCD_D7_Direction at TRISD7_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D4_Direction at TRISD4_bit;

int x;
//La funcion de candado es cancelar el flanco de subida cuando dejamos de presionar el botón, que en esta interrupción RB5 cuenta también:
//CUIDADO, es un bool que de base no funciona en mikroC, hay que poner el include de arriba:
bool candado = false;

void interrupt(){

    if(candado == false) {
        unsigned short numero;
        char txt[4];

        numero++;
        if(numero >= 20){
            numero = 0;
        }

        ByteToStr(numero, txt);

        Lcd_out(1, 1, txt);
        candado = true;
    } else {
        candado = false;
    }

    x = PORTB; // hay que leer el puerto B antes de borrar el flag
    INTCON.RBIF = 0; // se borra el flag
}

void main(){
    ADCON1 = 0x07;
    Lcd_Init();

    TRISB.B5 = 1; // x = 4, 5, 6, 7
    x = PORTB;
    INTCON.RBIF = 0; // se pone el flag a 0
    INTCON.RBIE = 1; // se habilita la interrupción por cambio de nivel
    INTCON.GIE = 1; // se habilitan las interrupciones en general

    while(1){

    }
}