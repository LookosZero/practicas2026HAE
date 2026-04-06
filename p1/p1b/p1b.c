void main() {

    // En binario como van a ponerse los leds 00000001, 00000011...
    int LED[] = {0x01,0x03,0x07,0x0F,0x1F,0x3F,0x7F,0xFF,0x00};
    
    int i = 0;
    
    // Configurar pines como digitales
    ADCON1 = 0x07;
    
    // Configurar pines C como salidas
    TRISC = 0x00;
    
    
    // Bucle principal
    while(1){
        
        // En cada iteracion los puertos C van a ponerse como los leds
        PORTC = LED[i];
        delay_ms(100);
        i++;
        
        if(i>8){
            i = 0;
        }

    }


}