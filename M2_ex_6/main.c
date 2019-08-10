/*Multiplas interrupções
Usando interrupções programe um contador binario de 2 bits.
led verde LSB e o led vermelho MSB. Os leds iniciam apagados.
O contador incrementa a cada acionamento de S2 e decrementa com S1.
elimine os rebotes
*/

#include <msp430.h> 
#pragma vector=PORT1_VECTOR

__interrupt void P1ISR();
__interrupt void P2ISR();

int main(void)
{
	WDTCTL = WDTPW | WDTHOLD;	// stop watchdog timer
	
	//config. pinos

	P1DIR |=  BIT0;
	P4DIR |=  BIT7;
	P2DIR &= ~BIT1;
	P1DIR &= ~BIT1;
	P1REN |=  BIT1;
	P2REN |=  BIT1;
    P1OUT |=  BIT1;
    P2OUT |=  BIT1;

    while(1){
        if((P1IN & BIT1)==0){
            //SOMA S2
            P1ISR();
        }

        if((P2IN & BIT1)==0){
            //SUBTRAI S1
            P2ISR();
            }

 }


	return 0;
}



__interrupt void P2ISR(){

    return main();
}
