/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//controlando player
var _chao = place_meeting(x, y + 1, obj_chao);

var _left, _right, _jump;
_left = keyboard_check(inputs.left);
_right = keyboard_check(inputs.right);
_jump = keyboard_check_pressed(inputs.jump);

velh = (_right - _left) * vel;	

//pulando
if (_chao) {
if (_jump) {
	velv = -vel_jump;
}

if (velh != 0) {
	//muda a sprite
	sprite_index = spr_player_run;
	//olha pro lado que ta indo
	image_xscale = sign(velh);
}
else {
	sprite_index = spr_player_idle;
}
}
else { //não tá no chão
	
	//muda a sprite
	sprite_index = spr_player_jump;
	//aplicando gravidade
	velv += grav;
	
	if (velh != 0) {
		image_xscale = sign(velh);
	}
}