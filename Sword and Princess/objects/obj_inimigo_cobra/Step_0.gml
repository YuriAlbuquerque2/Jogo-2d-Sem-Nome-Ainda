/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

if (instance_exists(obj_transicao)) {
	global.grama_cobra = -1;
	exit;
}

if (obj_player.pause_active || obj_player.show_no_save_message) {
	image_speed = 0;
	velh = 0;
	velv = 0;
	global.grama_cobra = -1;
	exit;
}
image_speed = 1;

var _chao = place_meeting(x, y + 1, obj_block);

if (!_chao) {
	velv += GRAVIDADE * massa * global.vel_mult;	
}



switch (estado) {
	#region parado
	case "parado": 
	{
		global.grama_cobra = -1;
		global.som_cobra = -1;
		velh = 0;
		timer_estado++;
		if (sprite_index != spr_inimigo_cobra_idle) {
			image_index = 0;	
		}
		sprite_index = spr_inimigo_cobra_idle;
		
		 
		 //Indo para o estado de patrulha
		 
		 if (room == rm_tutorial) exit;
		 
		 if (irandom(timer_estado) > 200) {
			estado = choose("walk", "parado", "walk"); 
			timer_estado = 0;
		 }	
		
		break;
	}
	#endregion
	
	#region walk
	case "walk":
	{	
		global.som_cobra = -1;
		timer_estado++;
		if (sprite_index != spr_inimigo_cobra_walk) {
			image_index = 0;	
			velh = choose(1, -1) * global.vel_mult;
		}
		sprite_index = spr_inimigo_cobra_walk;
		global.grama_cobra++;
		
		//Condição de saída do estado
		if (irandom(timer_estado) > 200) {
			estado = choose("parado", "walk", "parado");
			timer_estado = 0;
		}
		
		break;
	}
	#endregion
	
	#region hit
	case "hit":
	{
		global.grama_cobra = -1;
		velh = 0;
		
		if (sprite_index != spr_inimigo_cobra_hit) {
			//Iniciando o que for preciso para este estado
			image_index = 0;
		}
		sprite_index = spr_inimigo_cobra_hit;
		global.som_cobra++;
		
		//Condição para sair do estado
		if (image_index > image_number - 1) {
			//Checando se eu ainda tenho vida
			if (vida_atual > 0) {
				estado = "parado";	
			} else if (vida_atual <= 0) {
				estado = "dead";	
			}
		}
		global.dano = false;
		
		break;
	}
	#endregion
	
	#region dead
	case "dead":
	{
		global.grama_cobra = -1;
		global.som_cobra = -1;
		if (room == rm_cenario3) {
			global.cobra_morreu1 = true;	
		}
		
		if (sprite_index != spr_inimigo_cobra_dead) {
			image_index = 0;	
		}
		sprite_index = spr_inimigo_cobra_dead;
		
		//Morrendo de verdade
		if (image_index > image_number - 1) {
			image_speed = 0;
			image_alpha -= .01;
			
			if (image_alpha <= 0) {
				instance_destroy();
				}
			}
		
		break;
	}
	#endregion
	
	default: 
	{
		estado = "parado";	
	}
}