/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

if (y < room_height) {
	x = xstart;
	y += speed;
} else {
	x = xstart;
	y = ystart;
}

if (place_meeting(x, y, obj_player)) {
	global.vida_atual = 0;
}