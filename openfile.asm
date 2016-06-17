.macro Exit
        li $v0, 10
        syscall
    .end_macro
    
.data
	buffer:.space 65536 #espaco relativo a 256 x 256
	filename:.asciiz "out.txt"
	selectPlayer:.asciiz "Selecione jogador!\n(1) TEAM BODYBUILDER\n(2) TEAM PSICODELIA\n(3) CANCELAR\n"
	
.text   
	main:

#============ABRINDO ARQUIVO PARA LEITURA======
		li $v0, 13 #codigo para abrir arquivo
		la $a0, filename #.asciiz referente ao novo do arquivo
		li $a1, 0 # flag, 0=read
		li $a2, 0 # mode, desconsiderado
		syscall
		move $s0, $v0 #arquivo aberto salvo em s0
		
#=============LENDO PARA O BUFFER========
		li $v0, 14 #codigo para ler do arquivo
		move $a0, $s0 #arquivo aberto
		la $a1, buffer #espaco reservado em memoria para o arquivo
		li $a2, 65536 #numero maximo de caracteres
		syscall
		
#===========FECHANDO ARQUIVO LIDO========
		li $v0, 16 #codigo para fechar arquivo
		move $a0, $s0 #passa arquivo aberto
		syscall
		
    		li $v0, 4
    		la $a0, selectPlayer
    		syscall
    		
    		li $v0, 5
    		syscall
    		

   	 Exit
	
	
	
	
