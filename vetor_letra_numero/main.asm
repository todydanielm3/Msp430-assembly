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
vetLN:		mov.b		#vetor,R5
			call		#loop

loop:		clr			R5
			mov.b		#1,R6
			mov.b		#21,R9
			call		#ordena

ordena:		add.b		#1,R5
			add.b		#1,R6
			cmp.b		vetor(R5),vetor(R6)
			jlo			troca
			dec			R9
			jnz			ordena
			jmp			$


troca:		mov.b		vetor(R5),R7
			mov.b		vetor(R6),R8
			mov.b		R8,vetor(R5)
			mov.b		R7,vetor(R6)
			call		#loop


			.data
vetor:		.byte	21,"DANIELMORAES180112333"
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
            
