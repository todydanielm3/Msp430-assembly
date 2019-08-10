#include <msp430.h> 
//programa treino. Liga o lede vermelho ao precionar o botão S2

int main(void)
{
	WDTCTL = WDTPW | WDTHOLD;	// stop watchdog timer
	
//congiguração dos pinos de entrada

	P1DIR   |=  BIT0;   //zera o led vermelho
	P1DIR   &= ~BIT1;   //zera o botaão S1
	P1REN   |=  BIT1;   //habilita o resistor pull down/pull up
	P1OUT   |=  BIT1;   //seleciona pull down

//LOOP

	while(1){
	    if((P1IN & BIT1)==0){//verifiva se o botão S1 está precionado
	   P1OUT   |= BIT0;  //liga o led vermelho
	}
	        else{
	            P1OUT   &= ~BIT0;  //desliga o led vermelho
	        }
	}

	return 0;
}
