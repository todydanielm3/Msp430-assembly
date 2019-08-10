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
P1:   		mov.b	     #vetor,R5     ;R5 com endereço do vetor
      		mov.b 	 	 #1,R6         ;O pivo R6 inicia com 1
      		mov.b 	 	 #2,R7         ;O auxiliar R7 inicia com 2
      		mov.b        #11,R11       ;R11 inicia com o tamanho do vetor para decrementar conforme percorre o vetor
      		mov.b        #0,R9         ;O contador que atualiza o pivo
      		mov.b        #0,R10
      		call         #ORDENA       ;chama a subrt ORDENA
      		jmp          $  		   ;trv
      		nop


ORDENA:
      		cmp.b    	vetor(R7),vetor(R6) ; compara se é maior
      		jhs      	TROCA               ; se for ,acontece a troca de posições
      		call     	#R_CINCO
      		nop
      		ret

R_CINCO:  	add      	#1,R7      ;adciona 1 no auxiliar
      	    DEC      	R11
      	    cmp.b    	R11,R10     ; checa se o pivo atual já percorreu todo o vetor
      		jhs      	MUD_PIV
      		jmp         ORDENA

TROCA:    	mov.b    	vetor(R6),R8
            mov.b       vetor(R7),vetor(R6)
      		mov.b    	R8,vetor(R7)
      		call     	#R_CINCO

MUD_PIV:
            add         #1,R9
            mov.b       #11,R11
            sub         R9,R11 ;atualizou contador de tamanho do vetor a percorrer
            mov.b       #1,R6
            add         R9,R6 ;atualizou pivo
            mov.b       #1,R7
            add         R9,R7 ;atualizou auxiliar
            cmp         R11,R10
            jhs         FIM
            jmp         ORDENA

FIM:        jmp         $
            nop


      		.data
vetor:    	.byte    	12,"VICTORDANIEL"
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
            
