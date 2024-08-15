/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

var _amount = (life / life_max) * lifebar_w //Formula
var _amount_fixed = (life_max / life_max) * lifebar_w //Formula fixa
var _amount_feedback = (life_feedback / life_max) * lifebar_w //Formula fixa
var _x1 = (view_w / 2) - (lifebar_w / 2) + 400;
var _y1 = (view_h / 2) - 230;
var _x2 = _x1 + _amount;
var _x2_fixed = _x1 + _amount_fixed;
var _x2_feedback = _x1 + _amount_feedback;
var _y2 = _y1 + lifebar_h;

if (life >= 0 && instance_exists(obj_inimigo_boss)) {
	//Nome
	draw_set_color(c_lime);
	draw_set_font(fnt_normal);
	draw_text(display_get_gui_width() / 2, (display_get_gui_height() / display_get_gui_height()) + 7, "BOSS");
	
	//Background
	draw_set_color(color2);
	draw_rectangle(_x1, _y1, _x2_fixed, _y2, false);
	
	//Feedback
	draw_set_color(c_white);
	draw_rectangle(_x1, _y1, _x2_feedback, _y2, false);
	
	//Desenhando a vida
	draw_set_color(color1);
	draw_rectangle(_x1, _y1, _x2, _y2, false);
	
	//Borda
	draw_set_color(c_black);
	draw_rectangle(_x1, _y1, _x2_fixed, _y2, true);
}

draw_set_font(-1);
draw_set_color(-1);