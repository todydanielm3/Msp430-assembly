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
;COMPARA R5 COM R6 SE R5 FOR MENOR DIVIDA R6 POR 2 ATÉ R5 FICAR MAIOR
PRO:		mov		#4,R5		;colocar o valor 4 em R5
			mov		#80,R6		;colocar o valor 80 em R6

LOOP:		cmp		R6,R5		;compara R5(referencia) com R6
			jhs 	FIM			;se R5 for maior ---> fim
			call	#MENOR		;chamar subrotina MENOR

MENOR:		rra		R6			;R6/2
			jmp		LOOP		;volta para o loop

FIM:		jmp		$			;trava execuçã num laço infinito
                                            

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
            
