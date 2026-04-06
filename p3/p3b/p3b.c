void interrupt(){

    if(PORTB.B3 == 0){
        PORTB.B3 = 1;
    }else{
        PORTB.B3 = 0;
    }

    INTCON3.INT2IF = 0; // Se borra el flag de la interrupcion INT2
}

void main(){

    TRISB.B2 = 1; // Se configura RB2 como entrada
    INTCON2.INTEDG2 = 1; // Configurado a flancos de subida
    INTCON3.INT2IF = 0; // Flag de interrupcion INT2 a 0
    INTCON3.INT2IE = 1; // Se habilita la interrupcion INT2
    INTCON.GIE = 1; // Se habilitan las interrupciones en general

    TRISB.B3 = 0;
    PORTB.B3 = 0;

    while(1){

    }
}