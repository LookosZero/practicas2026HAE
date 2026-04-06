#include <stdbool.h>

bool lock = false;

void interrupt(){

    // Para que solo se ejecute un timer a la vez
    if(lock == false){

        // Cuando haya una interrupcion y el boton se pulse se encendera el led
        if(INTCON.INT0IF == 1 && INTCON.INT0IE == 1 && PORTB.B0 == 1){
            PORTC.B0 = 1;

            // Se activa el timer de 3 segundos
            T0CON.TMR0ON = 1;
            TMR0H = (18661 >> 8);
            TMR0L = 18661;

            // Se bloquea y se desactivan las interrupciones de B0
            lock = true;
            INTCON.INT0IF = 0;
            INTCON.INT0IE = 0;

        }

        // Cuando haya una interrupcion y el boton se pulse se encendera el led
        if(INTCON3.INT1IF == 1 && INTCON3.INT1IE == 1 && PORTB.B1 == 1){
            PORTC.B7 = 1;

            // Se activa el timer de 4 segundos
            T0CON.TMR0ON = 1;
            TMR0H = (3036 >> 8);
            TMR0L = 3036;

            // Se bloquea y se desactivan las interrupciones de B1
            lock = true;
            INTCON3.INT1IF = 0;
            INTCON3.INT1IE = 0;

        }
    }

    // Cuando el timer desborda significa que paso el tiempo deseado
    if (INTCON.TMR0IF == 1) {
        // Se desbloquea y se apagan los leds
        lock = false;
        PORTC.B0 = 0;
        PORTC.B7 = 0;

        // Se vuelven a activar las interrupciones B0 y B1
        INTCON.INT0IE = 1;
        INTCON3.INT1IE = 1;

        // Se desactiva el timer
        T0CON.TMR0ON = 0;
        INTCON.TMR0IF = 0;
    }
}

void main(){
    ADCON1 = 0x07;

    TRISB.B0 = 1;
    TRISB.B1 = 1;

    TRISC.B0 = 0;
    TRISC.B7 = 0;

    // Habilitar interrupcion B0
    INTCON2.INTEDG0 = 1;
    INTCON.INT0IF = 0;
    INTCON.INT0IE = 1;

    // Habilitar interrupcion B1
    INTCON2.INTEDG1 = 1;
    INTCON3.INT1IF = 0;
    INTCON3.INT1IE = 1;

    // Habilitar interrupcion Timer0
    T0CON = 0x06;
    INTCON.TMR0IF = 0;
    INTCON.TMR0IE = 1;

    // Habilitar interrupciones en general
    INTCON.GIE = 1;

    PORTC.B0 = 0;
    PORTC.B7 = 0;

    while(1){

    }
}