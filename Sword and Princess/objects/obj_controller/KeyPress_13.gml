/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
if (game_over) {
	global.game_over = -1;
	global.musica_de_jogo = -1;
	global.musica_boss = -1;
		if (file_exists("save.ini")) {
			instance_destroy(obj_player);
			game_over = false;
			sys_load("save.ini");
		} else {
			global.perm_dash = false;
			global.criar_npc1 = -1;
			global.orc_morreu1 = false;
			global.cobra_morreu1 = false;
			instance_destroy(obj_player);
			global.vida_atual = global.vida_max;
			game_over = false;
			room_goto(rm_cenario1);
			instance_create_layer(640, 520, layer, obj_player);
		}
	}