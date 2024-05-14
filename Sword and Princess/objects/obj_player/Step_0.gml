/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//Iniciando variáveis
var _right, _left, _jump, _attack;
var _chao = place_meeting(x, y + 1, obj_block);

_right = keyboard_check(ord("D"));
_left = keyboard_check(ord("A"));
_jump = keyboard_check_pressed(ord("K"));

//Código de movimentação
velh = (_right - _left) * max_velh;

//Aplicando gravidade
if (!_chao) {
	if (velv < max_velv * 2) { //Limitando velocidade de queda
	velv += GRAVIDADE * massa;
	}
}
else { //Pulando se eu estou no chão
		if (_jump) {
			velv = -max_velv;		
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
		
		break;
	}
}