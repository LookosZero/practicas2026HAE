void main() {
    
    int LEDS[] = {0xFE, 0xFD, 0xFB, 0xF7, 0xEF, 0xDF, 0xBF, 0x7F};
    int i = 0;
    
    ADCON1 = 0x07;
    
    TRISC = 0x00;
    
    TRISB.B3 = 1;
    
    
    while(1){
        if(PORTB.B3 == 0){
            PORTC = LEDS[i];
            delay_ms(100);
            i++;
        }else{
            PORTC = 0xFF;
        }
        
        if(i >= 8){
            i = 0;
        }

    }
}