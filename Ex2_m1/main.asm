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
ex1:			mov		#vetor,R5
				mov		#2,R8
				mov		#8,R11
				clr		R7
				mov		#2,R9
				call	#MAIOR16

MAIOR16:		add		#2,R9
				cmp		vetor(R8),vetor(R9)
				jhs		conta
				dec		R11
				jnz		MAIOR16
				call	#part2

conta:			mov		vetor(R9),R6
				mov		vetor(R8),R5
				mov		R6,vetor(R8)
				mov		R5,vetor(R9)
				mov		vetor(R8),R6
				call	#MAIOR16

part2:			clr		R7
				mov		#2,R8
				mov		#8,R11
				mov		#2,R9
				call	#repets

repets:
				add		#2,R9
				mov		vetor(R9),R12
				mov		vetor(R8),R13
				sub		R12,R13
				jnz		cont
				mov		#1,R7
				call	#cont

cont:			dec 	R11
				jnz		repets
				jmp		$


            	.data
vetor:			.word		6,"DANIELMORASS",0
                                            

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
            
