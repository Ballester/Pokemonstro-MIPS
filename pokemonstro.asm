.macro Exit
        li $v0, 10
        syscall
    .end_macro
    
.data
	buffer:.space 300000 #espaco relativo a 256 x 256
	filename:.asciiz "out.txt"
	
	jogar: .asciiz "Deseja jogar?\n(1) Jogar\n(2) Sair\n\n"
	selectPokemonA: .asciiz "Selecione Pokemonstro do Team Bodybuilder:\n(1) Bodybuilder\n(2) Polidori\n\n"
	selectPokemonB: .asciiz "Selecione Pokemonstro do Team CC:\n(1) Gosmon\n(2) Xumaufuss\n\n"
	
	bodybuilder_info: .word 20, 5, 3
	gosmon_info: .word 15, 5, 4
	polidori_info: .word 10, 8, 2
	xumaufuss_info: .word 10, 7, 3
	
	selectHabilidadeBodybuilder: .asciiz "Selecione a Habilidade do Bodybuilder:\n(1) Trapezera Buscando\n(2) Maluco Doente\n\n"
	selectHabilidadeGosmon: .asciiz "Selecione a Habilidade do Gosmon:\n(1) Atakotaku\n(2) Sleep\n\n"
	selectHabilidadePolidori: .asciiz "Selecione a Habilidade do Polidori:\n(1) Chama o Brets e Juliano\n(1) Rir\n\n"
	selectHabilidadeXumaufuss: .asciiz "Selecione a Habilidade do Xumaufuss:\n(1) Confusão\n(2) Confusão\n\n"
	
	vitoriaTimeA: .asciiz "Time Bodybuilder foi vencedor!\n\n"
	vitoriaTimeB: .asciiz "Time CC foi vencedor!\n\n"
	
	printAuxiliarHPA: .asciiz "\nHP atual do time A: "
	printAuxiliarHPB: .asciiz "\nHP atual do time B: " 
	printAuxiliarBarraN: .asciiz "\n\n"
	
	
	#======ABERTURAS=======
	bodybuilder_gosmon:.asciiz "abertura/bodybuilder_gosmon_mn.bmp"
	bodybuilder_xumaufuss:.asciiz "abertura/bodybuilder_xumaufuss_mn.bmp"
	polidori_gosmon:.asciiz "abertura/polidori_gosmon_mn.bmp"
	polidori_xumaufuss:.asciiz "abertura/polidori_xumaufuss_mn.bmp"
	
	#=====SKILLS======
	
	#bodybuilder- Maluco Doente:
	gosmon_maluco:.asciiz"skills/bodybuilder/gosmon_maluco_mno.bmp"
	xumaufuss_maluco:.asciiz"skills/bodybuilder/xumaufuss_maluco_mno.bmp"
	
	#bodybuilder- Trapezera buscando
	gosmon_trapezera:.asciiz"skills/bodybuilder/gosmon_trapezera_mno.bmp"
	xumaufuss_trapezera:.asciiz"skills/bodybuilder/xumaufuss_trapezera_mno.bmp"
	
	#gosmon- Animes
	bodybuilder_animes:.asciiz"skills/gosmon/bodybuilder_animes_mno.bmp"
	polidori_animes:.asciiz"skills/gosmon/polidori_animes_mno.bmp"
	
	#gosmon- Sleep
	bodybuilder_sleep:.asciiz"skills/gosmon/bodybuilder_sleep_mno.bmp"
	polidori_sleep:.asciiz"skills/gosmon/polidori_sleep_mno.bmp"
	
	#polidori- JuBrets
	gosmon_jubrets:.asciiz"skills/polidori/gosmon_jubrets_mno.bmp"
	xumaufuss_jubrets:.asciiz"skills/polidori/xumaufuss_jubrets_mno.bmp"
	
	#polidori- Rir
	gosmon_rir:.asciiz"skills/polidori/gosmon_jubrets_mno.bmp"
	xumaufuss_rir:.asciiz"skills/polidori/xumaufuss_jubrets_mno.bmp"
	
	#xumaufuss- Confusao
	bodybuilder_confusao:.asciiz"skills/xumaufuss/bodybuilder_confusao_mno.bmp"
	polidori_confusao:.asciiz"skills/xumaufuss/polidori_confusao_mno.bmp"
	
	#xumaufuss- NaoConfusao
	bodybuilder_naoconfusao:.asciiz"skills/xumaufuss/bodybuilder_naoconfusao_mno.bmp"
	polidori_naoconfusao:.asciiz"skills/xumaufuss/polidori_naoconfusao_mno.bmp"

	
	DEBUGGER: .asciiz "Gosmon?"
	
.text   
	main:
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
    		
    		#escolhe imagem de abertura
    		li $t8, 1
    		beq $t8, $s0, bodybuilder_abertura
    		nop
    		
    		beq $t8, $s1, polidori_gosmon_abertura
    		nop
    		
    		li $a0, 3
    		jal leImagem
    		nop
    		j loop_batalha
    		nop
    		
    		bodybuilder_abertura:
    			beq $t8, $s1, bodybuilder_gosmon_abertura
    			nop
    			
    			li $a0, 1
    			jal leImagem
    			nop
    			j loop_batalha
    			nop
    			
    			bodybuilder_gosmon_abertura:
    				li $a0, 0
    				jal leImagem
    				nop
    				j loop_batalha
    				nop
    		
    		polidori_gosmon_abertura:
    			li $a0, 2
    		
    			jal leImagem
    			nop
    			j loop_batalha
    			nop
    		
    		j loop_batalha
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
    		
    		blez $s5, vitoriaA #verifica se o pokemonstro foi derrotado
    		nop
    		
    		jal escolheHabilidadeB #retorno em a0
    		nop
    		
    		jal executaHabilidadeB
    		nop
    		
    		blez $s2, vitoriaB #verifica se o pokemonstro foi derrotado
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
    		lw $s5, 0($t1)
    		lw $s6, 4($t1)
    		lw $s7, 8($t1)
    		
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
    	    	li $t0, 2
    		#se for 1 é bodybuilder, se não for 1 é polidori
    		beq $s0, 1, bodybuilder_habilidades
    		nop
  

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
    	    	li $t0, 2
    		#se for 1 é gosmon, se não for 1 é xumaufuss
    		beq $s1, 1, gosmon_habilidades
    		nop
    		
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
    	    	sw $ra, 0($sp)
    		#se for 1 é bodybuilder, se não for 1 é polidori
    		li $t0, 1
    		beq $s0, $t0, bodybuilder_executa
    		nop
    		
    		polidori_executa:
    		
    			beq $a0, $t0, polidori_executa_1
    			nop
    			
    			polidori_executa_2:
    				
    				#Escolhe a imagem
    				beq $s1, $t0, poli_im_2_gosmon
    				nop
    				
    				poli_im_2_xumaufuss:
    					li $a0, 11
    					li $a1, 0
    					jal leImagem
    					nop
    					j out_poli_2
    					nop
    					
    				poli_im_2_gosmon:
    					li $a0, 9
    					li $a1, 0
    					jal leImagem
    					nop
    				
    				out_poli_2:
    				sub $s7, $s7, 5
    				
    				#troca endereco de retorno
    				lw $ra, 0($sp)
    				jr $ra
    				nop
    					
    			polidori_executa_1:
    				beq $s1, $t0, poli_im_1_gosmon
    				nop
    				
    				poli_im_1_xumaufuss:
    					li $a0, 10
    					li $a1, 0
    					jal leImagem
    					nop
    					j out_poli_1
    					nop
    					
    				poli_im_1_gosmon:
    					li $a0, 8
    					li $a1, 0
    					jal leImagem
    					nop
    				
    				out_poli_1:
    			 	sub $t0, $s7, $s3 #ataque menos defesa
    			 	add $s5, $s5, $t0 #diminui do hp
    			 	
    			 	lw $ra, 0($sp)
    			 	jr $ra
    				nop 
    			
    			
    		bodybuilder_executa:
    		
    			beq $a0, $t0, bodybuilder_executa_1
    			nop
    			
    			bodybuilder_executa_2:
    				
    				beq $s1, $t0, body_im_2_gosmon
    				nop
    				
    				body_im_2_xumaufuss:
    					li $a0, 7
    					li $a1, 0
    					jal leImagem
    					nop
    					j out_body_2
    					nop
    					
    				body_im_2_gosmon:
    					li $a0, 5
    					li $a1, 0
    					jal leImagem
    					nop
    					
    				out_body_2:
    				sub $s7, $s7, 3
    			
    				lw $ra, 0($sp)
    				jr $ra
    				nop
    				
    			bodybuilder_executa_1:
    			
    				beq $s1, $t0, body_im_1_gosmon
    				nop
    				
    				body_im_1_xumaufuss:
    					li $a0, 6
    					li $a1, 0
    					jal leImagem
    					nop
    					j out_body_1
    					nop
    					
    				body_im_1_gosmon:
    					li $a0, 4
    					li $a1, 0
    					jal leImagem
    					nop
    					j out_body_1
    					nop
    					
    				out_body_1:
    				sub $t0, $s7, $s3 #ataque menos defesa
    				add $s5, $s5, $t0 #diminui do hp
    			
    				lw $ra, 0($sp)
    				jr $ra
    				nop
    		
    	executaHabilidadeB:
    		sw $ra, 0($sp)
    		#se for 1 é gosmon, se não é xumaufuss
    		li $t0, 1
    		beq $s1, $t0, gosmon_executa
    		nop
    		
    		xumaufuss_executa:
    			
    			#gera numero aleatorio
    			li $v0, 42
    			li $a0, 1 #seed
    			li $a1, 101 #valor maximo
    			syscall
   				
 			li $t9, 50 #probabilidade de confusao
    			bgt $a0, $t9, confuso
    			nop
    			
    			not_confuso:
    				
    				beq $s0, $t0, xuma_im_2_body
    				nop
    				
    				xuma_im_2_poli:
    					li $a0, 11
    					li $a1, 1
    					jal leImagem
    					nop
    					j out_xuma_2
    					nop
    				
    				xuma_im_2_body:
    					li $a0, 7
    					li $a1, 1
    					jal leImagem
    					nop
    					
    				out_xuma_2:
    				lw $ra, 0($sp)
    				jr $ra
   				nop
    			
    			confuso:
    				beq $s0, $t0, xuma_im_1_body
    				nop
    				
    				xuma_im_1_poli:
    					li $a0, 10
    					li $a1, 1
    					jal leImagem
    					nop
    					j out_xuma_1
    					nop
    				
    				xuma_im_1_body:
    					li $a0, 6
    					li $a1, 1
    					jal leImagem
    					nop
    					
    				out_xuma_1:
    				#causa dano no oponente sem contar defesa
    				sub $s2, $s2, $s3
    			
    				lw $ra, 0($sp)
    				jr $ra
    				nop
    			
    				
    		gosmon_executa:
    			
    			beq $a0, $t0, gosmon_executa_1
    			nop
    			
    			gosmon_executa_2:
    				beq $s0, $t0, gosmon_im_2_body
    				nop
    				
    				gosmon_im_2_poli:
    					li $a0, 9
    					li $a1, 1
    					jal leImagem
    					nop
    					j out_gosmon_2
    					nop
    				
    				gosmon_im_2_body:
    					li $a0, 5
    					li $a1, 1
    					jal leImagem
    					nop

				out_gosmon_2:    			
    				addi $s5, $s5, 7
    				
    				lw $ra, 0($sp)
    				jr $ra
    				nop
    			
    			gosmon_executa_1:
    				beq $s0, $t0, gosmon_im_1_body
    				nop
    				
    				gosmon_im_1_poli:
    					li $a0, 8
    					li $a1, 1
    					jal leImagem
    					nop
    					j out_gosmon_1
    					nop
    					
    				gosmon_im_1_body:
    					li $a0, 4
    					li $a1, 1
    					jal leImagem
    					nop
    					
    				out_gosmon_1:
    				sub $t0, $s4, $s6 #ataque menos defesa
    				add $s2, $s2, $t0 #diminui do hp
    				
    				lw $ra, 0($sp)
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
    		move $t0, $zero
    		
    		bne $a1, $zero, otherTeam
    		nop
      		#escolhe o nome do arquivo
    		beq $a0, $t0, BBxGosmon
    		nop
    		addi $t0, $t0, 1
    		beq $a0, $t0, BBxXumas
    		nop
    		addi $t0, $t0, 1
    		beq $a0, $t0, PolixGosmon
    		nop
    		addi $t0, $t0, 1
    		beq $a0, $t0, PolixXumas
    		nop
    		addi $t0, $t0, 1
    		beq $a0, $t0, GosmonTrapezera
    		nop 
    		addi $t0, $t0, 1
    		beq $a0, $t0, GosmonMaluco
    		nop
    		addi $t0, $t0, 1
    		beq $a0, $t0, XumasTrapezera
    		nop
    		addi $t0, $t0, 1
    		beq $a0, $t0, XumasMaluco
    		nop
    		addi $t0, $t0, 1
    		beq $a0, $t0, GosmonJubrets
    		nop
    		addi $t0, $t0, 1
    		beq $a0, $t0, GosmonRir
    		nop
    		addi $t0, $t0, 1
    		beq $a0, $t0, XumasJubrets
    		nop
    		addi $t0, $t0, 1
       		beq $a0, $t0, XumasRir
       		nop
       		
       	otherTeam:
       		beq $a0, $t0, BBxGosmon
    		nop
    		addi $t0, $t0, 1
    		beq $a0, $t0, BBxXumas
    		nop
    		addi $t0, $t0, 1
    		beq $a0, $t0, PolixGosmon
    		nop
    		addi $t0, $t0, 1
    		beq $a0, $t0, PolixXumas
    		nop
    		addi $t0, $t0, 1
    		beq $a0, $t0, BBanimes
    		nop 
    		addi $t0, $t0, 1
    		beq $a0, $t0, BBsleep
    		nop
    		addi $t0, $t0, 1
    		beq $a0, $t0, BBconfuso
    		nop
    		addi $t0, $t0, 1
    		beq $a0, $t0, BBnaoconfuso
    		nop
    		addi $t0, $t0, 1
    		beq $a0, $t0, Polianimes
    		nop
    		addi $t0, $t0, 1
    		beq $a0, $t0, Polisleep
    		nop
    		addi $t0, $t0, 1
    		beq $a0, $t0, Policonfuso
    		nop
    		addi $t0, $t0, 1
       		beq $a0, $t0, Polinaoconfuso
       		nop
    		
    		BBxGosmon:
    			la $t1, bodybuilder_gosmon
    			j abre
    			nop
    			
    		BBxXumas:
    			la $t1, bodybuilder_xumaufuss
    			j abre
    			nop
    		
    		PolixGosmon:
    			la $t1, polidori_gosmon
    			j abre
    			nop
    		
    		PolixXumas:
    			la $t1, polidori_xumaufuss
    			j abre
    			nop
    			
    		GosmonMaluco:
    			la $t1, gosmon_maluco
    			j abre
    			nop
    			
    		XumasMaluco:
    			la $t1, xumaufuss_maluco
    			j abre
    			nop
    		
    		GosmonTrapezera:
    			la $t1, gosmon_trapezera
    			j abre
    			nop
    			
    		XumasTrapezera:
    			la $t1, xumaufuss_trapezera
    			j abre
    			nop
    			
    		GosmonJubrets:
    			la $t1, gosmon_jubrets
    			j abre
    			nop
    		
    		GosmonRir:
    			la $t1, gosmon_rir
    			j abre
    			nop
    			
    		XumasJubrets:
    			la $t1, xumaufuss_jubrets
    			j abre
    			nop
    		
    		XumasRir:
    			la $t1, xumaufuss_rir
    			j abre
    			nop
    			
    		BBanimes:
    			la $t1, bodybuilder_animes
    			j abre
    			nop
    		
    		BBsleep:
    			la $t1, bodybuilder_sleep
    			j abre
    			nop
    			
    		Polianimes:
    			la $t1, polidori_animes
    			j abre
    			nop
    			
    		Polisleep:
    			la $t1, polidori_sleep
    			j abre
    			nop
    			
    		BBconfuso:
    			la $t1, bodybuilder_confusao
    			j abre
    			nop
    			
    		BBnaoconfuso:
    			la $t1, bodybuilder_naoconfusao
    			j abre
    			nop
    			
    		Policonfuso:
    			la $t1, polidori_confusao
    			j abre
    			nop
    			
    		Polinaoconfuso:
    			la $t1, polidori_naoconfusao
    			j abre
    			nop
    				
    		abre:
			#abre um arquivo
			li   $v0, 13
			move $a0, $t1      #copiado o endereco antes setado por uma das condições
			li   $a1, 0        # abrindo para leitura
			li   $a2, 0
			syscall        
			move $t6, $v0      # salva o descritor 	
			tlti $v0, 0		#tratamento de excecao
			nop

			#le do arquivo
			li   $v0, 14
			move $a0, $t6     #descritor
			la   $a1, buffer   # buffer de leitura
			li   $a2, 300000     # tamanho do buffer
			syscall
			tlti $v0, 0	#tratamento de excecao
			nop

			#fecha o arquivo
			li   $v0, 16
			move $a0, $t6      # descritor
			syscall	
			
			jr $ra
			nop
	
	exit:
	 	nop
	
	
	
