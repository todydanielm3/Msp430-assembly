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
ordv:		mov		#vetor,R5
			call	#loop

loop:		mov		#5,R9
			mov		#2,R6
			clr		R5
			call	#ordena

ordena:		add		#2,R5
			add		#2,R6
			cmp		vetor(R5),vetor(R6)
			jlo		troca1
			dec		R9
			jnz		ordena
			nop
			nop
			jmp		$


troca1:		mov		vetor(R5),R7
			mov		vetor(R6),R8
			mov		R8,vetor(R5)
			mov		R7,vetor(R6)
			call	#loop


			.data
vetor:		.word	4,9,6,4,3
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
            
