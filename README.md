# PROJETO-CE4411
Projeto da disciplina Arquitetura de Computadores

Tema: Jogo de memorização de LEDs acendidos


Apos o usuario começar o jogo uma sequencia de LEDs ira acender, o jogador então devera acertar corretamente a ordem e os LEDs acendidos. 

Caso o jogador acerte ele poderá colocar um nome para ser salvo junto com o seu tempo para acertar, ambos aparecerão no monitor serial como um score. 

Se ele errar ele recomeçará com uma nova sequencia de LEDs sendo acendida.

O jogador possui três chances, caso não consigo irá aparecer uma mensagem de game over e o jogo deverá ser iniciado denovo.

# FlUXOGRAMA

- O programa começa no INICIO onde o timer e as portas são setadas
  
- Após o botão P2.0 for pressionado ele chama a sub-rotina COMECANDO onde os registradores recebem os valores para suas funções
  
- Após o botão P2.0 for solto ele chama a sub-rotina SEQ_LED onde será gerado e mostrado uma sequencia de cinco LEDs aleatória

- Cada LEDs que acender decrementa o R3, a sequência continua até R3 chegar em 0

- Apos a sequência terminar, a sub-rotina SEQ_JOGADOR é chamada, onde o jogador utiliza os botões para fazer a sua sequência de LEDs que deve ser igual a sequência aleatória mostrada anteriormente

- 
