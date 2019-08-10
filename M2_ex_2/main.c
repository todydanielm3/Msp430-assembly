#include <msp430.h> 
//Ruído de chave mecanica. Altera o estado do led vermelho toda vez que o botão S1 for precionado

int main(void)
{
    WDTCTL = WDTPW | WDTHOLD;   // stop watchdog timer

//congiguração dos pinos de entrada

    P1DIR   |=  BIT0;   //zera o led vermelho
    P1DIR   &= ~BIT1;   //zera o botaão S1
    P1REN   |=  BIT1;   //habilita o resistor pull down/pull up
    P1OUT   |=  BIT1;   //seleciona pull down

//LOOP

    while(1){
        if((P1IN & BIT1)==0){//verifiva se o botão S1 está precionado
       P1OUT   ^= BIT0;  //altera o estao do led vermelho
       }
    }

    return 0;
}
