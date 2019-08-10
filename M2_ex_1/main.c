#include <msp430.h> 

int main(void)
{
	WDTCTL = WDTPW | WDTHOLD;	// stop watchdog timer

//config. pinos
	P4DIR   |=  BIT7;   //zera
	P2DIR   &= ~BIT1;   //zera o botão S1
	P2REN   |=  BIT1;   //habilita o resistor
	P2OUT   |=  BIT1;   //ativa o resistor pull-down

//loop
	while(1){
	    if((P2IN & BIT1)==0){ //verifica se o botão S1 está pressionado
	        P4OUT |= BIT7; //liga o led verde
	    }
	    else{
	        P4OUT &= ~BIT7; //desliga o led verde
	    }

	}




	return 0;
}
