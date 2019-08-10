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
; Questão 8
;-------------------------------------------------------------------------------
	;programa que acusa por meio de subrotina se é palidroma ou não
	;verdade --> se a for palidroma
	;falso --> se nao for palidroma

Q8:			mov.b	#frase,R5				;Inicia R5(registror) como indereco de memoria
			mov.b	#1,R6					;colocar 1 em R6 para identificar o primeiro elemento
			mov.b	#12,R7					;colocar 12 em R7 para identificar o ultimo elemento
			clr		R8						;limpar o registro R8
			call	#compara				;chama subrotina #compara

compara:	sub.b	frase(R6),frase(R7)		;subitrai o primeiro elemento do ultimo
			jz		verdade					;se resultado for igual a zero >> acusa ser verdado logo e palindroma >> chama subrotina verdade
			call	#falso					;caso contrario >> diferente de zero >> acusa não ser palidroma >> chama subrotina falso

verdade:	jmp		$						;processamento parando aqui, significa q a frase e palidroma

falso:		jmp		$						;processamento parando aqui, significa q a frase nao e palidroma



			.data
frase:		.byte	 12,"subinoonibus"

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
            
