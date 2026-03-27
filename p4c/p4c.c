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

// La funcion de candado es cancelar el flanco de subida cuando dejamos de presionar el boton, que en la interrupción RB5 cuenta tambien
bool candado = false;
bool escribir = false;

void interrupt(){

// El interrupt solo se encarga de que el boton funcione con flancos de subida y de mandar ejecutar la orden de escribir
    if(candado == false) {
        escribir = true;
        candado = true;
    } else {
        candado = false;
    }

    x = PORTB; // Hay que leer el puerto B antes de borrar el flag
    INTCON.RBIF = 0; // se borra el flag
}

void main(){
    unsigned short numero = 0;
    char txt[4];

    ADCON1 = 0x07;
    Lcd_Init();

    TRISB.B5 = 1; // x = 4, 5, 6, 7
    x = PORTB;
    INTCON.RBIF = 0; // Se pone el flag a 0
    INTCON.RBIE = 1; // Se habilita la interrupción por cambio de nivel
    INTCON.GIE = 1; // Se habilitan las interrupciones en general

    Lcd_Out(1, 1, "Turno:   0");

    // Pasamos la logica de tratar el numero a mostrar en el LCD del interrupt al main
    while(1){
        if(escribir == true){
            numero++;
            if(numero >= 20){
                numero = 0;
            }

            ByteToStr(numero, txt);
            Lcd_Out(1, 8, txt);
            escribir = false;
        }
    }
}