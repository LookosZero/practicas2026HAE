//VAriable cualquierea llamada Q:
int Q = 0;
int m = 0;

void interrupt() {

    if (Q == 0 && PORTB.B0 == 0) {
        Q = 0;
    }
    if (Q == 0 && PORTB.B0 == 1) {
        Q = 1;
    }
    if (Q == 1 && PORTB.B0 == 1) {
        Q = 1;
    }
    if (Q == 1 && PORTB.B0 == 0) {
        Q = 2;
        m = ~m;
    }
    if (Q == 2){
        Q = 0;
    }

    PORTB.B3 = m;
    TMR0H = (30536 >> 8);
    TMR0L = 30536;
    INTCON.TMR0IF = 0; // se borra el flag

}

void main() {

    ADCON1 = 0x07;

    // 1 entrada, 0 salida
    TRISA.B0 = 1;
    TRISA.B3 = 0;
    PORTA.B3 = 0;

    //En T0CON, guardamos un numero en hexa que describe las caracteristicas del timer (8 o 16 bits, prescaler...)
    T0CON = 0xB4;
    INTCON.TMR0IF = 0; // se pone el flag a 0
    INTCON.TMR0IE = 1; // se habilita la interrupción del Timer 0
    INTCON.GIE = 1; // se habilitan las interrupciones en general


    TMR0H = (30536 >> 8);
    TMR0L = 30536; //se carga el valor inicial (alfa) del ‘contador’
    //Hacemos esto para correr 8 posiciones, y asi obtener las 8 ultimas que nos interesan (al haber 16)
    // hay que poner a contar el Timer0

    while(1) {

    }
}