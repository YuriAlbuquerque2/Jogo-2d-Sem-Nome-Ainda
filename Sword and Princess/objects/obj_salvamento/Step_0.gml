/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

if (distance_to_object(obj_player) < 32 && keyboard_check_pressed(ord("S"))) {
	if (room = rm_cenario7) {
		global.salvamento = 1;
	}
	salvando();
}