/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//Iniciando variáveis
var _right, _left, _jump, _attack;
var _chao = place_meeting(x, y + 1, obj_block);

_right = keyboard_check(ord("D"));
_left = keyboard_check(ord("A"));
_jump = keyboard_check_pressed(ord("K"));
_attack = keyboard_check_pressed(ord("J"));

//Código de movimentação
velh = (_right - _left) * max_velh;

//Aplicando gravidade
if (!_chao) {
	if (velv < max_velv * 2) { //Limitando velocidade de queda
	velv += GRAVIDADE * massa;
	}
}

//Iniciando a máquina de estado
switch (estado) {
	case "parado":
	{
		//Comportamento do estado
		sprite_index = spr_player_idle;
		
		//Condição de troca de estado
		//Movendo
		if (_right || _left) {
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
		
		break;
	}
	
	case "movendo":
	{
		//Comportamento do estado de movimento
		sprite_index = spr_player_andando;
		
		//Condição de troca de estado
		//Parado
		if (abs(velh) < .1) {
			estado = "parado";
			velh = 0;
		}
		else if (_jump) {
			estado = "pulando";
			image_index = 0;
			velv = -max_velv;
		}
		else if (_attack) {
			estado = "ataque";
			velh = 0;
			image_index = 0;
		}
		
		break;
	}
	
	case "pulando":
	{
		//Estou caindo
		if (velv > 0) {
				sprite_index = spr_player_fall;
		} else { 
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
		
		break;
	}
	
	case "ataque":
	{
		velh = 0;
		
		sprite_index = spr_player_ataque1;
		
		//Criando o objeto de dano
		if (image_index >= 2 && dano == noone && posso) {
			if (xscale == 1) {
				dano = instance_create_layer(x + sprite_width/5, y - sprite_height/2, layer, obj_dano);
				dano.dano = ataque;
				dano.pai = id;
				posso = false;
			}
			else if (xscale == -1) {
				dano = instance_create_layer(x + sprite_width/2.5, y - sprite_height/2, layer, obj_dano);
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
		
		break
	}
}