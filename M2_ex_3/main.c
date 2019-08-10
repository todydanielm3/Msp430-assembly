//Remoção de Rebotes

// O modificador volatile diz ao compilador que a variável em questão pode ser alterada sem que este seja avisado.
//Isto evita "bugs" que poderiam ocorrer se o compilador tentasse fazer uma otimização no código que não é segura quando a memória é modificada externamente.

#include <msp430.h> 

void debounce();

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
        debounce();
        if((P1IN & BIT1)==0){//verifiva se o botão S1 está precionado
            P1OUT   ^= BIT0;
            debounce();
       }
        else{
            P1DIR  |=  BIT0;

    }

    return 0;
}

void debounce(){

volatile unsigned int i;    // Declara a variável i como sem sinal (unsigned) e usa o modificador volatile para previnir otimização do compilador

i = 10000;

            do{
                i--;
            }while(i != 0);              // Esta é uma forma simples de temporizar
   }





