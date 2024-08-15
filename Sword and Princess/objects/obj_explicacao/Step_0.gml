// Faz os textos aparecerem aos poucos
if (estado_texto == "aparecendo") {
    texto_posicao += texto_velocidade;
    var _all_texts_done = true;
    var _max_length = 0;

    // Verifica se todos os textos do array atual já foram completamente exibidos
    for (var _i = 0; _i < array_length(textos[texto_index]); _i++) {
        var _texto_length = string_length(textos[texto_index][_i]);
        if (texto_posicao < _texto_length) {
            _all_texts_done = false;
        }
        // Calcula o comprimento máximo dos textos
        if (_texto_length > _max_length) {
            _max_length = _texto_length;
        }
    }

    // Se todos os textos foram completamente exibidos, muda para o estado "esperando"
    if (_all_texts_done) {
        texto_posicao = _max_length; // Garante que todos os textos sejam completamente exibidos
        estado_texto = "esperando";
    }
}

// Aguarda o tempo definido antes de começar a desaparecer
if (estado_texto == "esperando") {
    tempo_para_sumir--;
    if (tempo_para_sumir <= 0) {
        estado_texto = "sumindo";
    }
}

// Faz os textos sumirem aos poucos
if (estado_texto == "sumindo") {
    transparencia -= 0.01; // Reduz a transparência gradualmente
    if (transparencia <= 0) {
        // Verifica se há mais arrays de textos para exibir
        if (texto_index < array_length(textos) - 1) {
            texto_index++; // Avança para o próximo array de textos
            texto_posicao = 0; // Reinicia a posição dos textos
            transparencia = 1; // Restaura a transparência
            estado_texto = "aparecendo"; // Reinicia o estado
            tempo_para_sumir = 180; // Reinicia o tempo de espera
        } else {
			instance_destroy();
            room_goto(rm_cenario1); // Muda de room quando todos os textos tiverem sido exibidos
			instance_create_layer(640, 520, layer, obj_player);
        }
    }
}

if (room == rm_explicacao && keyboard_check_pressed(vk_enter)) {
		room_goto(rm_cenario1);
		instance_create_layer(640, 520, layer, obj_player);
}
