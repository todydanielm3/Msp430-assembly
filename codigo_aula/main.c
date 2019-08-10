#include <msp430.h> 

void config();
Unit8fb[3][3] = {};

int main(void)
{
	WDTCTL = WDTPW | WDTHOLD;	// stop watchdog timer


	config();
	fb[0][0]=1;
	fb[1][1]=1;
	fb[2][2]=1;

	while(1);
	
	return 0;
}

void config(){

    TA0CTL = TASSEL__ACLK|MC__UP;
    TA0CCR0 = 108;
    TA0CCTL0 = CCIE;
    __enable_interrupt();

    P1DIR |= (BIT3|BIT2|BIT1);
    P2DIR |= (BIT3|BIT2|BIT1);
    P1OUT = BIT1;

#pragma vector=TIMER0_A0_VECTOR
    __interrupt void TA0CCR0ISR(){

        if(P1OUT == BIT3)
            P1OUT = BIT1;
        else
            P1OUT<<=1;
        i=3;

    switch(P1OUT)

    case (BIT1)
    while(i--){
        if(fb[0][i])
            P2OUT &= ~(BIT1<<i);
    }

    case (BIT2)
    while(i--){
        if(fb[0][i])
            P2OUT &= ~(BIT2<<i);
    }

    case (BIT3)
    while(i--){
        if(fb[0][i])
            P2OUT &= ~(BIT3<<i);
    }

    }
}

