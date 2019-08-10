#include <msp430.h> 

int main(void)
{
	WDTCTL = WDTPW | WDTHOLD;	// stop watchdog timer

//configurando porta p4.7 com resistor de pull-down

	P4DIR   |=   BIT7;  //zera p4.7
	P4REN   &=  ~BIT7;  //ativa o resistor
	P4OUT   &=  ~BIT7;  //pull-donw

//LOOP
	while(1){
	P4OUT   ^=  BIT7;

	}
	
	return 0;
}
