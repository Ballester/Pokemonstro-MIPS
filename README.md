# Pokemonstro-MIPS
Jogo baseado em uma batalha Pokémon para o MIPS

## Configuração bitmap simulator
Utilize o bitmap simulator do mars nas seguintes configurações:
* **Unit Width in Pixels:** 1
* **Unit Height in Pixels:** 1
* **Display Width in Pixels:** 256
* **Display Height in Pixels:** 256
* **Base address for display:** 0x10010000 (static data)

## Variáveis
* **s0** -- Pokemonstro escolhido do time A
* **s1** -- Pokemonstro escolhido do time B
* **s2** -- Vida atual do Pokemonstro A
* **s3** -- Ataque atual do Pokemonstro A
* **s4** -- Defesa atual do Pokemonstro A
* **s5** -- Vida atual do Pokemonstro B
* **s6** -- Ataque atual do Pokemonstro B
* **s7** -- Defesa atual do Pokemonstro B

## Espaços de Memória
* **buffer** -- Espaco reservado para a imagem sendo mostrada
* **filename** -- Imagem sendo carregada
* **jogar** -- String que imprime menu
* **selectPokemonA** -- String que imprime a seleção de pokemon do time A
* **selectPokemonB** -- String que imprime a seleção de pokemon do time B
* **bodybuilder_info** -- Vetor de inteiros contendo: Vida, Ataque e Defesa do Pokemonstro Bodybuilder
* **gosmon_info** -- Vetor de inteiros contendo: Vida, Ataque e Defesa do Pokemonstro Gosmon
* **polidori_info** -- Vetor de inteiros contendo: Vida, Ataque e Defesa do Pokemonstro Polidori
* **xumaufuss_info** -- Vetor de inteiros contendo: Vida, Ataque e Defesa do Pokemonstro Xumaufuss
* **printAuxiliarHPA** -- String auxiliar avisando que o time A venceu
* **printAuxiliarHPB** -- String auxiliar avisando que o time B venceu
* **printAuxiliarBarraN** -- String auxiliar que printa \n

## Métodos
* **leImagem**: void
> O parâmetro é enviado através de $a0 decidindo qual arquivo será aberto. O retorno se dá pela troca da imagem no bitmap display.
> O parâmetro $a1 é utilizado em caso de imagens de habilidade. Se $a1 = 0, a habilidade é do timeA, se não é do timeB.
* $a0 = 0: Imagem de abertura Bodybuilder x Gosmon
* $a0 = 1: Imagem de abertura Bodybuilder x Xumaufuss
* $a0 = 2: Imagem de abertura Polidori x Gosmon
* $a0 = 3: Imagem de abertura Polidori x Xumaufuss
* $a0 = 4: Imagem de habilidade 1 Bodybuilder x Gosmon
* $a0 = 5: Imagem de habilidade 2 Bodybuilder x Gosmon 
* $a0 = 6: Imagem de habilidade 1 Bodybuilder x Xumaufuss
* $a0 = 7: Imagem de habilidade 2 Bodybuilder x Xumaufuss
* $a0 = 8: Imagem de habilidade 1 Polidori x Gosmon
* $a0 = 9: Imagem de habilidade 2 Polidori x Gosmon
* $a0 = 10: Imagem de habilidade 1 Polidori x Xumaufuss
* $a0 = 11: Imagem de habilidade 2 Polidori x Xumaufuss
---
* **escolheHabilidadeA**: int
> Retorna 1 ou 2 dependendo da habilidade escolhida para o time A.
---
* **escolheHabilidadeB**: int
> Retorna 1 ou 2 dependendo da habilidade escolhida para o time B.
---
* **loop_pokemonA**: void
> Função auxiliar para escolher o pokemonstro do time A.
---
* **loop_pokemonB**: void
> Função auxiliar para escolher o pokemonstro do time B.
---
* **carrega_pokemonA**: void
> Função auxiliar que carrega os dados do pokemonstro do time A escolhido da memória para os registradores.
---
* **carrega_pokemonB**: void
> Função auxiliar que carrega os dados do pokemonstro do time B escolhido da memória para os registradores.
---
* **executaHabilidadeA**: void
> Função auxiliar que executa a habilidade escolhida préviamente no método 'escolheHabilidadeA'. (Utiliza o valor que está em $a0, por isso deve ser utilizada em seguida da escolha).
---
* **executaHabilidadeB**: void
> Função auxiliar que executa a habilidade escolhida préviamente no método 'escolheHabilidadeB'. (Utiliza o valor que está em $a0, por isso deve ser utilizada em seguida da escolha).
---
* **printaEstadoAtual**: void
> Printa a HP atual dos dois pokemonstros.
---
* **vitoriaA**: void
> Printa uma mensagem de vitória do time A.
---
* **vitoriaB**: void
> Printa uma mensagem de vitória do time B.
---