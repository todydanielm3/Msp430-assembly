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
ex1:		mov.b		#vetor,R5
			mov.b		#1,R8
			mov.b		#12,R11
			clr			R7
			mov.b		#1,R9
			call		#MENOR

MENOR:		add.b		#1,R9
			cmp.b		vetor(R8),vetor(R9)
			jlo			conta
;			jeq			conta
			dec			R11
			jnz			MENOR
			call		#part2

conta:		mov.b		vetor(R9),R6
			mov.b		vetor(R8),R5
			mov.b		R6,vetor(R8)
			mov.b		R5,vetor(R9)
			mov.b		vetor(R8),R6
			add.b		#1,R7
			call		#MENOR

part2:		mov.b		#2,R8
			mov.b		#12,R11
			mov.b		#2,R9
			call		#repets

repets:
			add.b		#2,R9
			mov.b		vetor(R9),R12
			mov.b		vetor(R8),R13
			sub.b		R12,R13
			jnz			cont
			mov.b		#1,R7
			call		#cont

cont:		dec 	R11
			jnz		repets
			jmp		$


            .data
vetor:		.byte		12,"DANIELMORAES"
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
            
