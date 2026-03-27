void main(){
    unsigned char numeros[] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F};
    unsigned char unidades = 0;
    unsigned char decenas = 0;
    unsigned int contador = 0;

    ADCON1 = 0x07;
    TRISA.B0 = 0;
    TRISA.B1 = 0;
    TRISD = 0x00;
    
    // Ambos displays apagados inicialmente
    PORTA.B0 = 0;
    PORTA.B0 = 0;

    PORTD = 0x00;

    while(1){
        // Multiplexado: mostrar cada dígito alternadamente
        // 25 ciclos completos = 1 segundo (25 * 40ms = 1000ms)

        // Mostrar unidades (display derecho)
        PORTA.B1 = 1;  // Apaga decenas primero
        PORTD = numeros[unidades];
        PORTA.B0 = 0;  // Enciende unidades
        delay_ms(20);

        // Mostrar decenas (display izquierdo)
        PORTA.B0 = 1;  // Apaga unidades primero
        PORTD = numeros[decenas];
        PORTA.B1 = 0;  // Enciende decenas
        delay_ms(20);

        // Incrementar contador
        contador++;

        // Cada 25 ciclos = 1 segundo
        if(contador >= 25){
            contador = 0;
            unidades++;

            // Si unidades llega a 10, resetear y aumentar decenas
            if(unidades >= 10){
                unidades = 0;
                decenas++;

                // Si decenas llega a 6 (60 segundos), resetear todo
                if(decenas >= 6){
                    decenas = 0;
                }
            }
        }
    }
}