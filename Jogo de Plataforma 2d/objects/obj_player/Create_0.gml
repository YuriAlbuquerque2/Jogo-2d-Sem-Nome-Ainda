/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

velh = 0;
velv = 0;
vel = 5;
grav = .3;
vel_jump = 8;

posso_perder_vida = true;
dano = false;
tempo_dano = room_speed * 0.5;
timer_dano = 0;

tempo_reinicia = room_speed * 2;
timer_reinicia = tempo_reinicia;

inv_tempo = room_speed * 2;
inv_timer = 0;

inputs = {
	left: ord("A"), 
	right: ord("D"),
	jump: vk_space
}

_morreu = false;