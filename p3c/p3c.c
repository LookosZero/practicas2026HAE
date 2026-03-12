unsigned int unidad = 0;
unsigned int decena = 0;

void interrupt(){

    // INT0 en RB0 - RESTAR
    if(INTCON.INT0IF == 1){
        if(unidad <= 0){
            unidad = 9;
            if(decena <= 0){
                decena = 9;  // Si está en 00, va a 99
            }else{
                decena--;
            }
        }else{
            unidad--;
        }
        INTCON.INT0IF = 0; // Limpiar flag INT0
    }

    // INT1 en RB1 - SUMAR
    if(INTCON3.INT1IF == 1){
        if(unidad >= 9){
            unidad = 0;
            if(decena >= 9){
                decena = 0;
            }else{
                decena ++;
            }
        }else{
            unidad++;
        }
        INTCON3.INT1IF = 0; // Limpiar flag INT1
    }
}

void main(){

    unsigned int numeros[] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F};

    ADCON1 = 0x07;
    TRISD = 0x00;
    TRISE.B0 = 0;
    TRISE.B1 = 0;

    PORTE.B0 = 1;
    PORTE.B1 = 1;

    PORTD = numeros[0];

    // Configuracion interrupciones INT0 (DOWN)
    TRISB.B0 = 1; //se configura RB0 como entrada
    INTCON2.INTEDG0 = 1; //la interrupción la provoca un flanco de subida (x=1)/ bajada (x=0)
    INTCON.INT0IF = 0; //se pone el flag de la interrupción INT0 a 0
    INTCON.INT0IE = 1; //se habilita la interrupción INT0

    // Configuracion interrupciones INT1 (UP)
    TRISB.B1 = 1; // se configura RB1 como entrada
    INTCON2.INTEDG1 = 1; //la interrupción la provoca un flanco de subida (x=1)/ bajada (x=0)
    INTCON3.INT1IF = 0; // se pone el flag de la interrupción INT1 a 0
    INTCON3.INT1IE = 1; // se habilita la interrupción INT1

    INTCON.GIE = 1; // se habilitan las interrupciones en general


    while(1){
        // Encender decena
        PORTE.B1 = 1; // Apagar unidad
        PORTD = numeros[decena];
        PORTE.B0 = 0; // Encender decena
        delay_ms(15);
        PORTE.B0 = 1; // Apagar decena

        // Encender unidad
        PORTD = numeros[unidad];
        PORTE.B1 = 0; // Encender unidad;
        delay_ms(15);
        PORTE.B1 = 1; // Apagar unidad

    }

}