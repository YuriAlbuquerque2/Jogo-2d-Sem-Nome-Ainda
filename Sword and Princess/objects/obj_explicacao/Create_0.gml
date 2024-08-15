// Array de arrays de textos, onde cada sub-array contém os textos que serão exibidos simultaneamente
textos = [
    ["13 de agosto de 1424"],
    ["Neste dia, um reino distante foi", "atacado por uma gangue de monstros"],
	["Liderados por um ser mágico,", "eles levaram a princesa daquele reino"],
	["Ninguém do reino parecia ser", "capaz de salvá-la das mãos do mal"],
	["Mas um homem daquele reino era", "considerado diferente de todos"],
	["Seu nome era Guileon,", "e ele foi o escolhido para ir", "atrás da princesa sequestrada"],
	["Será que ele foi capaz de", "trazê-la de volta ao seu lar?"],
	["Sword", "and", "Princess"]
];
texto_index = 0; // Índice atual do array de textos sendo exibido

texto_posicao = 0; // Posição atual do texto que está sendo exibido
texto_velocidade = 0.08; // Velocidade com que o texto aparece (pode ajustar conforme necessário)
tempo_para_sumir = 180; // Tempo que o texto fica visível antes de começar a sumir (em frames)
transparencia = 1; // Transparência inicial (1 = totalmente opaco)
estado_texto = "aparecendo"; // Estado inicial do texto
