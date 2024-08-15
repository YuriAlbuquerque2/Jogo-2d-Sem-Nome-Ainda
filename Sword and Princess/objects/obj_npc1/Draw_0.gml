/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

draw_self();

if (instance_exists(obj_npc1)) {
	if (distance_to_object(obj_player) <= 32) {
		draw_set_font(fnt_dialogos);
		draw_set_color(c_black);
		draw_text(x - 60, y - 80, "Aperte E para interagir");
		draw_set_color(-1);
		draw_set_font(-1);
	}
}