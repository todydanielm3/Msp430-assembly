/*Temporização imprecisa -> Sem utilização de timers
 * Piscar led em aproximadamente 1Hz. 500ms aceso 500ms apagado*/
#include <msp430.h> 

void debounce();
void debounce2();
int main(void)
{
	WDTCTL = WDTPW | WDTHOLD;	// stop watchdog timer
	
	//Config.
	P4DIR   |=  BIT7;
	P4REN   |=  BIT7;
	P4OUT   |=  BIT7;

	volatile unsigned int i;

while(1){
	    debounce();
	    debounce2();
}




	return 0;
}

void debounce(){

volatile unsigned int i;    // Declara a variável i como sem sinal (unsigned) e usa o modificador volatile para previnir otimização do compilador

i = 1000000000;

            do{
                P4OUT |= BIT7;
                i--;
            }while(i != 0);              // Esta é uma forma simples de temporizar
   }

void debounce2(){

volatile unsigned int i;    // Declara a variável i como sem sinal (unsigned) e usa o modificador volatile para previnir otimização do compilador

i = 1000000000;

            do{
                P4OUT &= ~BIT7;
                i--;
            }while(i != 0);              // Esta é uma forma simples de temporizar
   }


