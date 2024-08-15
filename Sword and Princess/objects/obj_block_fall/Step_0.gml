/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

if (global.perm_dash) {
	if (velv < max_velv * 2) { //Limitando velocidade de queda
		velv += GRAVIDADE * massa * global.vel_mult;
	}
}

if (global.caiu && y > 640) {
	instance_destroy();	
}