/// @description Atualiza o comportamento do inimigo

if (obj_player.pause_active || obj_player.show_no_save_message) {
    image_speed = 0;
    velh = 0;
    velv = 0;
    exit;
}
image_speed = 1;

var _chao = place_meeting(x, y + 1, obj_block);

if (!_chao) {
    velv += GRAVIDADE * massa * global.vel_mult;    
}

if (instance_exists(obj_inimigo_orc)) {
	if (point_distance(x, y, obj_player.x, obj_player.y) > 50) {
		estado = "parado";
	} else {
		estado = "attack1";	
	}
	
	if (vida_atual <= 0) {
		estado = "dead";	
	}
}

switch (estado) {
    case "parado":
    {
		global.som_boss_hurt = -1;
		global.som_boss_taunt = -1;
        if (sprite_index != spr_boss_idle) {
            sprite_index = spr_boss_idle;
            image_index = 0;
            if (vida_atual <= (vida_max / 3) && summon_2 == false) {
                instance_create_layer(x + 50, y - 1, layer, obj_inimigo_orc);    
                instance_create_layer(x - 50, y - 1, layer, obj_inimigo_orc);
                summon_2 = true;
            }
        }
        
        if (instance_exists(obj_player)) {
            var _dist = point_distance(x, y, obj_player.x, obj_player.y);
            
            if (_dist < 1000) {
                estado = "movendo";    
            }
        }
    
        break;
    }
    
    case "movendo":
    {
		global.som_boss_hurt = -1;
		global.som_boss_taunt = -1;
        if (sprite_index != spr_boss_walk) {
            sprite_index = spr_boss_walk;
            image_index = 0;
        }
        
        if (instance_exists(obj_player)) {
            var _dist = point_distance(x, y, obj_player.x, obj_player.y);
            var _dir = point_direction(x, y, obj_player.x, obj_player.y);
            
            // Ajustar a direção do inimigo para o jogador
            if (obj_player.x > x) {
                xscale = 1; 
            } else {
                xscale = -1; 
            }

            if (_dist > 35) {
                velh = lengthdir_x(max_velh, _dir);
            }
            else {
                velh = 0;    
                estado = choose("attack1", "attack2");
            }
        }
        
        break;
    }
    
    case "attack1":
    case "attack2":
    {
		global.som_boss_hurt = -1;
		global.som_boss_taunt = -1;
        if (estado == "attack1" && sprite_index != spr_boss_ataque1) {
            sprite_index = spr_boss_ataque1;
            image_index = 0;
        }
        if (estado == "attack2" && sprite_index != spr_boss_ataque2) {
            sprite_index = spr_boss_ataque2;
            image_index = 0;
        }
        
        posso = true;
        dano = noone;

        // Ajustar a direção antes do ataque
        if (obj_player.x > x) {
            xscale = 1; 
        } else {
            xscale = -1; 
        }

        if (image_index >= 2 && dano == noone && posso) {
            var _xoffset = (xscale == -1) ? sprite_width + 20 : (sprite_width / 2) - 15;
            dano = instance_create_layer(x + _xoffset, y - sprite_height / 1.5, layer, obj_dano2);
            dano.dano = ataque;
            dano.pai = id;
            if (estado == "attack1") dano.image_yscale = 2;
            posso = false;
        }
        
        if (dano != noone && image_index >= 5 && estado == "attack1") {
            instance_destroy(dano);
            dano = noone;
        } else if (dano != noone && image_index >= 4 && estado == "attack2") {
            instance_destroy(dano);
            dano = noone;
        }
        
        if (image_index > image_number - 1) {
            if (vida_atual >= (vida_max / 2)) {
                estado = "taunt";    
            } else {
                estado = "parado";    
            }
        }
        
        if (vida_atual <= 0) {
            estado = "dead";    
        }
        
        break;
    }
    
    case "taunt":
    {
		global.som_boss_hurt = -1;
        if (sprite_index != spr_boss_taunt) {
            sprite_index = spr_boss_taunt;
            image_index = 0;
			global.som_boss_taunt++;
            if (vida_atual <= (vida_max - (vida_max / 3)) && summon_1 == false) {
                instance_create_layer(x + 50, y - 1, layer, obj_inimigo_orc);    
                instance_create_layer(x - 50, y - 1, layer, obj_inimigo_orc);
                summon_1 = true;
            }
        }    
        
        // Verifica se o inimigo foi atingido
        if (place_meeting(x, y, obj_dano)) {
            estado = "parado";    
        }
        
        if (image_index > image_number - 1) {
            estado = "parado";    
        }
        if (vida_atual <= 0) {
            estado = "dead";
        }    
        
        break;
    }
    
    case "hit":
    {
		global.som_boss_taunt = -1;
        delay = (game_get_speed(gamespeed_fps)) * 2;
        velh = 0;
        
        if (sprite_index != spr_boss_hit) {
            sprite_index = spr_boss_hit;    
            image_index = 0;
			global.som_boss_hurt++;
        }
        
        if (obj_player.x > x) {
            xscale = 1; 
        } else {
            xscale = -1; 
        }
        
        if (image_index > image_number - 1) {
            if (vida_atual > 0) {
                estado = choose("attack1", "attack2");    
            } else {
                estado = "dead";    
            }
        }
        
        break;
    }
    
    case "dead":
    {
		global.som_boss_hurt = -1;
		global.som_boss_taunt = -1;
		global.boss_morto = true;
        if (sprite_index != spr_boss_dead) {
            sprite_index = spr_boss_dead;
            image_index = 0;    
			global.som_boss_morreu++;
        }
        
        if (image_index > image_number - 1) {
            image_speed = 0;
            image_alpha -= .01;
            
            if (image_alpha <= 0) {
                if (global.vida_atual < 10) {
                    instance_create_layer(x, y - 10, layer, obj_cura);
                    instance_create_layer(x + 10, y - 10, layer, obj_cura);
                    instance_create_layer(x - 10, y - 10, layer, obj_cura);
                }
                instance_destroy();
				instance_destroy(obj_player);
				room_goto(rm_duvida);
            }
        }
        
        screenshake(4);
        
        break;
    }
    
    default:
    {
        estado = "parado";    
    }
}

if (delay > 0) delay--;        
