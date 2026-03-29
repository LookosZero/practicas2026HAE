// LCD pinout
sbit LCD_RS at RC2_bit;
sbit LCD_EN at PORTC.B3;
sbit LCD_D4 at RC4_bit;
sbit LCD_D5 at RC5_bit;
sbit LCD_D6 at RC6_bit;
sbit LCD_D7 at RC7_bit;

//LCD directions
sbit LCD_RS_Direction at TRISC2_bit;
sbit LCD_EN_Direction at TRISC.B3;
sbit LCD_D4_Direction at TRISC4_bit;
sbit LCD_D5_Direction at TRISC5_bit;
sbit LCD_D6_Direction at TRISC6_bit;
sbit LCD_D7_Direction at TRISC7_bit;

const int ALFA = 3036;
const float LAMBDA = 0.0048875;

int v0 = 0;
float vi = 0.0;

float pa = 0.0;

char txt[16];

void mostrarLCD(float value){
    Lcd_Cmd(_Lcd_Clear);
    FloatToStr(value, txt);
    Lcd_Out(1, 3, txt);
}

float vToPa(float v){
    return 54.2 * v - 14.11;
}

void interrupt(){

    if(PIR1.ADIF == 1){

        // Leer medicion
        v0 = (ADRESH << 8) + ADRESL;
        vi = v0 * LAMBDA;

        pa = vToPa(vi);

        mostrarLCD(pa);

        // Activar el timer
        T0CON.TMR0ON = 1;
        TMR0H = (ALFA >> 8);
        TMR0L = ALFA;

        // Desactivar AD
        ADCON0.ADON = 0;
        PIR1.ADIF = 0;
    }

    if(INTCON.TMR0IF == 1){

        // Realizar medicion
        ADCON0.ADON = 1;
        ADCON0.GO = 1;

        // Desactivar timer
        T0CON.TMR0ON = 0;
        INTCON.TMR0IF = 0;
    }
}

void main(){
    Lcd_init();

    // Configurar entrada/salida
    TRISB.B0 = 0;
    TRISB.B1 = 1;
    TRISE.B2 = 1;

    // Configurar AD
    ADCON0 = 0x79;
    ADCON1 = 0xC0;

    // Activar interrupciones perifericas
    INTCON.PEIE = 1;

    // Activar interrupciones AD
    PIR1.ADIF = 0;
    PIE1.ADIE = 1;

    // Configuracion timer
    T0CON = 0x83;
    TMR0H = (ALFA >> 8);
    TMR0L = ALFA;

    // Activar interrupciones timer
    INTCON.TMR0IF = 0;
    INTCON.TMR0IE = 1;

    // Activar interrupciones globales
    INTCON.GIE = 1;

    // Realizar primera medicion
    ADCON0.GO = 1;

    while(1){

    }
}