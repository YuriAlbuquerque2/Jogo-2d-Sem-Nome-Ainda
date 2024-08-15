/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

draw_set_font(fnt_menu);  // Defina a fonte que você quer usar para os créditos
draw_set_color(c_white);  // Define a cor do texto

// Desenha cada texto do array de créditos, subindo da parte de baixo para cima
var _y_offset = 0;

for (var _i = 0; _i < array_length(creditos); _i++) {
    draw_text(((display_get_width() - string_width(creditos[_i])) / 2) - 200, creditos_y + _y_offset, creditos[_i]);
    _y_offset += string_height(creditos[_i]) + 10; // Incrementa a posição vertical para o próximo texto
}
