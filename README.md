# PROJETO-CE4411
Projeto da disciplina Arquitetura de Computadores

Tema: Jogo de memorização de LEDs acendidos

Projeto realizado por:

Orlando Nagrockis Bertholdo RA: 24.223.003-5

Lorenzo Colonnese Chigancas RA: 24.223.085-2


# DESCRIÇÂO

Apos o usuario começar o jogo uma sequencia de LEDs ira acender, o jogador então devera acertar corretamente a ordem e os LEDs acendidos. 

Caso o jogador acerte ele poderá colocar um nome para ser salvo junto com o seu tempo para acertar, ambos aparecerão no monitor serial como um score. 

Se ele errar ele recomeçará com uma nova sequencia de LEDs sendo acendida.

O jogador possui três chances, caso não consigo irá aparecer uma mensagem de game over e o jogo deverá ser iniciado denovo.

# FUNCIONAMENTO DO CÓDIGO

Registradores:

- R2 -> tamanho da sequência do jogador

- R3 -> tamanho da sequência aleatória gerada

- R6 -> contador para comparação entre as duas sequências

- R0 -> local para armazenar sequência aleatória

- R1 -> local para armazenar sequência do jogador

- R7 -> número de vidas

- R4 e R5 -> utilizados para DELAY

Funcionamento:

- O programa começa no INICIO onde o timer e as portas são setadas
  
- Após o botão P2.0 for pressionado ele chama a sub-rotina COMECANDO onde os registradores recebem os valores para suas funções
  
- Após o botão P2.0 for solto ele chama a sub-rotina SEQ_LED onde será gerado e mostrado uma sequencia de cinco LEDs aleatória

- A sequência aleatória é armazenada na memória 30H

- Cada LEDs que acender decrementa o R3, a sequência continua até R3 chegar em 0

- Apos a sequência terminar, a sub-rotina SEQ_JOGADOR é chamada, onde o jogador utiliza os botões para fazer a sua sequência de LEDs que deve ser igual a sequência aleatória mostrada anteriormente

- A cada botão que o jogador pressiona o R2 é decrementado

- A sequência do jogador é armazenada na memória 40H

- Quando R2 chegar a 0 a sub-rotina PRE_VERIFICAR é chamada, para que R0 e R1 voltem para 30H e 40H para começar a verificação do inicio de ambas sequências

- Então é feita a verificação na sub-rotina VERIFICAR onde cada elemento de ambas sequências são comparados, caso alguma dê diferente ele chamada a sub-rotina ERROU, caso nenhuma diferença seja encontrada ele chama a sub-rotina ACERTOU

- Caso ele vá para ERROU a mensagem "errou" aparecerá no monitor serial e o R7 será decrementado para tirar uma vida, caso ele vá para ACERTOU a mensagem "acertou" aparecerá no monitor serial

- Caso o R7 esteja em 0 aparecerá "game over" no monitor serial e o jogo precisa ser reiniciado

- Se ele acertar ele poderá colocar o seu nome na entrada do serial e então dar SEND para aparecer o nick no monitor serial junto a sua pontuação

  # VÍDEO DO FUNCIONAMENTO
