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

;''''''''''''''''''''''' PRIMEIRA PARTE DO PROGRAMA ''''''''''''''''''''''''''''
P1:			mov.b		#vetor,R5
			mov.b		#1,R5
			mov.b		#2,R6
			mov.b		#3,R7
			mov.b		#4,R8
			mov.b		#5,R9
			mov.b		#6,R10
			mov.b		#3,R13
			call		#loop1

;''''''''''''''''''''''' ORDENAÇÃO DA PRIMEIRA PARTE DO VETOR ''''''''''''''''''
loop1:		cmp.b		vetor(R5),vetor(R6)
			jhs			troca1
			cmp.b		vetor(R6),vetor(R7)
			jhs			troca2
			cmp.b		vetor(R7),vetor(R8)
			jhs			troca3
			cmp.b		vetor(R8),vetor(R9)
			jhs			troca4
			cmp.b		vetor(R9),vetor(R10)
			jhs			troca5
			dec			R13
			jnz			loop1
			call		#P2


troca1:		mov.b		vetor(R5),R11
			mov.b		vetor(R6),R12
			mov.b		R12,vetor(R5)
			mov.b		R11,vetor(R6)
			call		#loop1

troca2:		mov.b		vetor(R6),R11
			mov.b		vetor(R7),R12
			mov.b		R12,vetor(R6)
			mov.b		R11,vetor(R7)
			call		#loop1

troca3:		mov.b		vetor(R7),R11
			mov.b		vetor(R8),R12
			mov.b		R12,vetor(R7)
			mov.b		R11,vetor(R8)
			call		#loop1

troca4:		mov.b		vetor(R8),R11
			mov.b		vetor(R9),R12
			mov.b		R12,vetor(R8)
			mov.b		R11,vetor(R9)
			call		#loop1

troca5:		mov.b		vetor(R9),R11
			mov.b		vetor(R10),R12
			mov.b		R12,vetor(R9)
			mov.b		R11,vetor(R10)
			call		#loop1

;''''''''''''''''''''''' SEGUNDA PARTE DO PROGRAMA ''''''''''''''''''''''''''''
P2:			mov.b		#vetor,R5
			mov.b		#7,R5
			mov.b		#8,R6
			mov.b		#9,R7
			mov.b		#10,R8
			mov.b		#11,R9
			mov.b		#12,R10
			mov.b		#3,R13
			call		#loop2

;''''''''''''''''''''''' SEGUNDA PARTE DA ORDENAÇÃO ''''''''''''''''''''''''''''
loop2:		cmp.b		vetor(R5),vetor(R6)
			jhs			troca6
			cmp.b		vetor(R6),vetor(R7)
			jhs			troca7
			cmp.b		vetor(R7),vetor(R8)
			jhs			troca8
			cmp.b		vetor(R8),vetor(R9)
			jhs			troca9
			cmp.b		vetor(R9),vetor(R10)
			jhs			troca10
			dec			R13
			jnz			loop2
			call		#P3


troca6:		mov.b		vetor(R5),R11
			mov.b		vetor(R6),R12
			mov.b		R12,vetor(R5)
			mov.b		R11,vetor(R6)
			call		#loop2

troca7:		mov.b		vetor(R6),R11
			mov.b		vetor(R7),R12
			mov.b		R12,vetor(R6)
			mov.b		R11,vetor(R7)
			call		#loop2

troca8:		mov.b		vetor(R7),R11
			mov.b		vetor(R8),R12
			mov.b		R12,vetor(R7)
			mov.b		R11,vetor(R8)
			call		#loop2

troca9:		mov.b		vetor(R8),R11
			mov.b		vetor(R9),R12
			mov.b		R12,vetor(R8)
			mov.b		R11,vetor(R9)
			call		#loop2

troca10:	mov.b		vetor(R9),R11
			mov.b		vetor(R10),R12
			mov.b		R12,vetor(R9)
			mov.b		R11,vetor(R10)
			call		#loop2


;''''''''''''''''''''''' TERCEIRA PARTE DO PROGRAMA ''''''''''''''''''''''''''''
P3:			mov.b		#vetor,R5
			mov.b		#4,R5
			mov.b		#5,R6
			mov.b		#6,R7
			mov.b		#7,R8
			mov.b		#8,R9
			mov.b		#9,R10
			mov.b		#3,R13
			call		#loop3

;''''''''''''''''''''''' TERCEIRA PARTE DA ORDENAÇÃO ''''''''''''''''''''''''''''
loop3:		cmp.b		vetor(R5),vetor(R6)
			jhs			troca11
			cmp.b		vetor(R6),vetor(R7)
			jhs			troca12
			cmp.b		vetor(R7),vetor(R8)
			jhs			troca13
			cmp.b		vetor(R8),vetor(R9)
			jhs			troca14
			cmp.b		vetor(R9),vetor(R10)
			jhs			troca15
			dec			R13
			jnz			loop3
			call		#P4


troca11:	mov.b		vetor(R5),R11
			mov.b		vetor(R6),R12
			mov.b		R12,vetor(R5)
			mov.b		R11,vetor(R6)
			call		#loop3

troca12:	mov.b		vetor(R6),R11
			mov.b		vetor(R7),R12
			mov.b		R12,vetor(R6)
			mov.b		R11,vetor(R7)
			call		#loop3

troca13:	mov.b		vetor(R7),R11
			mov.b		vetor(R8),R12
			mov.b		R12,vetor(R7)
			mov.b		R11,vetor(R8)
			call		#loop3

troca14:	mov.b		vetor(R8),R11
			mov.b		vetor(R9),R12
			mov.b		R12,vetor(R8)
			mov.b		R11,vetor(R9)
			call		#loop3

troca15:	mov.b		vetor(R9),R11
			mov.b		vetor(R10),R12
			mov.b		R12,vetor(R9)
			mov.b		R11,vetor(R10)
			call		#loop3


;''''''''''''''''''''''' QUARTA PARTE DO PROGRAMA ''''''''''''''''''''''''''''
P4:			mov.b		#vetor,R5
			mov.b		#7,R5
			mov.b		#8,R6
			mov.b		#9,R7
			mov.b		#10,R8
			mov.b		#11,R9
			mov.b		#12,R10
			mov.b		#3,R13
			call		#loop4

loop4:		cmp.b		vetor(R5),vetor(R6)
			jhs			trocaa
			cmp.b		vetor(R6),vetor(R7)
			jhs			trocab
			cmp.b		vetor(R7),vetor(R8)
			jhs			trocac
			cmp.b		vetor(R8),vetor(R9)
			jhs			trocad
			cmp.b		vetor(R9),vetor(R10)
			jhs			trocae
			dec			R13
			jnz			loop4
			jmp			$


trocaa:		mov.b		vetor(R5),R11
			mov.b		vetor(R6),R12
			mov.b		R12,vetor(R5)
			mov.b		R11,vetor(R6)
			call		#loop4

trocab:		mov.b		vetor(R6),R11
			mov.b		vetor(R7),R12
			mov.b		R12,vetor(R6)
			mov.b		R11,vetor(R7)
			call		#loop4

trocac:		mov.b		vetor(R7),R11
			mov.b		vetor(R8),R12
			mov.b		R12,vetor(R7)
			mov.b		R11,vetor(R8)
			call		#loop4

trocad:		mov.b		vetor(R8),R11
			mov.b		vetor(R9),R12
			mov.b		R12,vetor(R8)
			mov.b		R11,vetor(R9)
			call		#loop4

trocae:		mov.b		vetor(R9),R11
			mov.b		vetor(R10),R12
			mov.b		R12,vetor(R9)
			mov.b		R11,vetor(R10)
			call		#loop4


            .data
vetor:		.byte		12,"DANYELMORAIS"
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
            
