/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//Save
global.salvando = false;
global.carregando = true;
catch_save("save.ini");

//
global.dano = false;

//Velocidade do jogo
global.vel_mult = 1;

//Power-Ups
global.salvar_dash = 0;
global.perm_dash = false;

//Vida
global.vida_max = 10;
global.vida_atual = global.vida_max;

//game over
game_over = false;
valor = 0;
contador = 0;
timer = game_get_speed(gamespeed_fps) * 4;
timer_cura = 0;
timer_dash = 0;

//Rooms
global.current_room = room;
global.salvamento = 0;
global.player_x = 0;
global.player_y = 0;
global.direcao = 1;

//mais condicionais
global.cobra_morreu1 = false;
global.orc_morreu1 = false;
global.boss_morreu = 0;
global.boss_morto = false;
global.caiu = false;

//condições de Sons
global.game_over = -1;
global.som_orc = -1;
global.som_player = -1;
global.som_player_hit = -1;
global.musica_menu = -1;
global.musica_de_jogo = -1;
global.musica_boss = -1;
global.som_cobra = -1;
global.som_fogo = -1;
global.grama = -1;
global.grama_orc = -1;
global.grama_cobra = -1;
global.som_cura = -1;
global.som_item_dash = -1;
global.madeira = -1;
global.som_boss_hurt = -1;
global.som_boss_taunt = -1;
global.som_boss_morreu = -1;
global.som_dash = -1;

//controle de dialogos
global.dialogo = false;
global.criar_npc1 = -1;
global.dialogo1 = 0;
global.dialogo1_jafoi = false;