if (checar_save) {
    // Desenhar o quadrado azul com a mensagem sobre o save
   draw_set_font(fnt_menu);
	

	var _larg = display_get_gui_width();
	var _alt = display_get_gui_height();
	var _box_width = 700;
	var _box_height = 290;
	var _box_x = (_larg - _box_width) / 2;
	var _box_y = (_alt - _box_height) / 2;

	draw_set_color(c_black);
	draw_rectangle(_box_x, _box_y, _box_x + _box_width, _box_y + _box_height, false);

	draw_set_color(c_white);
	var _texto = "Seu último save será apagado,";
	draw_text(_box_x + 20, _box_y + 20, _texto);
	draw_text(_box_x + 20, _box_y + 70, "deseja prosseguir?");

	var _espaco_y = string_height("I") + 16;
	var _inicio_opcoes_y = _box_y + 20 + string_height(_texto) + 82; // Adiciona 82 de espaço entre o texto e as opções
	for (var _i = 0; _i < array_length(apagar_save_opcoes); _i++) {
		var _cor = c_white;
		if (checar_save_sel == _i) {
			_cor = c_yellow;
		}
		draw_text_color(_box_x + 20, _inicio_opcoes_y + (_i * _espaco_y), apagar_save_opcoes[_i], _cor, _cor, _cor, _cor, 1);
	}

	draw_set_font(-1);
	draw_set_color(-1);
    }
 else if (tutorial) {
	draw_set_font(fnt_menu);
	

	var _larg = display_get_gui_width();
	var _alt = display_get_gui_height();
	var _box_width = 670;
	var _box_height = 240;
	var _box_x = (_larg - _box_width) / 2;
	var _box_y = (_alt - _box_height) / 2;

	draw_set_color(c_black);
	draw_rectangle(_box_x, _box_y, _box_x + _box_width, _box_y + _box_height, false);

	draw_set_color(c_white);
	var _texto = "Você deseja fazer o tutorial?";
	draw_text(_box_x + 20, _box_y + 20, _texto);

	var _espaco_y = string_height("I") + 16;
	var _inicio_opcoes_y = _box_y + 20 + string_height(_texto) + 32; // Adiciona 32 de espaço entre o texto e as opções
	for (var _i = 0; _i < array_length(tutorial_opcoes); _i++) {
		var _cor = c_white;
		if (tutorial_sel == _i) {
			_cor = c_yellow;
		}
		draw_text_color(_box_x + 20, _inicio_opcoes_y + (_i * _espaco_y), tutorial_opcoes[_i], _cor, _cor, _cor, _cor, 1);
	}

	draw_set_font(-1);
	draw_set_color(-1);
} else if (confirmar_saida) {
	draw_set_font(fnt_menu);
	

	var _larg = display_get_gui_width();
	var _alt = display_get_gui_height();
	var _box_width = 670;
	var _box_height = 240;
	var _box_x = (_larg - _box_width) / 2;
	var _box_y = (_alt - _box_height) / 2;

	draw_set_color(c_black);
	draw_rectangle(_box_x, _box_y, _box_x + _box_width, _box_y + _box_height, false);

	draw_set_color(c_white);
	var _texto = "Deseja sair do jogo?";
	draw_text(_box_x + 20, _box_y + 20, _texto);

	var _espaco_y = string_height("I") + 16;
	var _inicio_opcoes_y = _box_y + 20 + string_height(_texto) + 32; // Adiciona 32 de espaço entre o texto e as opções
	var _opcoes_saida = ["Sim", "Não"];
	for (var _i = 0; _i < array_length(_opcoes_saida); _i++) {
		var _cor = c_white;
		if (saida_sel == _i) {
			_cor = c_yellow;
		}
		draw_text_color(_box_x + 20, _inicio_opcoes_y + (_i * _espaco_y), _opcoes_saida[_i], _cor, _cor, _cor, _cor, 1);
	}

	draw_set_font(-1);
	draw_set_color(-1);
} else {
	desenha_menu(menus[pag]);
}

if (transicao_ativa) {
	draw_set_color(make_color_rgb(0, 0, 0));
	draw_set_alpha(transicao_alpha);
	draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
	draw_set_alpha(1);
	draw_set_color(-1);
}


if (!global.carregando && chamou_sem_save) {
	sem_save();	
}