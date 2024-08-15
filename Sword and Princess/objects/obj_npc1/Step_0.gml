/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

if (instance_exists(obj_dialogo)) {
	if (obj_dialogo.pagina >= array_length(obj_dialogo.texto) - 1) {
		instance_destroy();
		audio_play_sound(snd_porta, 9, false, 1, 3);	
		global.dialogo1_jafoi = true;
	}
}

if (obj_player.x > x) {
	xscale = 1; 
} else {
    xscale = -1; 
}