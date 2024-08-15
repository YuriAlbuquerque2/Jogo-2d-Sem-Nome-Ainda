if inicializar == false {
	scr_textos();
	inicializar = true;
}

if (keyboard_check_released(ord("E"))) {
	if (pagina < array_length(texto) - 1) {
		audio_play_sound(snd_confirma, 9, false);
		pagina++;	
	} else {
		global.dialogo = false;
		instance_destroy();	
	}
}