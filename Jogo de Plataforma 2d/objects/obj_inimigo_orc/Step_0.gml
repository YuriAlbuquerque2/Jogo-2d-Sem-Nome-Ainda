/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

if (morto) {
	sprite_index = spr_inimigo_orc_morto;
	
	//sumindo após a morte
	if (image_speed <= 0) {
		image_alpha -= 0.01;
	}
	//quando sumir totalmente, não existe mais inimigo
	if (image_alpha <= 0) {
		instance_destroy();
	}
	
	exit;
}

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
	if (velh != 0 && dano == false) {
		sprite_index = spr_inimigo_orc_walk;
		image_xscale = sign(velh);
	}
	else {
		sprite_index = spr_inimigo_orc_idle;
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

//checando se tá tomando dano
if (dano && morto == false) {
	sprite_index = spr_inimigo_orc_dano;
	velh = 0;
}



