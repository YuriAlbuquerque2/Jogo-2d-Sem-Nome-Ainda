/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

// Inherit the parent event
event_inherited();

if (place_meeting(x, y, obj_tut_andar)) {
	draw_set_color(c_black);
	draw_set_font(fnt_dialogos);
	draw_text(x - 10, y - 80, "Segure A ou D para correr");
	draw_set_font(-1);
	draw_set_color(-1);
} 
if (keyboard_check_pressed(ord("A")) || keyboard_check_pressed(ord("D"))) {
	instance_destroy(obj_tut_andar);	
}

if (place_meeting(x, y, obj_tut_pular)) {
	draw_set_color(c_black);
	draw_set_font(fnt_dialogos);
	draw_text(x - 60, y - 80, "Aperte ESPAÇO para pular");
	draw_set_font(-1);
	draw_set_color(-1);
} 
if (keyboard_check_pressed(vk_space)) {
	instance_destroy(obj_tut_pular);	
}

if (place_meeting(x, y, obj_tut_atacar)) {
	draw_set_color(c_black);
	draw_set_font(fnt_dialogos);
	draw_text(x - 60, y - 80, "Aperte J para atacar");
	draw_set_font(-1);
	draw_set_color(-1);
}
 if (keyboard_check_pressed(ord("J"))) {
	instance_destroy(obj_tut_atacar);	
}

var _velh = sign(velh);
if (place_meeting(x + _velh, y, obj_item_dash)) {
	draw_set_color(c_lime)
	draw_set_font(fnt_dialogos);
	draw_text(x - 100, y - 100, "Você desbloqueou o Dash!");
	draw_text(x - 60, y - 80, "Aperte F para usar");
	draw_set_font(-1);
	draw_set_color(-1);
}

if (timer > 0) {
    draw_set_font(fnt_dialogos);
    draw_set_color(c_fuchsia);
    draw_text(x - 80, y - 80, "- Jogo salvo com sucesso!");
    timer -= 1; // Decrementa o timer
	draw_set_color(-1);
	draw_set_font(-1);
}

if (place_meeting(x, y, obj_sensor_manual)) {
	draw_set_color(c_black);
	draw_set_font(fnt_dialogos);
	draw_text(x - 60, y - 80, "Aperte E para entrar");
	draw_set_font(-1);
	draw_set_color(-1);
}

