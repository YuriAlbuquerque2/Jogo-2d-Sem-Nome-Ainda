/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

randomize();

//Criando a câmera
var _cam = instance_create_layer(x, y, layer, obj_camera);
_cam.alvo = id;

// Inherit the parent event
event_inherited();

vida_max = 10;
vida_atual = vida_max;

max_velh = 4;
max_velv = 7;
dash_vel = 6;

mostra_estado = true;

dano = noone;
ataque = 1;
posso = true;	
perm_dash = false;
invulneravel = false;
tempo_invulneravel = 0;