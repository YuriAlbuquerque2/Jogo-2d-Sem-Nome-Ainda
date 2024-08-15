/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

// Inherit the parent event
event_inherited();

//Adicionando os atributos do boss
vida_max = 15 * global.dificuldade;
vida_atual = vida_max;

max_velh = 3;
max_velv = 3;

timer_estado = 0;

ataque = 2 * global.dificuldade;
massa = 3;

posso = false;
dano = noone;

summon_1 = false;
summon_2 = false;