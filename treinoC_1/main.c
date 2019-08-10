#include <msp430.h> 

int main()
{
	WDTCTL = WDTPW | WDTHOLD;	// stop watchdog timer

	//configurar p1.0
	P1DIR |= BIT0;   //ou forma não compacta P1DIR = P1DIR | BIT0;   //0x01

	//criando loop
	while(1){

	   //toggle the led XOR
	    P1OUT   ^= BIT0; //altera o bit p1.0 (led vermelho) se for 0 vai para 1, se for 1 vai para 0

	}

	
	return 0;
}
