const float LAMBDA = 0.0048875;

int floatToInt(float value){
    if (value >= 0.0f) {
        return (int)(value + 0.5f);
    } else {
        return (int)(value - 0.5f);
    }
}

int digitalVoltage(float v, float lambda){
    float D;
    D = v/lambda;

    return floatToInt(D);
}

void main(){

    float voltage = 0.0;
    int D = 0;
    int i = 0;

    // Configuracion de puertos
    TRISC.B0 = 0;
    TRISC.B3 = 0;
    TRISC.B5 = 0;

    SPI1_Init();

    while(1){

        // Ciclo comienza con voltaje = 2.5
        voltage = 2.5;
        D = digitalVoltage(voltage, LAMBDA);

        // Mostramos el voltaje en la salida durante 70ms
        PORTC.B0 = 0; // SYNC = 0
        SPI1_Write(D >> 6);
        SPI1_Write(D << 2);
        PORTC.B0 = 1; // SYNC = 1
        delay_ms(70);

        /*
        Subimos el voltaje de forma continua a 5V durante 28.75ms.
        Si cada iteracion son 56.1microSegundos 28750/56.1 = 512 pasos (aprox.)
        Hay que subir 5 - 2.5 = 2.5 voltios por lo que el incremento sera de 2.5/512 = 0.00488 en cada paso (aprox.)
        */
        i = 0;
        for(i = 0; i <= 512; i++){
            voltage = 2.5 + (2.5 * i) / 512.0;
            D = digitalVoltage(voltage, LAMBDA);

            PORTC.B0 = 0;
            SPI1_Write(D >> 6);
            SPI1_Write(D << 2);
            PORTC.B0 = 1;

            delay_us(56);  // espera aprox. 56 microsegundos para que la subida dure 28.75 ms
        }

        // Voltaje cae a 0 y mostramos
        voltage = 0.0;
        D = digitalVoltage(voltage, LAMBDA);

        PORTC.B0 = 0; // SYNC = 0
        SPI1_Write(D >> 6);
        SPI1_Write(D << 2);
        PORTC.B0 = 1; // SYNC = 1

        // Incrementamos el voltaje de forma continua hasta 2.5V durante 28.75ms
        i = 0;
        for(i = 0; i <= 512; i++){
            voltage = (2.5 * i) / 512.0;
            D = digitalVoltage(voltage, LAMBDA);

            PORTC.B0 = 0;
            SPI1_Write(D >> 6);
            SPI1_Write(D << 2);
            PORTC.B0 = 1;

            delay_us(56);  // espera aprox. 56 microsegundos para que la subida dure 28.75 ms
        }
    }
}
