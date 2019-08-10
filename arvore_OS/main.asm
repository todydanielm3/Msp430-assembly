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
;Main loop here
;Daniel Moraes da Silva - Engenharia de Computação
;Percurso Arvore: Ordem Simetrica
;-------------------------------------------------------------------------------
OS:			mov.b		#arv,R4
			mov.b		#ARV,R5
			mov.b		#0,R6

SUBESQ:		mov.b		#7,R7				;|
			mov.b		arv(R7),ARV(R6)		;|> Imprime H
			add.b		#1,R6				;|

			mov.b		#3,R7				;|
			mov.b		arv(R7),ARV(R6)		;|> Imprime D
			add.b		#1,R6				;|

			mov.b		#8,R7				;|
			mov.b		arv(R7),ARV(R6)		;|> Imprime I
			add.b		#1,R6				;|

			mov.b		#1,R7
			mov.b		arv(R7),ARV(R6)		;|> Imprime B
			add.b		#1,R6

			mov.b		#4,R7
			mov.b		arv(R7),ARV(R6)		;|> Imprime E
			add.b		#1,R6

			mov.b		#0,R7
			mov.b		arv(R7),ARV(R6)		;|> Imprime A
			add.b		#1,R6
			call		#SUBDIR				;chama subrotina para percorrer a subArvora da a direita

SUBDIR:		mov.b		#5,R7
			mov.b		arv(R7),ARV(R6)		;|> Imprime	F
			add.b		#1,R6

			mov.b		#2,R7
			mov.b		arv(R7),ARV(R6)		;|> Imprime C
			add.b		#1,R6

			mov.b		#6,R7
			mov.b		arv(R7),ARV(R6)		;|> Imprime G
			add.b		#1,R6
			call		#FIM

FIM:		jmp			$


			.data
arv:        .byte	    "ABCDEFGHI"

			.data
ARV:		.byte		"000000000"

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
            
