#include <msp430.h>

#pragma vector=PORT1_VECTOR

__interrupt void P1ISR();
void debounce();

int main(void)
{
	WDTCTL = WDTPW | WDTHOLD;	// stop watchdog timer

	P1DIR |=   BIT0;
	P1DIR &=  ~BIT1;
	P1REN |=   BIT1;
	P1OUT |=   BIT1;

	
	while(1){
	    if((P1IN & BIT1)==0){
	        P1ISR();
	        debounce();
	    }
	    else{
	        debounce();
	    }
	}



	return 0;
}

void debounce(){

volatile unsigned int i;
i = 10000;

    do{
        i--;
    }while (i != 0);

}


__interrupt void P1ISR(){
    P1OUT ^= BIT0;
    P1IFG &= ~BIT1;

    return main();
}
