// LCD pinout settings
sbit LCD_RS at RC2_bit;
sbit LCD_EN at PORTC.B3;
sbit LCD_D4 at RC4_bit;
sbit LCD_D5 at RC5_bit;
sbit LCD_D6 at RC6_bit;
sbit LCD_D7 at RC7_bit;

// LCD directions
sbit LCD_RS_Direction at TRISC2_bit;
sbit LCD_EN_Direction at TRISC.B3;
sbit LCD_D4_Direction at TRISC4_bit;
sbit LCD_D5_Direction at TRISC5_bit;
sbit LCD_D6_Direction at TRISC6_bit;
sbit LCD_D7_Direction at TRISC7_bit;

const float LAMBDA = 0.0048875; // Multiplica a vi

int v = 0; // Medicion de voltaje
float vi = 0.0; // Medicion final en float
char txt[16];

void interrupt(){

    if(PIR1.ADIF == 1){
        // Realizar la medicion
        v = (ADRESH << 8) + ADRESL;

        // Multiplicar por la resolucion para obtener el valor del voltaje
        vi = v * LAMBDA;

        // Convertir a string para mostrarlo en el LCD
        FloatToStr(vi,txt);

        // Mostrar el valor en el LCD
        Lcd_Cmd(_Lcd_Clear);
        Lcd_out(1,1, txt);

        // Habilitar el timer de 1 segundo
        T0CON.TMR0ON = 1;
        TMR0H = (3036 >> 8);
        TMR0L = 3036;

        // Deshabilitar el AD
        ADCON0.ADON = 0;
        ADCON0.GO = 0;
        PIR1.ADIF = 0;
    }

    if(INTCON.TMR0IF == 1){

        // Realizamos la medicion del AD tras 1 segundo
        ADCON0.ADON = 1;
        ADCON0.GO = 1;

        // Deshabilitar timer
        T0CON.TMR0ON = 0;
        INTCON.TMR0IF = 0;
    }

}

void main(){

    Lcd_init();

    // Configurar puertos entrada/salida
    TRISB.B0 = 0;
    TRISE.B1 = 1;

    // Configurar convertidor AD
    ADCON0 = 0x71;
    ADCON1 = 0xC0;

    // Configurar timer
    T0CON = 0x84;

    TMR0H = (3036 >> 8);
    TMR0L = 3036;

    // Habilitar interrupciones del timer
    INTCON.TMR0IF = 0;
    INTCON.TMR0IE = 1;

    // Habilitar interrupciones del AD
    PIR1.ADIF = 0;
    PIE1.ADIE = 1;
    INTCON.PEIE = 1;

    // Habilitar interrupciones globales
    INTCON.GIE = 1;

    // Primera medicion
    ADCON0.GO = 1;

    while(1){

    }
}