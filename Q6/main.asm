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
; Questão 6
;-------------------------------------------------------------------------------
Q6:			mov.b		#texto,R5			;Inicia R5(registror) como indereco de memoria
			mov.b		#ind,R6				;Inicia R6(registror) como indereco de memoria
			mov.b		#num,R7				;Inicia R5(registror) como indereco de memoria
			mov.b		#8,R8				;Numero aux para representar o indice
			mov.b		#39h,R9				;Incluindo o codigo da tabela ASC no registrador 9 para fazer as devidas comparações
			call		#varrer				;chama a subrotina varrer

varrer:		dec			R8					;decrementa uma unidade do indice
			jz			FIM					;se indice R8 for igual a zero significa que ja varreu tudo >>chama FIM / se não continua
			cmp.b		texto(R8),R9		;compara R9(39h>>num 9 da tabela asc), com o indice representado por R8
			jhs			NUM					;se R9 for maior que atual indice (R8) significa possivel numero chama rotina NUM (numero)
			call		#IND				;se não for, segnifca que é o indice é maior q (39h) logo>> possivel letra>> chama rotina IND


NUM:		mov.b		texto(R8),num(R8)	;movoer conteudo do indice R8 no vetor texto para Conteudo do vetor num
			dec			R8					;decrementa o indice((tecnica para colocar "n" ao lado do elemente))
			mov.b		#6Eh,num(R8)		;coloca a letra "n" (6Eh da tabela ASC) ao lado da numero impresso
			add.b		#1,R8				;ajustando o indice onde estava para continuar a varreduro pelo vetor
			call		#varrer				;volta para a varredura

IND:		mov.b		texto(R8),ind(R8)	;movoer conteudo do indice R8 do vetor texto para Conteudo do vetor ind
			dec			R8					;decrementa o indice ((tecnica para colocar "i" ao lado do elemente))
			mov.b		#69h,ind(R8)		;coloca a letra "i" (6Eh da tabela ASC) ao lado da indentificador impresso
			add.b		#1,R8				;ajustando indice
			call		#varrer				;volta para a verredura

FIM:		jmp			$					;trava execuçã num laço infinito

                                            
			.data
texto:		.byte		7,"A 3456."			;definindo o tamanho e preenchenado com elementos na memoria que será tratado como um vetor (acesso 0x02400)

			.data
ind:		.byte		7,"0000000"			;definindo o tamanho do vetor e vazio para ser preenchido

			.data
num:		.byte		7,"0000000"			;"


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
            
