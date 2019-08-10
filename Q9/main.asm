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
; Questão 9
;Lista circular: inserir, deletar , procurar
;-------------------------------------------------------------------------------
Q9:			mov.b		#lista,R5			;Inicia R5(registror) como indereco de memoria
			mov.b		#0,R6				;inicio R6 = 0
			call		#inserir			;chamar inserir

pontInicio: mov.b		#0,R6				;"ponteiro" para referencia o inicio da lista
			ret								;retorna ultima atividade

inserir:	mov.b		#41h,lista(R6)		;Inserindo a letra A(41h em ASC) no primeiro elemeno da lista
			add.b		#1,R6				;desloca um indice para direita
			mov.b		#42h,lista(R6)		;|
			add.b		#1,R6				;|
			mov.b		#43h,lista(R6)		;|
			add.b		#1,R6				;|
			mov.b		#44h,lista(R6)		;|
			add.b		#1,R6				;|
			mov.b		#45h,lista(R6)		;||}> Segue a mesma logica
			add.b		#1,R6				;|
			mov.b		#46h,lista(R6)		;|
			add.b		#1,R6				;|
			mov.b		#47h,lista(R6)		;|
			add.b		#1,R6				;|
			mov.b		#48h,lista(R6)		;|
			add.b		#1,R6				;|
			call		#remover			;chamar remover

remover:	call		#pontInicio			;ultimo aponta para o primeiro>>primero >> chama rotina pontInicio para processar essa nova informacao
			mov.b		#0,lista(R6)		;removendo elemento
			add.b		#1,R6				;desloca indice para direita
			mov.b		#0,lista(R6)		;removendo elemento
			add.b		#1,R6				;desloca indice para direita
			mov.b		#0,lista(R6)		;removendo elemento
			add.b		#1,R6				;desloca indice para direita
			call		#pontInicio			;apontar para o inicio novamente
			call		#buscar				;chama rotina bucar

buscar:		mov.b		#45h,R7				;colocando em R7 o elemento que deseja procurar
			cmp.b		lista(R6),R7		;compara elemento que procura com elemento da lista
			jz			existe				;se se for igual  >>> chama rotina existe
			add.b		#1,R6				;se nao for igual continua >> desloca para direita
			call		#buscar				;volta para busca

existe:		jmp			$



			.data
lista: 		.byte		8,"00000000"		;lista circular de tamanho 8, vazia
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
            
