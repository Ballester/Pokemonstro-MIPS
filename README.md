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

## Espacos de Memória
* **buffer** -- Espaco reservado para a imagem sendo mostrada
* **filename** -- Imagem sendo carregada
* **jogar** -- String que imprime menu
* **selectPokemonA** -- String que imprime a seleção de pokemon do time A
* **selectPokemonB** -- String que imprime a seleção de pokemon do time B
* **bodybuilder_info** -- Vetor de inteiros contendo: Vida, Ataque e Defesa do Pokemonstro Bodybuilder
* **gosmon_info** -- Vetor de inteiros contendo: Vida, Ataque e Defesa do Pokemonstro Gosmon
* **polidori_info** -- Vetor de inteiros contendo: Vida, Ataque e Defesa do Pokemonstro Polidori
* **xumaufuss_info** -- Vetor de inteiros contendo: Vida, Ataque e Defesa do Pokemonstro Xumaufuss