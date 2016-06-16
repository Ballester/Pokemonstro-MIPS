.macro Exit
        li $v0, 10
        syscall
    .end_macro
    
.data
	buffer:.space 70000 #espaco relativo a 256 x 256
	filename:.asciiz "out.txt"
	
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
		li $a2, 100000000000 #numero maximo de caracteres
		syscall
		
#===========FECHANDO ARQUIVO LIDO========
		li $v0, 16 #codigo para fechar arquivo
		move $a0, $s0 #passa arquivo aberto
		syscall
		
    		#li $t1, 0
    		#li $t2, 4
    		#li $t3, 65536
	loop:
    		#lw $t4, buffer($t1)
		#sw $t4, buffer($t1)
    		#addu $t1, $t1, $t2
   		#bne $t1, $t3, loop  

   	 Exit
	
	
	
	
