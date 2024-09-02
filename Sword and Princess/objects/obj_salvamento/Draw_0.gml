/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

draw_self();

if (distance_to_object(obj_player) < 32) {
	draw_set_color(c_lime);
	draw_set_font(fnt_normal);
	draw_text(x - 70, y - 100, "Aperte S para salvar");
	draw_set_font(-1);
	draw_set_color(-1);
}