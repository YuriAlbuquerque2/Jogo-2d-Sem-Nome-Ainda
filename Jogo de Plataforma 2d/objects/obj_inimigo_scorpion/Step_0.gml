/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//checando se tá no chão
var _chao = place_meeting(x, y + 1, obj_chao);

if (_chao) {
	//Dimunindo tempo
	tempo_decidir_andar-= 1;
	
	if (tempo_decidir_andar <= 0) {
		andando = choose(true, false);
		
		//Escolhendo direção se decidir andar
		if (andando) {
		velh = choose(vel, -vel);
		}
		else {
			velh = 0;
		}
		//Resetando
		tempo_decidir_andar = room_speed * 3;
	}

	
	//Controlando a animação
	if (velh != 0) {
		sprite_index = spr_inimigo_scorpion_walk;
		image_xscale = sign(velh);
	}
	else {
		sprite_index = spr_inimigo_scorpion_idle;
	}
	
	//Se bater na parede muda de direção
	if (place_meeting(x + velh, y, obj_chao)) {
		velh *= -1;
	}
	
	//Se não pode cair, muda de direção
	if (pode_cair == false) { 
	if (place_meeting(x + (velh * 15), y + 1, obj_chao) == false) {
		//se não pode cair e não tá no chão
			velh *= -1;
	}
	}
}
else {
	velv += grav;
	velh = 0;
	
	if (velh != 0) {
		image_xscale = sign(velh);
	}
}



