/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

if (place_meeting(x, y, obj_player)) {
	global.caiu = true;
	visible = false;	
	if (instance_exists(obj_block_fall)) {
		if (global.perm_dash) {
			if (obj_block_fall.velv < obj_block_fall.max_velv * 2) { //Limitando velocidade de queda
				obj_block_fall.velv += GRAVIDADE * obj_block_fall.massa * global.vel_mult;
	}	
		}
	}
}