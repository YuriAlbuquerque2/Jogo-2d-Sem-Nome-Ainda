/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

if (instance_exists(obj_transicao)) { 
	global.grama_orc = -1;
	exit;
}

if (obj_player.pause_active || obj_player.show_no_save_message) {
	image_speed = 0;
	velh = 0;
	velv = 0;
	global.grama_orc = -1;
	exit;
}
image_speed = 1;

var _chao = place_meeting(x, y + 1, obj_block);

if (!_chao) {
	velv += GRAVIDADE * massa * global.vel_mult;	
}

var _ataque = collision_line(x, y - sprite_height/1.5, x + 50 * xscale, y - sprite_height/1.5, obj_player, 0, 1);
var _player = collision_line(x, y - sprite_height/1.5, x + dist * xscale, y - sprite_height/1.5, obj_player, 0, 1); 

if (_player) {
	vi_o_player = true;	
}

switch (estado) {
	case "parado": 
	{
		global.grama_orc = -1;
		global.som_orc = -1;
		velh = 0;
		timer_xscale++;
		if (sprite_index != spr_inimigo_orc_idle) {
			image_index = 0;	
		}
		sprite_index = spr_inimigo_orc_idle;
		 
		 //Indo para o estado de patrulha
		 if (irandom(timer_xscale) > 150) {
			xscale = choose(-1, 1); 
			timer_xscale = 0;
		 }	
		 
		 if (_player || vi_o_player) {
			estado = "run";	
		}
		if (vida_atual <= 0) {
            estado = "dead";    
        }
		
		break;
	}
	
	case "run":
	{
		global.som_orc = -1;	
		if (sprite_index != spr_inimigo_orc_run) {
        image_index = 0;
		
    }
    sprite_index = spr_inimigo_orc_run;
	
	if (instance_exists(obj_inimigo_orc) && room != rm_cenario8 && room != rm_cutscene) {
		global.grama_orc++;
	} else if (instance_exists(obj_inimigo_orc)) {
		global.grama_orc++;	
	} else {
		global.grama_orc = -1;	
	}

    var _dx = obj_player.x - x;
    var _dy = obj_player.y - y;
    var _distancia = sqrt(_dx*_dx + _dy*_dy);

    var _player_a_frente = (xscale == 1 && obj_player.x > x) || (xscale == -1 && obj_player.x < x);

    if (_distancia > distancia + 10) {
        var _direction = point_direction(x, y, obj_player.x, obj_player.y);
        velh = lengthdir_x(5, _direction);
    } else if (_distancia <= distancia && _player_a_frente) {
        velh = 0;
        estado = "attack";
    } else if (vi_o_player) {
		var _direction = point_direction(x, y, obj_player.x, obj_player.y);
		velh = lengthdir_x(5, _direction);
	}
		
		break;
	}
	
	case "attack":
	{
		global.grama_orc = -1;
		global.som_orc = -1;
		velh = 0;
  
		posso = true;
		dano = noone;
 
    sprite_index = spr_inimigo_orc_attack;
    
    if (image_index >= 5 && dano == noone && image_index < 8 && posso) {
		if (xscale = -1) {
	        dano = instance_create_layer(x + sprite_width + 15, y - sprite_height/1.5, layer, obj_dano2);
	        dano.dano = ataque;
	        dano.pai = id;
			posso = false;
		}
		else if (xscale = 1) {
			dano = instance_create_layer(x + (sprite_width/2) - 20, y - sprite_height/1.5, layer, obj_dano2);
			dano.dano = ataque;
			dano.pai = id;
			posso = false;
		}
    }
	
	if (dano != noone && image_index >= 7) {
		instance_destroy(dano);
		dano = noone;
	}
    
    // Verifique se a animação de ataque terminou
    if (image_index > image_number - 1) {
        estado = "run";
    }
	if (vida_atual <= 0) {
           estado = "dead";    
    }

		break;
	}
	
	case "hit":
	{
		global.grama_orc = -1;
    delay = (game_get_speed(gamespeed_fps)) * 2;
    velh = 0;
    
    if (sprite_index != spr_inimigo_orc_hit) {
        //Iniciando o que for preciso para este estado
        image_index = 0;
    }
    sprite_index = spr_inimigo_orc_hit;
	global.som_orc++;
    
    // Verificar a posição do jogador e virar o inimigo para ele
    if (obj_player.x > x) {
        xscale = 1; // Inimigo olha para a direita
    } else {
        xscale = -1; // Inimigo olha para a esquerda
    }

    //Condição para sair do estado
    if (image_index > image_number - 1) {
        //Checando se ainda tenho vida
        if (vida_atual > 0) {
            estado = "run";    
        } else if (vida_atual <= 0) {
            estado = "dead";    
        }
    }
		
		break;
	}
	case "dead":
	{
		global.grama_orc = -1;
		global.som_orc = -1;
		if (room == rm_cenario3) {
			global.orc_morreu1 = true;	
		}
		
		if (sprite_index != spr_inimigo_orc_dead) {
			image_index = 0;	
		}
		sprite_index = spr_inimigo_orc_dead;
		
		//Morrendo de verdade
		if (image_index > image_number - 1) {
			image_speed = 0;
			image_alpha -= .01;
			
			if (image_alpha <= 0) {
				if (global.vida_atual < 10) {
					instance_create_layer(x, y - 10, layer, obj_cura); 
				}
				instance_destroy();
				}
			}
		
		break;
	}
	
	default: 
	{
		estado = "parado";	
	}
}

if (delay > 0) delay--;	
