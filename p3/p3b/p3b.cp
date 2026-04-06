#line 1 "C:/Users/looko/Desktop/trabajos uni/HAE/practicas/p3b/p3b.c"
void interrupt(){

 if(PORTB.B3 == 0){
 PORTB.B3 = 1;
 }else{
 PORTB.B3 = 0;
 }

 INTCON3.INT2IF = 0;
}

void main(){

 TRISB.B2 = 1;
 INTCON2.INTEDG2 = 1;
 INTCON3.INT2IF = 0;
 INTCON3.INT2IE = 1;
 INTCON.GIE = 1;

 TRISB.B3 = 0;
 PORTB.B3 = 0;

 while(1){

 }
}
