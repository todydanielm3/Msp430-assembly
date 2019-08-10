//Trava de execução com condições  mais elaboradas
//Escreva na função main() uma rotina que alterne  estado do led vermelho toda vez que o usuario apertar  S1 ou S2

#include <msp430.h>

void debounce();

int main(void)
{
    WDTCTL = WDTPW | WDTHOLD;	// stop watchdog timer
	
    volatile unsigned  int i;
	//conifg.
	P1DIR |=  BIT0;
	P1DIR &= ~BIT1;
	P2DIR &= ~BIT1;
	P1REN |=  BIT1;
	P2REN |=  BIT1;
	P1OUT |=  BIT1;
	P2OUT |=  BIT1;


	while(1){
	    if(((P1IN & BIT1)==0)||((P2IN & BIT1)==0)){
	        P1OUT ^= BIT0;
	        debounce();
	    }
	    else{
	        debounce();
	    }

	}



	return 0;
}

void debounce(){
volatile unsigned  int i;
i=10000;

    do{
        i--;
    }while(i !=0 );

}




