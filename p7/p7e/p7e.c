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

// Constantes para configurar timer y AD
const int ALFA = 3036;
const float LAMBDA = 0.0048875;

// Variables para el voltaje
int v0 = 0;
float vi = 0.0;

// Variables para la presion
float pa = 0.0;
float pressure = 0.0;
int unitOption = 0;

// Texto para el LCD
char txt[16];

void mostrarLCD(float value){
    Lcd_Cmd(_Lcd_Clear);
    FloatToStr(value, txt);
    Lcd_Out(1, 3, txt);
}

float vToPa(float v){
    return 54.2 * v - 14.11;
}

float changeUnit(float pas, int opt){
    float converted;

    switch(opt){
        case 0: // Pa
            converted = pas;
            break;
        case 1: // PSI
            converted = pas / 6894.757;
            break;
        case 2: // Atm
            converted = pas / 101325.0;
            break;
        case 3: // mbar
            converted = pas / 100.0;
            break;
        case 4: // mmHg
            converted = pas / 133.322;
            break;
        case 5: // N/cm^2
            converted = pas / 10000.0;
            break;
        case 6: // Kg/cm^2
            converted = pas / 98066.5;
            break;
        case 7: // Kp/cm^2
            converted = pas / 98066.5;
            break;
        default:
            converted = pas;
            break;
    }

    return converted;
}

void interrupt(){

    // Interrupcion por medicion en el AD
    if(PIR1.ADIF == 1){

        // Leer medicion
        v0 = (ADRESH << 8) + ADRESL;
        vi = v0 * LAMBDA;

        pa = vToPa(vi);
        pressure = changeUnit(pa, unitOption);
        mostrarLCD(pressure);

        // Activar el timer
        T0CON.TMR0ON = 1;
        TMR0H = (ALFA >> 8);
        TMR0L = ALFA;

        // Desactivar AD
        ADCON0.ADON = 0;
        PIR1.ADIF = 0;
    }

    // Interrupcion overflow del Timer
    if(INTCON.TMR0IF == 1){

        // Realizar medicion
        ADCON0.ADON = 1;
        ADCON0.GO = 1;

        // Desactivar timer
        T0CON.TMR0ON = 0;
        INTCON.TMR0IF = 0;
    }

    // Interrupcion pulsacion del boton
    if(INTCON3.INT1IF == 1){
        // Cambiar unidad y refrescar LCD sin esperar al timer
        unitOption++;
        if(unitOption > 7){
            unitOption = 0;
        }

        pressure = changeUnit(pa, unitOption);
        mostrarLCD(pressure);


        INTCON3.INT1IF = 0;
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

    // Configurar interrupciones boton
    INTCON2.INTEDG1 = 1;
    INTCON3.INT1IF = 0;
    INTCON3.INT1IE = 1;

    // Activar interrupciones globales
    INTCON.GIE = 1;

    // Realizar primera medicion
    ADCON0.GO = 1;

    while(1){

    }
}