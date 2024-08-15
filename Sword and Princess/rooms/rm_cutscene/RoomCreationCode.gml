if (audio_is_playing(snd_passo_grama_orc)) {
	audio_stop_sound(snd_passo_grama_orc);
	global.grama_orc = -1;
}

if (global.boss_morto) {
	room_goto(rm_cenario8);	
} else {
	instance_destroy(obj_player);	
}