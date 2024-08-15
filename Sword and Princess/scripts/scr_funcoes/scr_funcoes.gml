// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações
function scr_funcoes(){

}

global.dificuldade = 1;

enum MENU_ACOES {
	RODA_METODO,
	CARREGA_MENU,
	AJUSTES_MENU
}	

enum MENUS_LISTA {
	PRINCIPAL,
	OPCOES,
	TELA,
	DIFICULDADE
}

//Screenshake
///@function screenshake(valor_da_tremida)
///@arg _treme
function screenshake(_treme) {
		var _shake = instance_create_layer(0, 0, layer, obj_screenshake);
		_shake.shake = _treme;
}

//Definir align
///@function define_align(vertical, horizontal)
function define_align(_ver, _hor) {
	draw_set_halign(_hor);
	draw_set_valign(_ver);
}


//Pegar o valor da animation curve
///@function valor_ac(animation_curve, animar, [canal])
function valor_ac(_anim, _animar = false, _chan = 0) {
	static _pos = 0, _sel = 0;
	
	_pos += delta_time / 1000000;
	
	if (_animar) _pos = 0;
	
	var _canal = animcurve_get_channel(_anim, _chan);
	_sel = animcurve_channel_evaluate(_canal, _pos);
	
	return _sel;
}

function sys_save(_nome_arquivo = "save.ini", _save = 0, _dificuldade = 1, _room_salva = 0, _direcao = 1, _boss_morreu = 0, _dialogo1 = 0, _vida_atual = 10, _posicao_x = 0, _posicao_y = 0, _dash = 0) {
	ini_open(_nome_arquivo);
	
	ini_write_real("jogo", "save", _save);
	ini_write_real("jogo", "dificuldade", _dificuldade);
	ini_write_real("jogo", "room_atual", _room_salva);
	ini_write_real("jogo", "direcao", _direcao);
	ini_write_real("jogo", "boss", _boss_morreu);
	ini_write_real("dialogos", "dialogo1", _dialogo1);
	ini_write_real("player", "vida_atual", _vida_atual);
	ini_write_real("player", "posicao_x", _posicao_x);
	ini_write_real("player", "posicao_y", _posicao_y);
	ini_write_real("powerups", "dash", _dash);
	
	ini_close();
}

function catch_save(_nome_arquivo = "save.ini") {
	ini_open(_nome_arquivo);
	
	var _save = ini_read_real("jogo", "save", 0);
	
	global.existe_save = _save;
	
	ini_close();
}

function sys_load(_nome_arquivo = "save.ini") {
	ini_open(_nome_arquivo);	
	
	var _save = ini_read_real("jogo", "save", 0);
	var _dificuldade = ini_read_real("jogo", "dificuldade", 1);
	var _room_atual = ini_read_real("jogo", "room_atual", 0);
	var _direcao = ini_read_real("jogo", "direcao", 1);
	var _boss_morreu = ini_read_real("jogo", "boss", 0);
	var _dialogo1 = ini_read_real("dialogos", "dialogo1", 0);
	var _vida_atual = ini_read_real("player", "vida_atual", 10);
	var _posicao_x = ini_read_real("player", "posicao_x", 0);
	var _posicao_y = ini_read_real("player", "posicao_y", 0);
	var _dash = ini_read_real("powerups", "dash", 0);
	
	global.existe_save = _save;
	global.dificuldade = _dificuldade;
	global.salvamento = _room_atual;
	global.direcao = _direcao
	global.boss_morreu = _boss_morreu;
	global.dialogo1 = _dialogo1;
	global.vida_atual = _vida_atual;
	global.player_x = _posicao_x;
	global.player_y = _posicao_y;
	global.salvar_dash = _dash;
	
	if (global.salvar_dash == 1) {
		global.perm_dash = true;	
	} else {
		global.perm_dash = false;	
	}
	
	if (global.dialogo1 == 1) {
		global.dialogo1_jafoi = true;	
		global.criar_npc1 = 1;
	} else {
		global.dialogo1_jafoi = false;	
		global.criar_npc1 = -1;
	}
	
	if (global.boss_morreu == 1) {
		global.boss_morto = true;	
	} else {
		global.boss_morto = false;	
	}
	
	if (_room_atual == 1) {
		room_goto(rm_cenario7);
		instance_create_layer(global.player_x, global.player_y + 2, layer, obj_player);
		obj_player.xscale = global.direcao;
		obj_player.x = global.player_x;
		obj_player.y = global.player_y;
	}		
	ini_close();
}

function salvar_direcao(_nome_arquivo = "direcao.ini", _direcao = 1) {
	ini_open(_nome_arquivo);
	
	ini_write_real("game", "direcao", _direcao);
	
	ini_close();
}

function carregar_direcao(_nome_arquivo = "direcao.ini") {
	ini_open(_nome_arquivo);
	
	var _direcao = ini_read_real("game", "direcao", 1);
	
	obj_player.xscale = _direcao;
	
	ini_close();
}

function vida_player() {
	if (!obj_player.pause_active && !obj_controller.game_over && !obj_player.show_no_save_message) {
	if (global.vida_atual >= 10) {
		draw_sprite(spr_vida10, -1, camera_get_view_width(view_camera[0]) - 735, camera_get_view_height(view_camera[0]) - 550);
	} else if (global.vida_atual >= 9 && global.vida_atual < 10) {
		draw_sprite(spr_vida9, -1, camera_get_view_width(view_camera[0]) - 735, camera_get_view_height(view_camera[0]) - 550);
	} else if (global.vida_atual >= 8 && global.vida_atual < 9) {
		draw_sprite(spr_vida8, -1, camera_get_view_width(view_camera[0]) - 735, camera_get_view_height(view_camera[0]) - 550);
	} else if (global.vida_atual >= 7 && global.vida_atual < 8) {
		draw_sprite(spr_vida7, -1, camera_get_view_width(view_camera[0]) - 735, camera_get_view_height(view_camera[0]) - 550);
	} else if (global.vida_atual >= 6 && global.vida_atual < 7) {
		draw_sprite(spr_vida6, -1, camera_get_view_width(view_camera[0]) - 735, camera_get_view_height(view_camera[0]) - 550);
	} else if (global.vida_atual >= 5 && global.vida_atual < 6) {
		draw_sprite(spr_vida5, -1, camera_get_view_width(view_camera[0]) - 735, camera_get_view_height(view_camera[0]) - 550);
	} else if (global.vida_atual >= 4 && global.vida_atual < 5) {
		draw_sprite(spr_vida4, -1, camera_get_view_width(view_camera[0]) - 735, camera_get_view_height(view_camera[0]) - 550);
	} else if (global.vida_atual >= 3 && global.vida_atual < 4) {
		draw_sprite(spr_vida3, -1, camera_get_view_width(view_camera[0]) - 735, camera_get_view_height(view_camera[0]) - 550);	
	} else if (global.vida_atual >= 2 && global.vida_atual < 3) {
		draw_sprite(spr_vida2, -1, camera_get_view_width(view_camera[0]) - 735, camera_get_view_height(view_camera[0]) - 550);
	} else if (global.vida_atual > 0 && global.vida_atual < 2) {
		draw_sprite(spr_vida1, -1, camera_get_view_width(view_camera[0]) - 735, camera_get_view_height(view_camera[0]) - 550);
	} else {
		draw_sprite(spr_vida0, -1, camera_get_view_width(view_camera[0]) - 735, camera_get_view_height(view_camera[0]) - 550);
	}
}
}

function localizacao_player() {
	if (room == rm_tutorial && !obj_controller.game_over && !obj_player.show_no_save_message) {
		draw_set_font(fnt_normal);
		draw_set_color(c_black);
		draw_sprite(spr_localizacao, -1, camera_get_view_width(view_camera[0]) + 520, camera_get_view_height(view_camera[0]) + 500);
		draw_text(camera_get_view_width(view_camera[0]) + 545, camera_get_view_height(view_camera[0]) + 500, "Saída do Reino");
		draw_set_font(-1);
		draw_set_color(-1);
	} else if (room == rm_cenario1 && !obj_controller.game_over && !obj_player.show_no_save_message) {
		draw_set_font(fnt_normal);
		draw_set_color(c_black);
		draw_sprite(spr_localizacao, -1, camera_get_view_width(view_camera[0]) + 580, camera_get_view_height(view_camera[0]) + 500);
		draw_text(camera_get_view_width(view_camera[0]) + 605, camera_get_view_height(view_camera[0]) + 500, "Planície");
		draw_set_font(-1);
		draw_set_color(-1);
	} else if (room == rm_cenario2 && !obj_controller.game_over && !obj_player.show_no_save_message) {
		draw_set_font(fnt_normal);
		draw_set_color(c_black);
		draw_sprite(spr_localizacao, -1, camera_get_view_width(view_camera[0]) + 580, camera_get_view_height(view_camera[0]) + 500);
		draw_text(camera_get_view_width(view_camera[0]) + 605, camera_get_view_height(view_camera[0]) + 500, "Planície");
		draw_set_font(-1);
		draw_set_color(-1);	
	} else if (room == rm_cenario3 && !obj_controller.game_over && !obj_player.show_no_save_message) {
		draw_set_font(fnt_normal);
		draw_set_color(c_black);
		draw_sprite(spr_localizacao, -1, camera_get_view_width(view_camera[0]) + 540, camera_get_view_height(view_camera[0]) + 500);
		draw_text(camera_get_view_width(view_camera[0]) + 565, camera_get_view_height(view_camera[0]) + 500, "Vila do Reino");
		draw_set_font(-1);
		draw_set_color(-1);	
	} else if (room == rm_cenario4 && !obj_controller.game_over && !obj_player.show_no_save_message) {
		draw_set_font(fnt_normal);
		draw_set_color(c_black);
		draw_sprite(spr_localizacao, -1, camera_get_view_width(view_camera[0]) + 540, camera_get_view_height(view_camera[0]) + 500);
		draw_text(camera_get_view_width(view_camera[0]) + 565, camera_get_view_height(view_camera[0]) + 500, "Vila do Reino");
		draw_set_font(-1);
		draw_set_color(-1);	
	} else if (room == rm_cenario5 && !obj_controller.game_over && !obj_player.show_no_save_message) {
		draw_set_font(fnt_normal);
		draw_set_color(c_black);
		draw_sprite(spr_localizacao, -1, camera_get_view_width(view_camera[0]) + 580, camera_get_view_height(view_camera[0]) + 500);
		draw_text(camera_get_view_width(view_camera[0]) + 605, camera_get_view_height(view_camera[0]) + 500, "Celeiro");
		draw_set_font(-1);
		draw_set_color(-1);		
	} else if (room == rm_cenario6 && !obj_controller.game_over && !obj_player.show_no_save_message) {
		draw_set_font(fnt_normal);
		draw_set_color(c_black);
		draw_sprite(spr_localizacao, -1, camera_get_view_width(view_camera[0]) + 580, camera_get_view_height(view_camera[0]) + 500);
		draw_text(camera_get_view_width(view_camera[0]) + 605, camera_get_view_height(view_camera[0]) + 500, "Celeiro");
		draw_set_font(-1);
		draw_set_color(-1);	
	} else if (room == rm_cenario7 && !obj_controller.game_over && !obj_player.show_no_save_message) {
		draw_set_font(fnt_normal);
		draw_set_color(c_black);
		draw_sprite(spr_localizacao, -1, camera_get_view_width(view_camera[0]) + 540, camera_get_view_height(view_camera[0]) + 500);
		draw_text(camera_get_view_width(view_camera[0]) + 565, camera_get_view_height(view_camera[0]) + 500, "Vila do Reino");
		draw_set_font(-1);
		draw_set_color(-1);	
	} else if (room == rm_cenario8 && !obj_controller.game_over && !obj_player.show_no_save_message) {
		draw_set_font(fnt_normal);
		draw_set_color(c_black);
		draw_sprite(spr_localizacao, -1, camera_get_view_width(view_camera[0]) + 580, camera_get_view_height(view_camera[0]) + 500);
		draw_text(camera_get_view_width(view_camera[0]) + 605, camera_get_view_height(view_camera[0]) + 500, "Igreja");
		draw_set_font(-1);
		draw_set_color(-1);	
	}
}

function sons_do_jogo() {
	obj_controller.timer_cura = game_get_speed(gamespeed_fps) * 2;
	obj_controller.timer_dash = game_get_speed(gamespeed_fps) * 2;

	if (global.game_over == 0 && global.vida_atual <= 0) {
	audio_stop_sound(snd_musica);
	audio_stop_sound(snd_musica_boss);
	audio_play_sound(snd_game_over, 1, false);
	
	}
	if (global.vida_atual > 0) {
		if (audio_is_playing(snd_game_over)) {
			audio_stop_sound(snd_game_over);	
		}
	}

	if (global.som_player == 0) {
		audio_play_sound(snd_player_hurt, 3, false);
	
	}

	if (global.som_player_hit == 0) {
		audio_play_sound(snd_player_hit, 3, false);
	}
	
	if (global.som_dash == 0) {
		audio_play_sound(snd_dash, 3, false);	
	}

	if (global.som_orc == 0) {
		audio_play_sound(snd_orc, 2, false);	
	
	}
	
	if (global.som_boss_hurt == 0) {
		if (!audio_is_playing(snd_boss_hurt) && room == rm_cenario8) {
			audio_play_sound(snd_boss_hurt, 2, false);
		}
	} else {
		if (audio_is_playing(snd_boss_hurt)) {
			audio_stop_sound(snd_boss_hurt);	
		}
	}
	
	if (global.som_boss_taunt == 0) {
		if (!audio_is_playing(snd_boss_taunt) && room == rm_cenario8) {
			audio_play_sound(snd_boss_taunt, 2, false);	
		}
	} else {
		if (audio_is_playing(snd_boss_taunt)) {
			audio_stop_sound(snd_boss_taunt);	
		}
	}
	
	if (global.som_boss_morreu == 0) {
		if (!audio_is_playing(snd_boss_morreu) && room == rm_cenario8) {
			audio_play_sound(snd_boss_morreu, 2, false);
		}
	} else {
		if (audio_is_playing(snd_boss_morreu)) {
			audio_stop_sound(snd_boss_morreu);	
		}
	}

	if (global.som_cobra == 0) {
		audio_play_sound(snd_cobra, 2, false);	
	}

	if (global.som_fogo == 0) {
		audio_play_sound(snd_fogo, 5, true);	
	}

	if (global.grama > -1 && room != rm_explicacao) {
		if (!audio_is_playing(snd_passo_grama)) {
			audio_play_sound(snd_passo_grama, 6, true);
		}
	} else {
		audio_stop_sound(snd_passo_grama);	
	}

	if (global.grama_orc > -1) {
		if (!audio_is_playing(snd_passo_grama_orc)) {
			audio_play_sound(snd_passo_grama_orc, 7, true);	
		}
	} else {
		if (audio_is_playing(snd_passo_grama_orc)) {
			audio_stop_sound(snd_passo_grama_orc);	
		} else {
			audio_stop_sound(snd_passo_grama_orc);	
		}
	}

	if (global.grama_cobra > -1) {
		if (!audio_is_playing(snd_passo_grama_cobra)) {
			var _som = audio_play_sound(snd_passo_grama_cobra, 8, true);
			audio_sound_pitch(_som, 0.5);
		}
	} else {
		audio_stop_sound(snd_passo_grama_cobra);	
	}

	if (global.som_cura > -1 && !audio_is_playing(snd_cura)) {	
			audio_play_sound(snd_cura, 8, false);
		} 
	obj_controller.timer_cura = 0;

	if (obj_controller.timer_cura <= 0) {
		global.som_cura = -1;	
	}
	
	if (global.som_item_dash == 0 && !audio_is_playing(snd_item_dash)) {
		audio_play_sound(snd_item_dash, 8, false);	
	}
	obj_controller.timer_dash = 0;
	
	if (global.madeira > -1 && room != rm_explicacao) {
		if (!audio_is_playing(snd_passo_madeira)) {
			var _som = audio_play_sound(snd_passo_madeira, 6, true);
			audio_sound_pitch(_som, 1.5);
		}
	} else {
		audio_stop_sound(snd_passo_madeira);	
	}
	

if (room == rm_menu || room == rm_explicacao) {
	global.musica_boss = -1;
	global.musica_de_jogo = -1;
	global.musica_menu++;
} else if (room == rm_cenario8) {
	global.musica_menu = -1;
	global.musica_de_jogo = -1;
	global.musica_boss++;
} else if (room == rm_duvida) {
	global.musica_menu = -1;
	global.musica_de_jogo = -1;
	global.musica_boss = -1;
} else if (room == rm_final) {
	global.musica_menu = -1;
	global.musica_de_jogo = -1;
	global.musica_boss = -1;
} else {
	global.musica_boss = -1;
	global.musica_de_jogo++;
	global.musica_menu = -1;
}

if (global.musica_menu == 0) {
	audio_stop_sound(snd_musica_boss);
	audio_stop_sound(snd_musica);
	audio_play_sound(snd_musica_menu, 1, true);	
}

if (global.musica_de_jogo == 0 && !game_over) {
	audio_stop_sound(snd_musica_menu);
	audio_stop_sound(snd_musica_boss);
	audio_play_sound(snd_musica, 1, true);
}

if (global.musica_boss == 0 && !game_over) {
	audio_stop_sound(snd_musica_menu);
	audio_stop_sound(snd_musica);
	audio_play_sound(snd_musica_boss, 1, true);	
}
}

function approach(_val1, _val2, _amount) {
	if (_val1 < _val2) {
		_val1 += _amount;
		if (_val1 > _val2) 
			return _val2;	
	} else {
		_val1 -= _amount;
		if (_val1 < _val2)
			return _val2;
		}		
		return _val1;
	}