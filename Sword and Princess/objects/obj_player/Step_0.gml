/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor




//Sistema de pausa
if (keyboard_check_pressed(key_back) && room != rm_tutorial) {
    pause_active = !pause_active;
	
	if (pause_active) {
		audio_pause_sound(snd_musica);
		audio_pause_sound(snd_musica_boss);
	}
	else {
		audio_resume_sound(snd_musica);
		audio_resume_sound(snd_musica_boss);
	}
}

if (pause_active && room != rm_tutorial) {
    if (!confirm_exit && !show_no_save_message) {
        if (keyboard_check_pressed(key_up)) {
            pause_sel = (pause_sel - 1 + array_length(pause_options)) mod array_length(pause_options);
			audio_play_sound(snd_navega, 2, false);
        } else if (keyboard_check_pressed(key_down)) {
            pause_sel = (pause_sel + 1) mod array_length(pause_options);
			audio_play_sound(snd_navega, 2, false);
        }

        if (keyboard_check_pressed(key_select)) {
            switch (pause_sel) {
                case 0: // Voltar ao jogo
					audio_play_sound(snd_confirma, 2, false);
                    pause_active = false;
                    break;
                case 1: // Carregar último save
					audio_play_sound(snd_confirma, 2, false);
                    if (file_exists("save.ini")) {
                        sys_load("save.ini");
						if (room != rm_cenario8) {
							audio_resume_sound(snd_musica);
						} else {
							audio_resume_sound(snd_musica_boss);	
						}
                    } else {
                        show_no_save_message = true;
                        no_save_timer = 2 * game_get_speed(gamespeed_fps); // Define 2 segundos para exibição
                        pause_active = false; // Desativa o menu de pausa temporariamente
                    }
                    break;
                case 2: // Opções
					audio_play_sound(snd_confirma, 2, false);
                    confirm_exit = true;
                    break;
            }
        }
    } else if (confirm_exit) {
        // Confirmação de saída
        if (keyboard_check_pressed(key_up) || keyboard_check_pressed(key_down)) {
			audio_play_sound(snd_navega, 2, false);
            confirm_sel = !confirm_sel;
        }
        if (keyboard_check_pressed(key_select)) {
			audio_play_sound(snd_confirma, 2, false);
            if (confirm_sel == 0) {
                game_end();
            } else {
                confirm_exit = false;
            }
        }
    }
}

// Lógica para exibição da mensagem "Não existe jogo salvo!"
if (show_no_save_message) {
    no_save_timer--;
    if (no_save_timer <= 0) {
        show_no_save_message = false;
        pause_active = true; // Retorna ao menu de pausa
    }
}


if (pause_active || show_no_save_message) {
	image_speed = 0;
	velh = 0;
	velv = 0
	exit;
}
image_speed = 1;

if (global.dialogo) {
	velh = 0;
	velv = 0;
	exit;
}

//Checando se o obj_transicao existe
if (instance_exists(obj_transicao)) {
	velh = 0;
	exit;
}

//Iniciando variáveis
var _velh = sign(velh);
var _right, _left, _jump, _attack, _dash;
var _chao = place_meeting(x, y + 1, obj_block);
var _chao_que_cai = place_meeting(x, y + 1, obj_block_fall);

_right = keyboard_check(ord("D"));
_left = keyboard_check(ord("A"));
_jump = keyboard_check_pressed(vk_space);
_attack = keyboard_check_pressed(ord("J"));
_dash = keyboard_check_pressed(ord("F"));

//Código de movimentação
velh = (_right - _left) * max_velh * global.vel_mult;

//Aplicando gravidade
if (!_chao) {
	if (velv < max_velv * 2) { //Limitando velocidade de queda
		velv += GRAVIDADE * massa * global.vel_mult;
	}
} 

if (_chao_que_cai) {
	velv = 0;	
}

//Iniciando a máquina de estado
switch (estado) {
	#region parado
	case "parado":
	{
		global.som_dash = -1;
		global.grama = -1;
		global.madeira = -1;
		global.som_player_hit = -1;
		global.som_player = -1;
		if (sprite_index != spr_player_idle) {
			image_index = 0;	
		}
		//Comportamento do estado
		sprite_index = spr_player_idle;
		
		//Condição de troca de estado
		//Movendo
		if (velh != 0) {
			estado = "movendo";	
		}
		else if (_jump || velv != 0) {
			estado = "pulando";
			image_index = 0;
			velv = (-max_velv * _jump);
		}
		else if (_attack) {
			estado = "ataque";
			velh = 0;
			image_index = 0;
		}
		else if (_dash && global.perm_dash == true) {
			estado = "dash";
			image_index = 0;
		}
		
		break;
	}
	#endregion
	
	#region movendo
	case "movendo":
	{
		global.som_dash = -1;
		global.som_player_hit = -1;
		global.som_player = -1;
		//Comportamento do estado de movimento
		if (sprite_index != spr_player_andando) {
			image_index = 0;
		}	
		sprite_index = spr_player_andando;
		
		if (room == rm_cenario5 || room == rm_cenario6) {
			global.madeira++;
		} else {
			global.grama++;	
		}
		
		//Condição de troca de estado
		//Parado
		if (abs(velh) < .1) {
			estado = "parado";
			velh = 0;
		}
		else if (_jump || velv != 0) {
			estado = "pulando";
			image_index = 0;
			velv = (-max_velv * _jump);
		}
		else if (_attack) {
			estado = "ataque";
			velh = 0;
			image_index = 0;
		}
		else if (_dash && global.perm_dash == true) {
			estado = "dash";
			image_index = 0;
		}
		
		break;
	}
	#endregion
	
	#region pulando
	case "pulando":
	{
		global.som_dash = -1;
		global.grama = -1;
		global.madeira = -1;
		global.som_player_hit = -1;
		global.som_player = -1;
		//Estou caindo
		if (velv > 0) {
			if (sprite_index != spr_player_fall) {
				image_index = 0;	
			}
				sprite_index = spr_player_fall;
		} else { 
			if (sprite_index != spr_player_pulo) {
				image_index = 0;	
			}
			sprite_index = spr_player_pulo;	
			//Garantindo que a animação não se repita
			if (image_index >= image_number-1) {
					image_index = image_number-1;
			}
		}
		
		//Condição de troca de estado
		if (_chao) {
			estado = "parado";	
		}
		if (_dash && global.perm_dash == true) {
			estado = "dash";	
		}
		if (global.vida_atual <= 0) {
			estado = "dead";	
		}
		
		break;
	}
	#endregion
	
	#region ataque
	case "ataque":
	{
		global.som_dash = -1;
		global.grama = -1;
		global.madeira = -1;
		global.som_player = -1;
		velh = 0;
		
		if (sprite_index != spr_player_ataque1) {
			image_index = 0;	
		}
		sprite_index = spr_player_ataque1;
		global.som_player_hit++;
		
		//Criando o objeto de dano
		if (image_index >= 2 && dano == noone && posso) {
			if (xscale == 1) {
				dano = instance_create_layer(x + sprite_width/6, y - sprite_height/2, layer, obj_dano);
				dano.dano = ataque;
				dano.pai = id;
				posso = false;
			}
			else if (xscale == -1) {
				dano = instance_create_layer(x + sprite_width/3, y - sprite_height/2, layer, obj_dano);
				dano.dano = ataque;
				dano.pai = id;	
				posso = false;
			}
		}
		
		if (image_index > image_number-1) {
			estado = "parado";	
			velh = 0;
			posso = true;
			if (dano) {
				instance_destroy(dano, false);
				dano = noone;
			}
		}
		if (_dash && global.perm_dash == true) {
			estado = "dash";
			image_index = 0;
			if (dano) {
				instance_destroy(dano, false);
				dano = noone;
			}
		}	

		break
	}
	#endregion
	
	#region hit
	case "hit":
	{	
		global.som_dash = -1;
		global.grama = -1;
		global.madeira = -1;
		global.som_player_hit = -1;
		velh = 0;
		
		if (sprite_index != spr_player_hit) {
			image_index = 0;	
		}
		sprite_index = spr_player_hit;
		global.som_player++;
		
		screenshake(3);
		
		
		invulneravel = true;
		tempo_invulneravel = game_get_speed(gamespeed_fps);
		
		
		if (global.vida_atual > 0) {
			if (image_index >= image_number - 1) {
				obj_screenshake.shake = 0;
				estado = "parado";	
			}
		} else {
			if (image_index >= image_number - 3) {
				estado = "dead";	
				obj_screenshake.shake = 0;
				image_index = 0;
			}
		}
		
		break;
	}
	#endregion
	
	#region dash
	case "dash":
	{
		global.grama = -1;
		global.som_player_hit = -1;
		global.madeira = -1;
		global.som_player = -1;
		if (sprite_index != spr_player_dash) {
			image_index = 0;	
		}
			sprite_index = spr_player_dash;
			global.som_dash++;
			
			//Velocidade
			velh = image_xscale * dash_vel;
			
			//Saindo do estado
			if (image_index >= image_number-1) {
				estado = "parado";
			}	
			
			break;
	}
	#endregion
	
	#region dead
	case "dead":
	{
		global.som_dash = -1;
		global.grama = -1;
		global.madeira = -1;
		global.som_player_hit = -1;
		global.som_player = -1;
		if (instance_exists(obj_controller) && global.vida_atual <= 0) {
			with (obj_controller) {
				game_over = true;	
				global.som_game_over = true;
			}
		}
		
		velh = 0;
		
		if (sprite_index != spr_player_dead) {
			image_index = 0;	
		}
		sprite_index = spr_player_dead;
		
		if (image_index >= image_number - 1) {
			image_index = image_number - 1;
		}	
		break;
		
	}
#endregion

	default:
	{
		estado = "parado";	
	}
}

//Conquistando o dash
if (place_meeting(x + _velh, y, obj_item_dash))	
	{
		global.perm_dash = true;
		if (_dash && instance_exists(obj_item_dash)) {
			instance_destroy(obj_item_dash);
		}
	}
	
//Salvamento
var _obj = instance_nearest(x, y, obj_salvamento);
if (_obj != noone && abs(x - _obj.x) <= 50 && keyboard_check_pressed(ord("S"))) {
	timer = game_get_speed(gamespeed_fps) * 2;	
}
	
//Invulnerável após tomar hit
if (invulneravel) {
	image_alpha = 0.5;
	tempo_invulneravel -= 1;
}
	
if (tempo_invulneravel <= 0) {
	image_alpha = 1;
	invulneravel = false;	
}
	
if (distance_to_object(obj_npc_pai) <= 32) {
	if (keyboard_check_pressed(ord("E")) && global.dialogo == false) {
		var _npc = instance_nearest(x, y, obj_npc_pai);
		var _dialogo = instance_create_layer(x, y, layer, obj_dialogo);
		_dialogo.npc_nome = _npc.nome;
	}
}