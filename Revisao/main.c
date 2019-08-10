#include <msp430.h>

void debounce();

int main(){

    WDTCTL = WDTPW | WDTHOLD; // stop watchdog timer

    P1DIR  |=  BIT0;
    P2DIR  &= ~BIT1;
    P1DIR  &= ~BIT1;
    P2REN  |=  BIT1;
    P1REN  |=  BIT1;
    P2OUT  |=  BIT1;
    P1OUT  |=  BIT1;


    while(1){
        if(((P1IN & BIT1)==0)||((P2IN & BIT1)==0)){
            debounce();
            P1OUT ^= BIT0;

        }
        else{
            debounce();
        }

    }
}

void debounce(){
volatile unsigned  int i;
i=10000;

    do{
        i--;
    }while(i !=0 );

}
