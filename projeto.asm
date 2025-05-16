	ORG 0000H
	LJMP INICIO	
	ORG 0100H

INICIO:
	MOV TMOD, #01H ;temporizador 0 no modo 1
	MOV TH0, #0 ;zera o TH0
	MOV TL0, #0 ;zera o TL0
    SETB TR0 ;inicia o Timer 0
	JB P2.0, INICIO	;se P2.0 estiver solto continua no INICIO
	ACALL COMECANDO ;senão vai para a rotina COMECANDO para inicar jogo

COMECANDO:
	MOV R2, #5 ;tamanho da sequência do jogador
	MOV R3, #5 ;tamanho da sequência de LEDs gerada
	MOV R6, #5 ;contador para verificação
	MOV R0, #50H ;local para armazenar a sequência aleatória
	MOV R1, #60H ;local para armazenar a sequência do jogador
	MOV R7, #3 ;vidas e pontuação
	JNB P2.0, COMECANDO ;enquanto botão P2.0 não for solto continua no COMECANDO
	ACALL SEQ_LED ;senão vai para a rotina da seq de LEDs aleatória
	RET
	
SEQ_LED:
	MOV A, TH0
    XRL A, TL0 ;XOR entre TH0 e TL0 para gerar aleatoriedade    
    ANL A, #00000111B ;mantém apenas os 3 bits menos significativos
	MOV @R0, A ;armazena o número aleatório
	INC R0 ;avança na memória
	MOV B, A
	MOV A, #00000001B ;começa com o bit 0
RANDOMIZAR:
	RL A ;roda A para esquerda
    DJNZ B, RANDOMIZAR ;repete até chegar no LED aleatório
    CPL A ;inverte os bits para acender apenas um LED
    MOV P1, A ;Mostra o LED acendido
    MOV R4, #4
    ACALL DELAY ;chama delay
    MOV P1, #11111111B ;apaga todos os LEDs
    MOV R4, #4
    ACALL DELAY ;chama delay
    DJNZ R3, SEQ_LED ;gera o proximo LED da sequência até R3 chegar em 0
    JMP SEQ_JOGADOR ;apos finalizar a seq vai para a vez do jogador
	
SEQ_JOGADOR:
	JNB P2.0, LED_BOTAO_0;verifica qual botão pressionado e liga o LED correspondente
    JNB P2.1, LED_BOTAO_1
	JNB P2.2, LED_BOTAO_2
	JNB P2.3, LED_BOTAO_3
	JNB P2.4, LED_BOTAO_4
	JNB P2.5, LED_BOTAO_5
	JNB P2.6, LED_BOTAO_6
	JNB P2.7, LED_BOTAO_7  
	MOV A, R2
	JNZ SEQ_JOGADOR ;enquanto R2 não for 0 continua na seq jogador
	JMP PRE_VERIFICAR ;verificar se acertou

DELAY: ;delay
	
NEXT:
	MOV R5, #255
AGAIN:
	DJNZ R5, AGAIN
	DJNZ R4, NEXT
	RET

LED_BOTAO_0:
	MOV P1, P2 ;liga LED correspondente ao botão
	JNB P2.0, LED_BOTAO_0 ;espera soltar
	DEC R2 ;diminui vezes que jogador pode pressionar botão
	MOV A, #0
	MOV @R1, A ;armazena LED do jogador na memória
	INC R1 ;avança na memória
	ACALL SEQ_JOGADOR ;volta para jogador poder pressionar proximo botão
LED_BOTAO_1:
	MOV P1, P2 ;liga LED correspondente ao botão
	JNB P2.1, LED_BOTAO_1  ;espera soltar
	DEC R2 ;diminui vezes que jogador pode pressionar botão
	MOV A, #1
	MOV @R1, A ;armazena LED do jogador na memória
	INC R1
	ACALL SEQ_JOGADOR
LED_BOTAO_2:
	MOV P1, P2 ;liga LED correspondente ao botão
	JNB P2.2, LED_BOTAO_2  ;espera soltar
	DEC R2 ;diminui vezes que jogador pode pressionar botão
	MOV A, #2
	MOV @R1, A  ;armazena LED do jogador na memória
	INC R1
	ACALL SEQ_JOGADOR
LED_BOTAO_3:
	MOV P1, P2 ;liga LED correspondente ao botão
	JNB P2.3, LED_BOTAO_3  ;espera soltar
	DEC R2 ;diminui vezes que jogador pode pressionar botão
	MOV A, #3
	MOV @R1, A  ;armazena LED do jogador na memória
	INC R1
	ACALL SEQ_JOGADOR
LED_BOTAO_4:
	MOV P1, P2 ;liga LED correspondente ao botão
	JNB P2.4, LED_BOTAO_4  ;espera soltar
	DEC R2 ;diminui vezes que jogador pode pressionar botão
	MOV A, #4
	MOV @R1, A  ;armazena LED do jogador na memória
	INC R1
	ACALL SEQ_JOGADOR
LED_BOTAO_5:
	MOV P1, P2 ;liga LED correspondente ao botão
	JNB P2.5, LED_BOTAO_5  ;espera soltar
	DEC R2 ;diminui vezes que jogador pode pressionar botão
	MOV A, #5
	MOV @R1, A  ;armazena LED do jogador na memória
	INC R1
	ACALL SEQ_JOGADOR
LED_BOTAO_6:
	MOV P1, P2 ;liga LED correspondente ao botão
	JNB P2.6, LED_BOTAO_6  ;espera soltar
	DEC R2 ;diminui vezes que jogador pode pressionar botão
	MOV A, #6
	MOV @R1, A  ;armazena LED do jogador na memória
	INC R1
	ACALL SEQ_JOGADOR
LED_BOTAO_7:
	MOV P1, P2 ;liga LED correspondente ao botão
	JNB P2.7, LED_BOTAO_7  ;espera soltar
	DEC R2 ;diminui vezes que jogador pode pressionar botão
	MOV A, #7
	MOV @R1, A  ;armazena LED do jogador na memória
	INC R1
	ACALL SEQ_JOGADOR

PRE_VERIFICAR:
	MOV R0, #50H ;volta para o começo da seq aleatoria na memoria
	MOV R1, #60H ;volta para o começo da seq jogador na memoria
	JMP VERIFICAR

VERIFICAR:
	MOV A, @R0
	MOV B, @R1
	CJNE A, B, ERROU ;compara as duas sequências e manda para ERROU se estiverem diferentes
	INC R0 
	INC R1
	DJNZ R6, VERIFICAR ;continua verificando até ver as duas sequências inteiras
	JMP ACERTOU ;caso ele tenha acertado manda para ACERTOU

ACERTOU:
	ACALL SERIAL ;inicia o serial
	MOV A, #'A';escreve "ACERTOU" no serial
	ACALL LB
	MOV A, #'C'
	ACALL LB
	MOV A, #'E'
	ACALL LB
	MOV A, #'R'
	ACALL LB
	MOV A, #'T'
	ACALL LB
	MOV A, #'O'
	ACALL LB
	MOV A, #'U'
	ACALL LB
	ACALL PONTUACAO ;atualiza pontuação
	JMP NICKNAME ;chama para o usuario colocar o nickname

ERROU:
	DEC R7 ;perde uma vida
	MOV A, R7
	JZ GAME_OVER ;se não  tiver mais vidas da game over
	ACALL SERIAL ;inicia o serial
	MOV A, #'E' ;escreve "ERROU" no serial
	ACALL LB
	MOV A, #'R'
	ACALL LB
	MOV A, #'R'
	ACALL LB
	MOV A, #'O'
	ACALL LB
	MOV A, #'U'
	ACALL LB
	JMP RESTART ;se ainda tiver vidas tem uma nova tentativa

RESTART: ;volta os registrados para uma nova sequência do jogador
	MOV R2, #5
	MOV R6, #5
	MOV R1, #60H
	JMP SEQ_JOGADOR ;jogador tenta denovo

GAME_OVER:
	ACALL SERIAL ;escreve "GAMEOVER" no serial
	MOV A, #'G'
	ACALL LB
	MOV A, #'A'
	ACALL LB
	MOV A, #'M'
	ACALL LB
	MOV A, #'E'
	ACALL LB
	MOV A, #'O'
	ACALL LB
	MOV A, #'V'
	ACALL LB
	MOV A, #'E'
	ACALL LB
	MOV A, #'R'
	ACALL LB
	JMP INICIO ;jogo recomeça

SERIAL: ;inicializa o serial
	MOV SCON, #50h  ;modo 1 para habilitar recepção
	MOV PCON, #80h
	MOV TMOD, #20h 
	MOV TH1, #243 
	MOV TL1, #243
	SETB TR1 ;inicia Timer 1

LB:
	MOV SBUF, A ;envia caracter A
LB1:
	JNB TI, LB1 ;espera terminar o envio
	CLR TI 
	RET

NICKNAME:
 	ACALL SERIAL ;inicia o serial     

LB2:
    JNB RI, LB2  
    CLR RI            
    MOV A, SBUF        
	CJNE A, #0DH, LB3 ;enquanto não der SEND ele continua no looping
	MOV A, #'-'  
    ACALL LB
	MOV A, #'>'  
    ACALL LB
	MOV A, 70H ;mostra pontuação no serial
	ADD A, #30H ;converge hexadecimal para ASCII
	ACALL LB
    JMP INICIO           
LB3:
	ACALL LB
	JMP LB2 ;continua lendo o nickname

PONTUACAO:
	MOV A, 70H
	ADD A, R7 ;soma a pontução desse round com a pontuação já existente
	MOV 70H, A ;atualiza pontuação na memória
	RET
