draw_set_font(fnt_normal)
draw_set_color(c_white)

var _larg = display_get_gui_width();
var _alt = display_get_gui_height();

draw_sprite(spr_enter_white, -1, _larg - 100, _alt - 50)
draw_text(_larg - 70, _alt - 50, "Pular");

// Define a fonte e a cor
draw_set_font(fnt_menu);
draw_set_color(c_white);

// Define a transparência
draw_set_alpha(transparencia);

var _y_offset = 0; // Offset vertical para posicionar os textos um abaixo do outro

// Desenha cada texto do array atual
for (var _i = 0; _i < array_length(textos[texto_index]); _i++) {
    // Pega o texto atual e copia até a posição atual (com floor para arredondar)
    var _texto_completo = textos[texto_index][_i];
    var _texto_parcial = string_copy(_texto_completo, 1, floor(texto_posicao));

    // Calcula largura e altura para centralizar o texto
    var _largura_texto = string_width(_texto_parcial);
    var _altura_texto = string_height(_texto_parcial);

    // Desenha o texto na tela
    draw_text(((display_get_width() - _largura_texto) / 2) - 280, ((display_get_height() - _altura_texto) / 2 + _y_offset) - 40, _texto_parcial);
    
    _y_offset += _altura_texto + 10; // Adiciona o espaço necessário para o próximo texto
}

// Restaura a opacidade para o restante dos desenhos
draw_set_alpha(1);
draw_set_font(-1);
draw_set_color(-1);

