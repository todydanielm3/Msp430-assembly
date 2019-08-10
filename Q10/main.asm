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
; Questão 10
;-------------------------------------------------------------------------------
Q10:		mov.b		#lista,R5					;Inicia R5(registror) como indereco de memoria
			mov.b		#invertida,R6				;Inicia R6(registror) como indereco de memoria
			mov.b		#1,R7						;inidice da lista inicia com 1
			mov.b		#8,R8						;inidice da lista_invertida inica com 8 (fim)
			call		#trocar						;chama trocar

trocar:		mov.b		lista(R7),invertida(R8)		;mover o primeiro elemento da lista para a ultima posicao
			add.b		#1,R7						;desloca um indice para direita
			dec.b		R8							;desloca um indice para esqueda
			jz			fim							;se estiver no final>>>ir para FIM
			mov.b		lista(R7),invertida(R8)		;---
			add.b		#1,R7						;   |
			dec.b		R8							;	|
			jz			fim							;   |
			mov.b		lista(R7),invertida(R8)		;   |
			add.b		#1,R7						;   |
			dec.b		R8							;   |
			jz			fim							;   |
			mov.b		lista(R7),invertida(R8)		;   |
			add.b		#1,R7						;   |
			dec.b		R8							;   |
			jz			fim							;   |
			mov.b		lista(R7),invertida(R8)		;   |||||}> Segue com os mesmos comandos
			add.b		#1,R7						;   |
			dec.b		R8							;   |
			jz			fim							;   |
			mov.b		lista(R7),invertida(R8)		;   |
			add.b		#1,R7						;   |
			dec.b		R8							;   |
			jz			fim							;   |
			mov.b		lista(R7),invertida(R8)		;   |
			add.b		#1,R7						;   |
			dec.b		R8							;   |
			jz			fim							;   |
			mov.b		lista(R7),invertida(R8)		;   |
			add.b		#1,R7						;   |
			dec.b		R8							;   |
			jz			fim							;---

fim:		jmp			$


			.data
lista: 		.byte		8,"12345678"				;tamanho da lista 8 e elementos

			.data
invertida:	.byte		8,"00000000"				;tamanho da lista invertia iniciada vazia


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
            
