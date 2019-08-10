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
main:
           	mov.b 			#vetor1,R5
           	mov.b 			#vetor2,R6
           	mov.b			#vetor3,R7
           	mov.b			#8,R11
           	clr				R9
           	clr				R8
			call			#loop

loop:		add.b			#1,R9
			dec				R11
			jnz				comp1
			call			#part2

comp1:		mov.b			vetor1(R9),R10
			and             #BIT0,R10
		   	jnz				impa1
		   	call			#par1

par1:		dec.b			R8
			dec.b			R8
			add.b			#1,R8
			mov.b			vetor1(R9),vetor3(R8)
			call			#loop

impa1:		add.b			#2,R8
			mov.b			vetor1(R9),vetor3(R8)
			call			#loop


part2:		mov.b			#6,R11
			call			#loop2

loop2:		mov.b			#0,R8
			mov.b			#1,R9
			call			#ordem

ordem0:		dec.b			R11
			jnz				ordem
			jmp				$

ordem:		add.b			#1,R8
			add.b			#1,R9
			mov.b			vetor3(R8),R10
			and             #BIT0,R10
			jnz				ordem0
		   	call			#par2


par2:		mov.b			vetor3(R8),R12
			mov.b			vetor3(R9),R13
			mov.b			R13,vetor3(R8)
			mov.b			R12,vetor3(R9)
			inc.b			R8
			call			#ordem0


			.data
vetor1:		.byte			3,3,8,7
vetor2:     .byte       	3,2,1,4
vetor3:     .byte       	6,0,0,0,0,0,0
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
            
