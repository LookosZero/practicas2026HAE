// DAC de 10 bits: 0..1023 para 0..5V
// 2.5V corresponde aproximadamente a 512 justo la mitad
const unsigned int DAC_0V = 0;
const unsigned int DAC_2V5 = 512;
const unsigned int DAC_5V = 1023;

// En ISIS, un envio+conversion tarda aproximadamente 56.1us
// 70ms / 56.1us  = 1248 muestras (aprox.)
// 28.75ms / 56.1us = 512 muestras (aprox.)
const unsigned int HOLD_2V5_SAMPLES = 1248;
const unsigned int RAMP_SAMPLES = 512;

void sendDAC(int D){
    PORTC.B0 = 0; // SYNC = 0
    SPI1_Write(D >> 6);
    SPI1_Write(D << 2);
    PORTC.B0 = 1; // SYNC = 1
}

void main(){

    unsigned int D = 0;
    unsigned int i = 0;

    // Configuracion de puertos
    TRISC.B0 = 0;
    TRISC.B3 = 0;
    TRISC.B5 = 0;

    SPI1_Init();

    while(1){

        // Mostramos el voltaje de 2.5V en la salida durante 70ms
        for(i = 0; i < HOLD_2V5_SAMPLES; i++){
            sendDAC(DAC_2V5);
        }

        // Rampa de 2.5V a 5V en 512 muestras (28.75ms aprox.)
        for(i = 0; i < RAMP_SAMPLES; i++){
            D = DAC_2V5 + i;
            sendDAC(D);
        }

        // Caida instantanea a 0V.
        sendDAC(DAC_0V);

        // Rampa de 0V a 2.5V en 512 muestras (28.75ms aprox)
        for(i = 0; i < RAMP_SAMPLES; i++){
            D = DAC_0V + i;
            sendDAC(D);
        }
    }
}