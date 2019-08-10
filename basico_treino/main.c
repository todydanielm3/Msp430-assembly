#include <msp430.h> 

int main(void)
{
	WDTCTL = WDTPW | WDTHOLD;	// stop watchdog timer
	
	//congig. leds vermelhor e verda P1.0 (vermelho)     P4.7(verde)
	P1DIR   |= BIT0;    //zera p1.0
	P4DIR   |= BIT7;    //zera p4.7

	P1REN   &= ~BIT0;   //ativa o resistor
	P4REN   &= ~BIT7;   //ativa o resistor

	P1OUT   &= ~BIT0;   //seleciona o resistor pull-down
	P4OUT   &= ~BIT7;   //seleciona o resistor pull-down

	//loop
	while(1){
	    P1OUT   ^= BIT0;
	    P4OUT   ^= BIT7;

	}

	return 0;
}
