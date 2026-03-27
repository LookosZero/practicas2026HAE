#include "Tecla12INT.h"

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

// Variables globales
int x;
int fila = 1;
int columna = 1;

void interrupt(){ // Se ha pulsado una tecla

    // Variable que contiene la tecla pulsada
    char key;
    key = tecla(); // En la variable key se guarda un número correspondiente al valor ASCII de la tecla pulsada

    // Logica del LCD
    Lcd_Chr(fila, columna, key);
    if(columna >= 16){
        if(fila == 1){
            fila = 2;
        }else{
            fila = 1;
            // Lcd_cmd(_LCD_CLEAR); Para borrar el LCD cuando se llena
        }
        columna = 0;
    }
    columna++;

    x = PORTB; // Para poder borrar el bit RBIF (define x global)
    INTCON.RBIF=0; // Se borra el bit RBIF después de llamar a la funcion tecla()
}


void main(){
    Lcd_init();

    ADCON1 = 0x07;

    // Habilitamos las interrupciones RB4-7
    TRISB = 0xF0; // El nibble alto son entradas y el nibble bajo son salidas
    PORTB = 0;

    INTCON2.RBPU = 0; // Se habilitan las resistencias de pullup del puerto B
    x = PORTB; // Para poder borrar el RBIF
    INTCON.RBIF = 0;
    INTCON.RBIE = 1;

    INTCON.GIE = 1; // Se habilitan las interrupciones en general

    while(1){

    }

}