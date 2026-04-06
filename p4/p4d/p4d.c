#include <stdbool.h>

int x;
bool bucleLuz = false;

// bucleLuz es la variable encargada de encender el bucle infinito que enciende y apaga la luz
void interrupt(){
    if(bucleLuz == true) {
        bucleLuz = false;
    } else {
        bucleLuz = true;
    }

    x = PORTB; // Leer el puerto B antes de borrar el flag
    INTCON.RBIF = 0; // Se borra el flag
}

void main(){
    ADCON1 = 0x07;

    TRISA.B0 = 0;

    TRISB.B5 = 1;
    x = PORTB;
    INTCON.RBIF = 0; // Se pone el flag a 0
    INTCON.RBIE = 1; // Se habilita la interrupción por cambio de nivel
    INTCON.GIE = 1; // Se habilitan las interrupciones en general

    while(1){
        while(bucleLuz) {
            PORTA.B0 = 0;
            delay_ms(500);
            PORTA.B0 = 1;
            delay_ms(500);
        }
        PORTA.B0 = 0;
    }
}