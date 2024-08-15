/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

if (game_over) {
	global.vel_mult = .5;
	global.game_over++;
} else {
	global.vel_mult = 1;
}	

sons_do_jogo();

if (global.orc_morreu1 && global.cobra_morreu1) {
	global.criar_npc1++;
}

if (instance_exists(obj_dialogo) && room != rm_cutscene) {
	global.dialogo = true;	
}

if (global.criar_npc1 == 0) {
	if (!instance_exists(obj_npc1)) {
		audio_play_sound(snd_porta, 9, false, 1, 3);	
		instance_create_layer(928, 576, layer, obj_npc1);
	}
}

/*
if (keyboard_check(vk_up)) {
	game_over = true;	
} else {
	game_over = false;	
}
*/