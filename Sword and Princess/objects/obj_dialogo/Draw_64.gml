/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

var _guiw = display_get_gui_width();
var _guih = display_get_gui_height();

var _xx = 100;
var	_yy = (_guih / _guih) + 200;
var _c = c_black;

 
	draw_rectangle_color(_xx, _yy, _guiw - 100, (_guih / _guih) + 400, _c, _c, _c, _c, false);
	draw_set_font(fnt_dialogos);
	draw_text_ext(_xx + 32, _yy + 32, texto[pagina], 32, _guiw - 64);

	if (npc_nome == "Aldeão 1" && pagina != 4) {
		draw_text(_xx + 32, _yy + 160, "- Aldeão");
		draw_text(_guiw - 450, _yy + 160, "Pressione E para continuar");
	} else if (npc_nome == "Aldeão 1" && pagina == 4) {
		draw_text(_xx + 32, _yy + 160, "- Guileon");
		draw_text(_guiw - 450, _yy + 160, "Pressione E para continuar");
	}

	if (npc_nome == "Troll" && pagina == 0) {
		draw_text(_xx + 32, _yy + 160, "- Guileon");
		draw_text(_guiw - 450, _yy + 160, "Pressione E para continuar");
	} else if (npc_nome == "Troll" && pagina == 1) {
		draw_text(_xx + 32, _yy + 160, "- Boss");
		draw_text(_guiw - 450, _yy + 160, "Pressione E para continuar");
	} else if (npc_nome == "Troll" && pagina == 2) {
		draw_text(_xx + 32, _yy + 160, "- Guileon");
		draw_text(_guiw - 450, _yy + 160, "Pressione E para continuar");
	} else if (npc_nome == "Troll" && pagina == 3) {
		draw_text(_xx + 32, _yy + 160, "- Boss");
		draw_text(_guiw - 450, _yy + 160, "Pressione E para continuar");
	}
	

	draw_set_font(-1);
