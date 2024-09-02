/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

if (pause_active) {
    draw_set_font(fnt_normal);
    var _larg = display_get_gui_width();
    var _alt = display_get_gui_height();
    var _box_width = 370;
    var _box_height = 200;
    var _box_x = (_larg - _box_width) / 2;
    var _box_y = (_alt - _box_height) / 2;

    // Desenhar fundo
    draw_set_alpha(.6);
    draw_rectangle_color(0, 0, _larg, _alt, c_black, c_black, c_black, c_black, 0);
    draw_set_alpha(1);
    draw_set_color(c_gray);
    draw_rectangle(_box_x, _box_y, _box_x + _box_width, _box_y + _box_height + 50, false);

    draw_set_color(c_white);
    var _espaco_y = 50;
    for (var _i = 0; _i < array_length(pause_options); _i++) {
        var _texto_opcao = pause_options[_i];
        if (_i == 2) {
            _texto_opcao += ": " + (control_type == 0 ? "Moderno" : "Clássico");
        }
        var _cor = (_i == pause_sel) ? c_yellow : c_white;
        draw_text_color(_box_x + 20, _box_y + 40 + (_i * _espaco_y), _texto_opcao, _cor, _cor, _cor, _cor, 1);
    }

    // Se estiver na confirmação de saída
    if (confirm_exit) {
        draw_set_color(c_gray);
        draw_rectangle(_box_x, _box_y, _box_x + _box_width, _box_y + _box_height + 50, false);
        draw_set_color(c_white);
        draw_text(_box_x + 20, _box_y + 20, "Deseja realmente sair do jogo?");

        var _opcoes_saida = ["Sim", "Não"];
        for (var _i = 0; _i < array_length(_opcoes_saida); _i++) {
            var _cor = (_i == confirm_sel) ? c_yellow : c_white;
            draw_text_color(_box_x + 20, _box_y + 80 + (_i * _espaco_y), _opcoes_saida[_i], _cor, _cor, _cor, _cor, 1);
        }
    }
    draw_set_font(-1);
    draw_set_color(-1);
}

if (show_no_save_message && !pause_active) {
    // Desenha a mensagem "Não existe jogo salvo!" em algum ponto da tela
    draw_set_font(fnt_menu);
	draw_set_alpha(.6);
	draw_rectangle_color(0, 0, display_get_gui_width(), display_get_gui_height(), c_black, c_black, c_black, c_black, 0);
	draw_set_alpha(1);
    draw_set_color(c_yellow);
    draw_text(display_get_gui_width() / 2 - 250, display_get_gui_height() / 2, "Não existe jogo salvo!");
    draw_set_font(-1);
    draw_set_color(-1);
}



if (room == rm_cutscene) {
	draw_set_font(fnt_normal)
	draw_set_color(c_white)

	var _larg = display_get_gui_width();
	var _alt = display_get_gui_height();

	draw_sprite(spr_enter_white, -1, _larg - 100, _alt - 50)
	draw_text(_larg - 70, _alt - 50, "Pular");

	draw_set_color(-1);
	draw_set_font(-1);
}


vida_player();
	
localizacao_player();