/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

cutscene = -1;

action = 0;

timer = 0;

x_dest = -1;
y_dest = -1;

cutscene = [
	[cutscene_wait, 3],
	[cutscene_change_sprite, obj_guileon, spr_player_andando],
	[cutscene_move_character, obj_guileon, 720, 576, false, 3],
	[cutscene_change_sprite, obj_guileon, spr_player_idle],
	[cutscene_xscale, obj_troll],
	[cutscene_dialogo, "Troll"],	
	[cutscene_wait, 1],
	[cutscene_change_sprite, obj_troll, spr_boss_taunt],
	[cutscene_play_sound, snd_boss_taunt, false],
	[cutscene_wait, 5],
	[cutscene_destruir_dialogo],
	[cutscene_change_sprite, obj_troll, spr_boss_idle],
	[cutscene_wait, 2]
];