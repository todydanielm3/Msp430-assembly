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
;Daniel Moraes da Silva - Engenharia de Computação UnB
;BubbleSort
;-------------------------------------------------------------------------------
BSort:		mov.b		#vetor,R5				;Inicia R5(registror) como indereco de memoria do vetor
			mov.b		#0,R10					;indicador de trocas>> Diz de depois de percorrer houve TROCAS
			mov.b		#11,R4					;tamanho do vetor + 1 >> parametro para percorrer o vetor
            mov.b		#0,R6					;inidice da esquerda inicia com 0
            mov.b		#1,R7					;indice da direiro inicia com 1
            call 		#perc					;subrotina para percorrer o vetor

perc:		dec			R4						;decrementa 1 do tamanho do vetor >> "quando for 0 significa q o vetor foi totalmente percorrido"
			jz			return					;se R4 = 0 -> ir para return
			cmp.b		vetor(R6),vetor(R7)		;compara o elemento do atual indice R7 com o atual indice de R6
			jlo			trocar					;se o elemento do indice R7 for menor -> ir para TROCAR//caso contrario, continua processo
			add.b		#1,R6					;desloca R6 uma casa para direita
			add.b		#1,R7					;desloca R7 uma casa para direita
			call		#perc					;volta a percorrer

trocar:		mov.b		vetor(R6),R8			;mover o elemento do indice R6 para R8
			mov.b		vetor(R7),R9			;mover o elemento do indice R7 para R9
			mov.b		R8,vetor(R7)			;movendo valor contido em R8 para o elemento do vetor de inidice R7
			mov.b		R9,vetor(R6)			;movendo valor contido em R9 para o elemento do vetor de inidice R6
			add.b		#1,R6					;desloca R6 uma casa para direita
			add.b		#1,R7					;desloca R7 uma casa para direita
			add.b		#1,R10					;adiciona 1 em R10 >>> CONTADOR DE TROCA
			call		#perc					;volta a percorrer o vetor

return:		mov.b		#11,R4					;restaura o parametro usado para percorrer o vetor
            mov.b		#0,R6					;restaura o indice R6
            mov.b		#1,R7					;restaura o indice R7
            sub.b    	R6,R10					;IDENTIFICAR SE HOUVE TROCA! subtrai o valor do contador de trocas R10
            jz			fim						;se for igual a zero não tem resto >> R10 = 0 = R6 logo o vetor está ordenado >> chama FIM
			clr			R10						;caso contrario >> limpa o indicador de trocas
            call 		#perc					;chama subrotina perc (percorrer) percorrer novamente

fim: 		jmp			$						;trava execução

vetor:		.data
			.byte		3,0,1,8,7,2,5,4,6,9		;declaração de elementos contidos no vetor

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
            
