void interrupt(){
    if(INTCON.TMR0IF == 1){
        PORTB.B0 = ~PORTB.B0;
    }

    TMR0H = (3036 >> 8);
    TMR0L = 3036;
    INTCON.TMR0IF = 0;
}

void main(){

    // Configurar puerto B0 como salida
    TRISB.B0 = 0;
    PORTB.B0 = 0;

    // Configuracion del timer
    T0CON = 0x84;
    TMR0H = (3036 >> 8);
    TMR0L = 3036;

    // Borrar flag y habilitar el timer
    INTCON.TMR0IF = 0;
    INTCON.TMR0IE = 1;

    // Habilitar interrupciones globales
    INTCON.GIE = 1;

    while(1){

    }
}