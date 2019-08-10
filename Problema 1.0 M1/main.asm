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
;Ordenar um vetor
P1:		    mov  		#vetor,R5	;R5 com endereço do vetor
			mov			#vetorr,R9
			clr			R4
			mov			@R5,R6
			call	 	#ORDENA
			jmp			$
			nop

ORDENA:     mov			@R5+,R7
			mov			@R5,R7
			mov         @R5+,R8
			mov         @R5,R8
			cmp         R7,R8
			jhs			TROCA
			nop
			ret

TROCA:		add			#1,R4
			mov			R8,R7
			call		#ORDENA

			.data
vetor:		.byte		12,"VICTORDANIEL"

			.data
vetorr:		.byte		12,"TESTANDOOOOO"
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
