.macro Exit
        li $v0, 10
        syscall
    .end_macro
    
.data
	buffer:.space 65536 #espaco relativo a 256 x 256
	filename:.asciiz "out.txt"
	
	jogar: .asciiz "Deseja jogar?\n(1) Jogar\n(2) Sair\n\n"
	selectPokemonA: .asciiz "Selecione Pokemonstro do Team Bodybuilder:\n(1) Bodybuilder\n(2) Polidori\n\n"
	selectPokemonB: .asciiz "Selecione Pokemonstro do Team CC:\n(1) Gosmon\n(2) Xumaufuss\n\n"
	
	bodybuilder_info: .word 20, 5, 3
	gosmon_info: .word 15, 5, 4
	polidori_info: .word 10, 8, 2
	xumaufuss_info: .word 10, 7, 3
	
	selectHabilidadeBodybuilder: .asciiz "Selecione a Habilidade do Bodybuilder:\n(1) Trapezera Buscando\n(2) Maluco Doente\n\n"
	selectHabilidadeGosmon: .asciiz "Selecione a Habilidade do Gosmon:\n(1) blablabla\n(2) blablabla\n\n"
	selectHabilidadePolidori: .asciiz "Selecione a Habilidade do Polidori:\n(1) blablabla\n(2) blablabla\n\n"
	selectHabilidadeXumaufuss: .asciiz "Selecione a Habilidade do Xumaufuss:\n(1) blablabla\n(2) blablabla\n\n"
	
	vitoriaTimeA: .asciiz "Time Bodybuilder foi vencedor!\n\n"
	vitoriaTimeB: .asciiz "Time CC foi vencedor!\n\n"
	
	printAuxiliarHPA: .asciiz "\nHP atual do time A: "
	printAuxiliarHPB: .asciiz "\nHP atual do time B: " 
	printAuxiliarBarraN: .asciiz "\n\n"
	
.text   
	main:
#============Menu=============#
		li $v0, 4
    		la $a0, jogar
    		syscall
    		
    		li $v0, 5
    		syscall
    		
    		li $t0, 2
    		bgt $v0, $t0, main #falha pois é maior que 2
    		nop
    		bltz $v0, main #falha pois é menor que 0
    		nop
    		
    		#valendo 2 para sair
    		beq $v0, $t0, exit
    		nop
    		
    		jal loop_pokemonA
    		nop
    		jal loop_pokemonB
    		nop
    		
    		#carrega valores time A
    		jal carrega_pokemonA
    		nop
    		
    		#carrega valores time B
    		jal carrega_pokemonB
    		nop
    		
    	loop_batalha:
    		jal printaEstadoAtual
    		nop
    	
    		jal escolheHabilidadeA #retorno em a0
    		nop
    		
    		jal executaHabilidadeA
    		nop
    		
    		jal printaEstadoAtual
    		nop
    		
    		blez $s5, vitoriaTimeA #verifica se o pokemonstro foi derrotado
    		nop
    		
    		jal escolheHabilidadeB #retorno em a0
    		nop
    		
    		jal executaHabilidadeB
    		nop
    		
    		blez $s2, vitoriaTimeB #verifica se o pokemonstro foi derrotado
    		nop
    		
    		j loop_batalha
    		nop	
		
	loop_pokemonA:
    		li $v0, 4
    		la $a0, selectPokemonA
    		syscall
    		
    		li $v0, 5
    		syscall
    		
    		li $t0, 2
    		bgt $v0, $t0, loop_pokemonA #falha pois é maior que 2
    		nop
    		bltz $v0, loop_pokemonA #falha pois é menor que 0
    		nop
    		
    		move $s0, $v0 #coloca o pokemon escolhido em s0
    		jr $ra
    		nop
    		
	loop_pokemonB:
    		li $v0, 4
    		la $a0, selectPokemonB
    		syscall
    		
    		li $v0, 5
    		syscall
    		
    		li $t0, 2
    		bgt $v0, $t0, loop_pokemonB
    		nop
    		bltz $v0, loop_pokemonB
    		nop
    		
    		move $s1, $v0 #coloca o pokemon escolhido em s1
    		jr $ra
    		nop
    		
    		
    	carrega_pokemonA:
    		#se for 1 é bodybuilder, se não for 1 é polidori
    		beq $s0, 1, bodybuilder_load
    		nop
    		
    		la $t1, polidori_info
    		
    		#carrega atributos
    		lw $s2, 0($t1)
    		lw $s3, 4($t1)
    		lw $s4, 8($t1)
    		
    		jr $ra
    		nop
    		
    		bodybuilder_load:
    			
    			la $t1, bodybuilder_info
    		
    			#carrega atributos
    			lw $s2, 0($t1)
    			lw $s3, 4($t1)
    			lw $s4, 8($t1)
    		
    			jr $ra
    			nop
    			
    	carrega_pokemonB:
    		#se for 1 é gosmon, se não for 1 é xumaufuss
    		beq $s1, 1, gosmon_load
    		nop
    		
    		la $t1, xumaufuss_info
    		
    		#carrega atributos
    		lw $s2, 0($t1)
    		lw $s3, 4($t1)
    		lw $s4, 8($t1)
    		
    		jr $ra
    		nop
    		
    		gosmon_load:
    			
    			la $t1, gosmon_info
    		
    			#carrega atributos
    			lw $s5, 0($t1)
    			lw $s6, 4($t1)
    			lw $s7, 8($t1)
    		
    			jr $ra
    			nop
    			
    	escolheHabilidadeA:
    		#se for 1 é bodybuilder, se não for 1 é polidori
    		beq $s0, 1, bodybuilder_habilidades
    		nop
    		
    		li $t0, 2
    		polidori_habilidades:
    			li $v0, 4
    			la $a0, selectHabilidadePolidori
    			syscall
    			
    			#pede habilidade
			li $v0, 5
			syscall
			
			blez $v0, polidori_habilidades
			nop
			bgt $v0, $t0, polidori_habilidades
			nop    			
    			
    			#copia para a0 caso seja 1 ou 2
    			move $a0, $v0
    			
    			jr $ra
    			nop
    		
    		bodybuilder_habilidades:
  			li $v0, 4
  			la $a0, selectHabilidadeBodybuilder
  			syscall
  			
  			#pede habilidade
  			li $v0, 5
  			syscall
  			
  			blez $v0, bodybuilder_habilidades
  			nop
  			bgt $v0, $t0, bodybuilder_habilidades
  			nop
  			
  			#copia para a0
  			move $a0, $v0
    			
    			jr $ra
    			nop
    		
    	escolheHabilidadeB:
    		#se for 1 é gosmon, se não for 1 é xumaufuss
    		beq $s1, 1, gosmon_habilidades
    		nop
    		
    		li $t0, 2
    		xumaufuss_habilidades:
    			li $v0, 4
    			la $a0, selectHabilidadeXumaufuss
    			syscall
    			
    			#pede habilidade
    			li $v0, 5
    			syscall
    			
    			blez $v0, xumaufuss_habilidades
    			nop
    			bgt $v0, $t0, xumaufuss_habilidades
    			nop
    			
    			#copia para a0
    			move $a0, $v0
    			
    			jr $ra
    			nop
    			
    		gosmon_habilidades:
    			li $v0, 4
    			la $a0, selectHabilidadeGosmon
    			syscall
    			
    			#pede habilidade
    			li $v0, 5
    			syscall
    			
    			blez $v0, gosmon_habilidades
    			nop
    			bgt $v0, $t0, gosmon_habilidades
    			nop
    			
    			#copia para a0 caso seja 0 < x < 3
    			move $a0, $v0
    			
    			jr $ra
    			nop
    			
    	
    	executaHabilidadeA:
    		#se for 1 é bodybuilder, se não for 1 é polidori
    		li $t0, 1
    		beq $s0, $t0, bodybuilder_executa
    		nop
    		
    		polidori_executa:
    		
    			#TODO CARREGAR A IMAGEM
    			beq $a0, $t0, polidori_executa_1
    			nop
    			
    			polidori_executa_2:
    				
    				#TODO habilidade
    				
    				jr $ra
    				nop
    					
    			polidori_executa_1:
    			 	sub $t0, $s4, $s7 #ataque menos defesa
    			 	add $s5, $s5, $t0 #diminui do hp
    			 	
    			 	jr $ra
    				nop 
    			
    			
    		bodybuilder_executa:
    		
    			beq $a0, $t0, bodybuilder_executa_1
    			nop
    			
    			bodybuilder_executa_2:
    			
    				#TODO habilidade
    			
    				jr $ra
    				nop
    				
    			bodybuilder_executa_1:
    				sub $t0, $s3, $s7 #ataque menos defesa
    				add $s5, $s5, $t0 #diminui do hp
    			
    				jr $ra
    				nop
    		
    	executaHabilidadeB:
    		#se for 1 é gosmon, se não é xumaufuss
    		li $t0, 1
    		beq $s0, $t0, gosmon_executa
    		nop
    		
    		xumaufuss_executa:
    			
    			beq $a0, $t0, xumaufuss_executa_1
    			nop
    			
    			xumaufuss_executa_2:
    				#TODO Habilidade
    				
    				jr $ra
    				nop
    			
    			xumaufuss_executa_1:
    				sub $t0, $s6, $s4 #ataque menos defesa
    				add $s2, $s2, $t0 #diminui do hp
    				
    				jr $ra
    				nop
    				
    		gosmon_executa:
    			
    			beq $a0, $t0, gosmon_executa_1
    			nop
    			
    			gosmon_executa_2:
    				#TODO Habilidade
    				
    				jr $ra
    				nop
    			
    			gosmon_executa_1:
    				sub $t0, $s6, $s4 #ataque menos defesa
    				add $s2, $s2, $t0 #diminui do hp
    				
    				jr $ra
    				nop
    				
    	
    	printaEstadoAtual:
    		li $v0, 4
    		la $a0, printAuxiliarHPA
    		syscall
    		
    		li $v0, 1
    		move $a0, $s2
    		syscall
    		
    		li $v0, 4
    		la $a0, printAuxiliarHPB
    		syscall
    	
    		li $v0, 1
    		move $a0, $s5
    		syscall
    		
    		li $v0, 4
    		la $a0, printAuxiliarBarraN
    		syscall
    		
		jr $ra
		nop
    		
    			
    	vitoriaA:
    		li $v0, 4
    		la $a0, vitoriaTimeA
    		syscall
    		
    		j main
    		nop
    		
    	vitoriaB:
    		li $v0, 4
    		la $a0, vitoriaTimeB
    		syscall
    		
    		j main
    		nop
    	
    	leImagem:
    		#escolhe o nome do arquivo
    		#beq $a0
    	
		#abre um arquivo
		li   $v0, 13

		li   $a1, 0        # abrindo para leitura
		li   $a2, 0
		syscall        
		move $t6, $v0      # salva o descritor 

		#le do arquivo
		li   $v0, 14
		move $a0, $t6     #descritor
		la   $a1, buffer   # buffer de leitura
		li   $a2, 65536     # tamanho do buffer
		syscall

		#fecha o arquivo
		li   $v0, 16
		move $a0, $s6      # descritor
		syscall	
	
	exit:
	 	nop
	
	
	
