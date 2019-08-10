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
; Daniel Moraes da Silva - Engenharia da Computação
; Questão 5
;-------------------------------------------------------------------------------
Q5:			mov.b		#pilha1,R5				;Inicia R5(registror) como indereço de memoria da pilha1
			mov.b		#pilha2,R6				;Inicia R6(registror) como indereço de memoria da pilha2
			mov.b		#fila,R7				;Inicia R7(registror) como indereço de memoria da FILA
			mov.b		#8,R8					;Mover o tamanho da fila para o registror R8(INICIO)
			call		#mover					;Chama a subrotina Mover

mover:
			mov.b		pilha1(R8),pilha2(R8)	;mover o conteudo da pilha1(no indice R8) para a pilha2
			dec			R8						;decrementa R8
			jnz			mover					;se diferente de zero, ir para mover
			call		#remover				;chama a subrotina Remover

remover:	mov.b		#1,R8					;definir o atual indice (PRIMEIRO que foi inserido) que será removido
			pop.b		pilha2(R8)				;remove o PRIMEIRO elemente inserido
			mov.b		#8,R8
			call		#FILA					;chama FILA

FILA:		mov.b		pilha2(R8),fila(R8)		;movendo todos os elementos da fila2 para a pilha
			dec			R8
			jnz			FILA					;se diferente de zero, volta loop FILA
			jmp			$						;trava programa
			nop


;--------DECLARAÇÕES DAS FILAS E PILHAS-----------------------------------------
			.data
pilha1:		.byte		8,"ASSEMBLY"				;definindo o tamanho da pilha1 e seu conteudo

			.data
pilha2:		.byte		8,"00000000"				;definindo o tamanho da pilha2 e seu conteudo

			.data
fila:		.byte		8,"00000000"				;definindo o tamanho da FILA e seu conteudo


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
            
