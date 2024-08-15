/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

if (room == rm_cenario3 || room == rm_cenario5 || room == rm_cenario6) {
	global.som_fogo++;	
} else {
	audio_stop_sound(snd_fogo);
	global.som_fogo = -1;	
}