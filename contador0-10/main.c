#include <msp430.h> 

configtimer();
int main(void)
{
	WDTCTL = WDTPW | WDTHOLD;	// stop watchdog timer
	

	configtimer();

	while(1){
	    while(!(TA0CCTL0 & TAIFG));
	    P1OUT ^= BIT0;
	    TA0CCTL0 &= ~TAIFG;
	}



	return 0;
}
configtimer(){
    TA0CTL = TASSEL__ACLK | MC__UP | TACLR;

    TA0CCR0 = 10;
}
