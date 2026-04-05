void main(){
    int D = 757;

    // Configuracion de entradas
    TRISC.B0 = 0;
    TRISC.B3 = 0;
    TRISC.B5 = 0;

    SPI1_Init();

    PORTC.B0 = 0; // SYNC = 0
    SPI1_Write(D >> 6);
    SPI1_Write(D << 2);
    PORTC.B0 = 1; // SYNC = 1;

    while(1){

    }
}