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
; Questão 4
;-------------------------------------------------------------------------------
Q4:			mov.b		#fila1,R5				;Inicia R5(registror) como indereï¿½o de memoria da fila
			mov.b		#fila2,R6				;Inicia R6(registror) como indereï¿½o de memoria da fila
			mov.b		#pilha,R7				;Inicia R7(registror) como indereï¿½o de memoria da PILHA
			mov.b		#5,R8					;Mover o tamanho da fila para o registror R8
			call		#mover					;Chama a subrotina Mover

mover:
			mov.b		fila1(R8),fila2(R8)		;mover o conteudo da fila1(no indice R8) para a fila2
			dec			R8						;decrementa R8
			jnz			mover					;se diferente de zero, ir para mover
			call		#remover				;chama a subrotina Remover

remover:	mov.b		#5,R8					;definir o atual indice (ultimo que foi inserido) que serï¿½ removido
			pop.b		fila2(R8)				;remove o ultimo elemente inserido
			call		#pilhaa					;chama pilha

pilhaa:		mov.b		fila2(R8),pilha(R8)		;movendo todos os elementos da fila2 para a pilha
			dec			R8
			jnz			pilhaa					;se diferente de zero, ir para mover
			jmp			$						;trava programa
			nop


;--------DECLARACOES DAS FILAS E PILHAS-----------------------------------------
			.data
fila1:		.byte		5,"01234"				;definindo o tamanho da fila1 e seu conteudo

			.data
fila2:		.byte		5,"00000"

			.data
pilha:		.byte		5,"00000"

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
