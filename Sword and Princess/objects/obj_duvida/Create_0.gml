// Array de arrays de textos, onde cada sub-array contém os textos que serão exibidos simultaneamente
textos = [
    ["Será que Guileon conseguiu salvar a princesa?"],
	["Cena dos próximos capítulos..."]
];
texto_index = 0; // Índice atual do array de textos sendo exibido

texto_posicao = 0; // Posição atual do texto que está sendo exibido
texto_velocidade = 0.08; // Velocidade com que o texto aparece (pode ajustar conforme necessário)
tempo_para_sumir = 180; // Tempo que o texto fica visível antes de começar a sumir (em frames)
transparencia = 1; // Transparência inicial (1 = totalmente opaco)
estado_texto = "aparecendo"; // Estado inicial do texto
