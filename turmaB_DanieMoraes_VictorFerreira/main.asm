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
;-------------------------------------------------------------------------------
;Daniel Moraes da Silva    18/0112333
;Victor Ferreira Gonçalves 18/0047345
P1:		    mov.b  		#vetor,R5		;R5 com endereço do vetor
			mov.b		#0,R5			;R5 inicia com 0
			mov.b		#12,R6			;R6 inicia com o tamanho do vetor para decrementar conforme percorre o vetor
			call	 	#ORDENA			;chama a subrt ORDENA
			jmp			$				;trv
			nop

ORDENA:		call		#R_CINCO		;chama a sbrt onde será adicionado 1 em R5
			cmp.b		R5+1,vetor(R5)
			jhs			TROCA
			nop
			ret

R_CINCO:	add			#1,R5			;adciona 1 em R5
			mov.b 		vetor(R5),R7	;coloca o valor do vetor do indice 1 em R7
			DEC			R6
			ret

TROCA:		mov.b		R5+1,R8
			mov.b		R8,R7
			call		#R_CINCO

			.data
vetor:		.byte		12,"VICTORDANIEL"
                                            
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
            
