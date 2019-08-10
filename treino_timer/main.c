#include <msp430.h> 
#include <stdint.h>

void configtimer();

int main(void)
{
    WDTCTL = WDTPW | WDTHOLD;   // stop watchdog timer

    configtimer();

    while(1){
        while(!(TA1CCTL0 & CCIFG));//ESPERA UM SEGUNDO
        TA1CCTL0 &= ~CCIFG;//INICIA TA0
        TA0CTL |= MC__UP;
        P1OUT |= BIT0;

        while(!(TA0CCTL0 & CCIFG));//ESPERA 20MS
        TA0CCTL0 &= ~CCIFG;
        TA0CTL &= ~MC__UP;
        TA0CTL |= TACLR;
        P1OUT &= ~BIT0;
    }


    return 0;
}


void configtimer(){

    //led butão
    P1DIR |= BIT0;
    P1SEL |= BIT0;


    TA1CTL = TASSEL__ACLK | MC__UP |TACLR;
    TA1CCR0 = 32768-1;
    TA0CTL = TASSEL__SMDLK |MC__HOLD|TACLR;
    TA0CCR0 = 20-1;


    //P1DIR &= ~BIT1;
    //P1REN |= BIT1;
    //P1OUT |= BIT1;

}
