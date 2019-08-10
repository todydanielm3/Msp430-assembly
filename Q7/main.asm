;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
;
;
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file
            
;-------------------------------------------------------------------------------
            .def    RESET                   ; Export program entry-point to
                                            ; make it known to linker.
;-------------------------------------------------------------------------------
            .text                           ; Assemble into program memory.
            .retain                         ; Override ELF conditional linking
                                            ; and retain current section.
            .retainrefs                     ; And retain any sections that have
                                            ; references to current section.

;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer


;-------------------------------------------------------------------------------
; Main loop here
; Trabalho_P1
; Daniel Moraes da Silva - Engenharia de Computação
; Questão 7
;-------------------------------------------------------------------------------
Q7:			mov.b		#frase,R5					;Inicia R5(registror) como indereco de memoria
			mov.b		#invert,R6					;Inicia R6(registror) como indereco de memoria
			mov.b		#1,R7						;coloca 1 em R7 para representar o indice inicio
			mov.b		#18,R8						;coloca 18 em R8 para representar o indice fim
			call		#trocar						;chamar subrotina trocar

trocar:		mov.b		frase(R7),invert(R8)		;mover o conteudo do primeiro indice R7 da frase para o ultimo indice R8 da invert
			add.b		#1,R7						;deslocar uma unidade da frase para direira
			dec.b		R8							;deslocar uma unidade da invert para esquerda
			jz			FIM							;se R8 for igual a zero >> percorreu tudo >> chama FIM
			call		#trocar						;se não volta para subrotina #trocar

FIM:		jmp			$							;trava execuçã num laço infinito



                                            
			.data
frase:		.byte		18,"DESMONTAR E MONTAR"		;definindo o tamanho 18 e preenchenado com elementos

			.data
invert:		.byte		18,"000000000000000000"		;definindo o tamanho 18 e preenchenado com elementos

;-------------------------------------------------------------------------------
; Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect   .stack
            
;-------------------------------------------------------------------------------
; Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
            
