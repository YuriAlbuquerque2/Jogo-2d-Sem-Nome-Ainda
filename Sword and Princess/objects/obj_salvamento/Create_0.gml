/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

salvando = function() {
	global.salvando = true;
	if (global.perm_dash) {
		global.salvar_dash = 1;	
	} else {
		global.salvar_dash = 0;	
	}
	
	if (global.dialogo1_jafoi) {
		global.dialogo1 = 1;
		global.criar_npc1 = 1;
	} else {
		global.dialogo1 = 0;	
		global.criar_npc1 = -1;
	}
	
	if (global.boss_morto) {
		global.boss_morreu = 1;	
	} else {
		global.boss_morreu = 0;	
	}
	
	if (obj_player.xscale = -1) {
		global.direcao = -1;	
	} else {
		global.direcao = 1;	
	}
	
	global.existe_save = global.existe_save + 1;
	global.player_x = obj_player.x;
	global.player_y = obj_player.y;
	sys_save("save.ini", global.existe_save, global.dificuldade, global.controle, global.salvamento, global.direcao, global.boss_morreu, global.dialogo1, global.vida_atual, global.player_x, global.player_y, global.salvar_dash);	
}