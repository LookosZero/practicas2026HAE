const int ALFA = 6;
const float LAMBDA = 0.0048875;

int aux = 0;

int floatToInt(float value){
    if(value >= 0.0f){
        return (int)(value + 0.05f);
    }else{
        return (int)(value - 0.05f);
    }
}

void writeDAC(int D){
    if(D > 1023){
        D = 1023;
    }
    SPI1_Init();
    PORTC.B0 = 0;
    SPI1_Write(D >> 6);
    SPI1_Write(D << 2);
    PORTC.B0 = 1;
}

void interrupt(){

    if(PIR1.ADIF == 1){

        // Lectura de medicion
        aux = (ADRESH << 8) + ADRESL;

        // Escribir medicion en el DAC
        writeDAC(aux * 4);

        // Habilitar el timer
        T0CON.TMR0ON = 1;
        TMR0H = (ALFA >> 8);
        TMR0L = ALFA;

        // Deshabilitar el AD
        ADCON0.ADON = 0;
        PIR1.ADIF = 0;
    }

    if(INTCON.TMR0IF == 1){

        // Habilitar AD y realizar medicion cada 1ms
        ADCON0.ADON = 1;
        ADCON0.GO = 1;

        // Deshabilitar el timer
        T0CON.TMR0ON = 0;
        INTCON.TMR0IF = 0;
    }

}

void main(){

    // Configurar puertos entrada/salida
    TRISA.B2 = 1;
    TRISC.B0 = 0;
    TRISC.B3 = 0;
    TRISC.B5 = 0;

    // Configurar timer
    T0CON = 0x42;

    // Cargar timer con la temporizacion de 1 milisegundo
    TMR0H = (ALFA >> 8);
    TMR0L = ALFA;

    // Configurar AD
    ADCON0 = 0x51;
    ADCON1 = 0xC0;

    // Habilitar interrupciones AD
    INTCON.PEIE = 1;
    PIR1.ADIF = 0;
    PIE1.ADIE = 1;

    // Habilitar interrupciones timer
    INTCON.TMR0IF = 0;
    INTCON.TMR0IE = 1;

    // Habilitar interrupciones globales
    INTCON.GIE = 1;

    // Realizar primera medicion
    ADCON0.GO = 1;

    while(1){

    }
}