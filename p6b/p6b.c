// LCD pinout settings
sbit LCD_RS at RD2_bit;
sbit LCD_EN at PORTD.B3;
sbit LCD_D7 at RD7_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D4 at RD4_bit;

// Pin direction
sbit LCD_RS_Direction at TRISD2_bit;
sbit LCD_EN_Direction at TRISD.B3;
sbit LCD_D7_Direction at TRISD7_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D4_Direction at TRISD4_bit;

const float LAMBDA = 0.0048875; // Resolucion

int v = 0; // Voltaje
char txt[16];
float aux = 0.0; // Temperatura final en float
int temp = 0; // Temperatura final a mostrar en el LCD

void FloatToInt(float aux, int *temp) {
    if (aux >= 0)
        *temp = (int)(aux + 0.5);
    else
        *temp = (int)(aux - 0.5);
}

void interrupt(){

    if(PIR1.ADIF == 1){
        // Realizar medicion del voltaje del termometro
        v = ADRESL;
        v = v + (ADRESH << 8);

        // v = 0.130138V / (5V / 1023) = 0.130138 / 0.0048875 ˜ 26.63 ˜ 27 (en counts ADC)
        aux = 100*(v*LAMBDA) - 50;

        FloatToInt(aux, &temp);

        // Limpiamos el LCD y mostramos el valor
        Lcd_Cmd(_Lcd_Clear);
        IntToStr(temp, txt);
        Lcd_out(1,1, txt);

        // Apagar AD
        ADCON0.ADON = 0;
        ADCON0.GO = 0;
        PIR1.ADIF = 0;

        // Iniciar temporizacion de 1.2 segundos
        T0CON.TMR0ON = 1;
        TMR0H = (28036 >> 8);
        TMR0L = 28036;
    }

    if(INTCON.TMR0IF == 1){

        // Una vez pasan los 1.2 segundos salta overflow del timer y encendemos el AD
        ADCON0.ADON = 1;
        ADCON0.GO = 1;
        T0CON.TMR0ON = 0;
        INTCON.TMR0IF = 0;
    }

}

void main(){
    Lcd_init();

    // Configurar AD
    ADCON0 = 0x59;
    ADCON1 = 0xC0;

    // Entrada del termometro
    TRISA.B3 = 1;

    // Habilitar interrupcion del timer
    T0CON = 0x85;
    INTCON.TMR0IF = 0;
    INTCON.TMR0IE = 1;


    // Habilitar interrupcion del AD
    PIR1.ADIF = 0;
    PIE1.ADIE = 1;
    INTCON.PEIE = 1;

    // Habilitar interrupciones en general
    INTCON.GIE = 1;

    // Realizar primera medicion
    ADCON0.GO = 1;

    while(1) {

    }
}