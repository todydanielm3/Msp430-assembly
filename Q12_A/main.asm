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
; Questão 12 a)
;-------------------------------------------------------------------------------
Q12B:		mov.b		#lista1,R5				;Inicia R5(registror) comoindereco de memoria da lista
			mov.b		#lista2,R6				;Inicia R6(registror) comoindereco de memoria da lista
			mov.b		#5,R7
			call		#soma

soma:		mov.b		lista1(R7),R8
			mov.b		lista1(R7),R9
			add.b		R8,R9
			mov.b		R9,conc(R7)
			dec			R7
			call		#soma
			jmp			$




			.data
lista1:		.byte		5,0x02, 0x02, 0x02, 0x02, 0x02				;definindo o tamanho da lista1 e seu conteudo

			.data
lista2:		.byte		5,0x02, 0x02, 0x02, 0x02, 0x02

			.data
conc:		.byte		5,0x00, 0x00, 0x00, 0x00, 0x00

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
            
