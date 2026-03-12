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

int v = 0; //Voltaje
char txt[16];
int temp = 0; // Temperatura final a mostrar en el lcd
float aux = 0.0; // Temperatura final en float (no se puede mostrar por el demo limit del MikroC)
float res = 0.0048875;

int floatToInt(float num) {
    if (num >= 0.0)
        return (int)(num + 0.5);
    else
        return (int)(num - 0.5);
}

void interrupt(){

    if(PIR1.ADIF == 1){
        //Tomamos valor del termometro y le aplicamos formula del enunciado:
        v = ADRESL;
        v = v + (ADRESH << 8);

        // v = 0.130138V / (5V / 1023) = 0.130138 / 0.0048875 ˜ 26.63 ˜ 27 (en counts ADC) => Esto en el terrífico caso de que un voltaje de 0,130138 da -37 grados xd:
        aux = 100*(v*res) - 50;

        temp = floatToInt(aux);

        //Limpiamos el LCD y pasamos el valor recien calculado para que lo muestre:
        Lcd_Cmd(_Lcd_Clear);
        IntToStr(temp, txt);
        Lcd_out(1,1, txt);

        //Apagamos el AD:
        ADCON0.ADON = 0;
        ADCON0.GO = 0;
        PIR1.ADIF = 0;

        //Iniciamos el timer de 1,2 segundos:
        T0CON.TMR0ON = 1;
        TMR0H = (28036 >> 8);
        TMR0L = 28036;
    }

    if(INTCON.TMR0IF == 1){

        //Una vez pasan los 1,2 segundos, salta overflow del timer y pasamos a la interrupcion, donde accedemos a este apartado donde seteamos de vuelta el AD:
        ADCON0.ADON = 1;
        ADCON0.GO = 1;
        T0CON.TMR0ON = 0;
        INTCON.TMR0IF = 0;
    }

}

void main(){
    Lcd_init();

    //Setear el ADCON0 y ADCON1:
    ADCON0 = 0x59;
    ADCON1 = 0xC0;

    //Entrada del termometro:
    TRISA.B3 = 1;

    //Habilitar interrupción del timer:
    T0CON = 0x85;
    INTCON.TMR0IF = 0;
    INTCON.TMR0IE = 1;


    //Habilitar interrupció n del AD:
    PIR1.ADIF = 0;
    PIE1.ADIE = 1;
    INTCON.PEIE = 1;

    //Por ultimo, muy importante, habilitar interrupciones en general:
    INTCON.GIE = 1;

    //Encendemos el GO para que el AD tome un valor del termometro y empieza a fukar el circuito:
    ADCON0.GO = 1;

    while(1) {

    }
}