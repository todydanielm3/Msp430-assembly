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
ORV2:		mov			#vetor,R5
			mov			#2,R5
			mov			#4,R6
			mov			#6,R7
			mov			#8,R8
			mov			#2,R11
			call		#loop

loop:		cmp			vetor(R5),vetor(R6)
			jlo			troca1
			cmp			vetor(R6),vetor(R7)
			jlo			troca2
			cmp			vetor(R7),vetor(R8)
			jlo			troca3
			dec			R11
			jnz			loop
ok			jc			ok

troca1:		mov			vetor(R5),R9
			mov			vetor(R6),R10
			mov			R10,vetor(R5)
			mov			R9,vetor(R6)
			call		#loop

troca2:		mov			vetor(R6),R9
			mov			vetor(R7),R10
			mov			R10,vetor(R6)
			mov			R9,vetor(R7)
			call		#loop

troca3:		mov			vetor(R7),R9
			mov			vetor(R8),R10
			mov			R10,vetor(R7)
			mov			R9,vetor(R8)
			call		#loop



                                            
			.data
vetor:		.word		4,9,6,4,3
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
            
