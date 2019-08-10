#include <msp430.h>
#include <stdint.h>


void debounce();
__interrupt void P2ISR();
void config();


int main(void){

    WDTCTL = WDTPW | WDTHOLD;   // stop watchdog timer

    config();

    while(1){
        if((P2IN & BIT1)==0){
            P2ISR();

        }

    }




}

void config(){
    //CONFIG.
        P1DIR |= BIT0;
        P2DIR &= ~BIT1;
        P2REN |= BIT1;
        P2OUT |= BIT1;

}


/*
void debounce(){

volatile unsigned int i;
i = 10000;

    do{
        i--;
    }while (i != 0);

}
*/

#pragma vector=PORT2_VECTOR
__interrupt void P2ISR(){

    //ação
    volatile unsigned int i;
    i = 10000;

        do{
            i--;
        }while (i != 0);


    P1OUT ^= BIT0;

    P2IFG &= ~BIT1;
}





