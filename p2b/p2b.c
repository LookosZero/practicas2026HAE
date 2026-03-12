void main(){
    unsigned int numeros[] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F};
    unsigned int led[] = {0x07, 0x0B, 0x0D, 0x0E};
    unsigned int valor = 0;
    unsigned int digito[4];
    unsigned int i;
    unsigned int temp;

    ADCON1 = 0x07;
    TRISB = 0xFF;
    TRISC = 0x00;
    TRISD = 0x00;

    PORTD = 0x0F;
    PORTC = 0x00;

    while(1){
        valor = PORTB;
        temp = valor;

        for(i = 0; i < 4; i++){
            digito[i] = temp % 10;
            temp = temp / 10;
        }

        for(i = 0; i < 4; i++){
            PORTD = 0x0F;

            PORTC = numeros[digito[i]];
            
            PORTD = led[i];

            delay_ms(15);
            
        }
    }
}