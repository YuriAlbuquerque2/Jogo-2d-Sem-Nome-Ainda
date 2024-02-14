/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//controlando player
var _chao = place_meeting(x, y + 1, obj_chao);

var _left, _right, _jump;
_left = keyboard_check(inputs.left);
_right = keyboard_check(inputs.right);
_jump = keyboard_check_pressed(inputs.jump);

//só pode se controlar se não tomou dano
if (timer_dano <= 0) {
	velh = (_right - _left) * vel;	
}

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
	
	if (velv < 0) {
		//muda a sprite
		sprite_index = spr_player_jump;
	}
	else {
		//tá indo pra baixo então pode cair na cabeça do inimigo
		var _inimigo = instance_place(x, y + 5, obj_inimigo_basico);
		
		//se cair no inimigo dá dano nele
		if (_inimigo) {
			dano = false;
			//se o inimigo não tá morto
			if (_inimigo.morto == false) {
			//subo no ar novamente
			velv = -vel_jump;
			
			//avisando ao inimigo que foi acertado
			_inimigo.dano = true;
			}
		}
	}
	
	//aplicando gravidade
	velv += grav;
	
	if (velh != 0) {
		image_xscale = sign(velh);
	}
}

if (dano) {
	//muda a sprite (está faltando)
	
	velh = 0;
	
	if (posso_perder_vida) {
		global.vida--;	
		if (global.vida <= 0) {
			sprite_index = spr_player_dead;
			image_speed = 0;
			image_index = 9;
			if (image_alpha < 1) {
				image_alpha += 0.1;
			}
			
			timer_reinicia--;
			if (timer_reinicia <= 0) {
				global.vida = global.max_vida;
				game_restart();
			}
			exit;
		}
		else {
		posso_perder_vida = false;
		}
	}
}

//se o timer do dano é maior que zero, aumenta ele
if (timer_dano > 0) {
	timer_dano--;
}
else {
	dano = false;
	posso_perder_vida = true;
}
if (inv_timer > 0) {
	inv_timer--;
	
	image_alpha = .5;
}
else {
	image_alpha = 1;
}

//tomando dano
var _inimigo = instance_place(x, y, obj_inimigo_basico);
var _inimigob = instance_place(x, y, obj_inimigo_boss);

if (_inimigo && inv_timer <= 0) {
	
	if (_inimigo.morto == false && _inimigo.dano == false) {
	dano = true;
	
	//dando valor ao timer_dano
	timer_dano = tempo_dano;
	inv_timer = inv_tempo;
	}
}