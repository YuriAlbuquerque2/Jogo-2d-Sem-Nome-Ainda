// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações

function action_end() {
	with (obj_cutscene) {
		action++;
	
		if action >= array_length(cutscene) {
			instance_destroy();	
			room_goto(rm_cenario8);
			instance_create_layer(640, 520, layer, obj_player);
		}
	}
}

function cutscene_wait(_segundos){
	timer++;
	
	if timer >= game_get_speed(gamespeed_fps) * _segundos {
		timer = 0;
		action_end();
	}
}

function cutscene_move_character(_id, _x, _y, _relative, _spd) {
	if x_dest == -1 {
		if _relative == false {
			x_dest = _x;	
			y_dest = _y;
		} else {
			x_dest = _id.x + _x;
			y_dest = _id.y + _y;
		}
	}
	var _xx = x_dest;
	var _yy = y_dest;
	
	with(_id) {
		if point_distance(x, y, _xx, _yy) >= _spd {
			var _dir = point_direction(x, y, _xx, _yy);
			var _hspd = lengthdir_x(_spd, _dir);
			var _vspd = lengthdir_y(_spd, _dir);
		
			x += _hspd;
			y += _vspd;
		} else {
			x = _xx;
			y = _yy;
			
			obj_cutscene.x_dest = -1;
			obj_cutscene.y_dest = -1;
			action_end();
		}
	}
}

function cutscene_play_sound(_sound, _loop) {
	audio_play_sound(_sound, 2, _loop);
	
	action_end();
}


function cutscene_instance_create(_x, _y, _layer, _obj) {
	instance_create_layer(_x, _y, _layer, _obj);
	
	action_end();
}

function cutscene_instance_destroy(_obj) {
	instance_destroy(_obj);
	
	action_end();
}

function cutscene_xscale(_id, _xscale) {
	if _xscale != undefined {
		_id.image_xscale = _xscale;
	} else{
		_id.image_xscale *= -1;
	}
	
	action_end();
}

function cutscene_change_sprite(_obj, _spr) {
	_obj.image_index = 0;
	_obj.sprite_index = _spr;
	
	action_end();
}

function cutscene_change_variable(_id, _varstring, _value) {
	variable_instance_set(_id, _varstring, _value);
	
	action_end();
}

function cutscene_dialogo(_npc_nome) {
    instance_create_layer(0, 0, layer, obj_dialogo);
	obj_dialogo.npc_nome = _npc_nome;
	if (obj_dialogo.pagina == 3) {
		global.dialogo = false;
		action_end();	
	}
}

function cutscene_destruir_dialogo() {
	if (instance_exists(obj_dialogo)) {
		instance_destroy(obj_dialogo);	
	}
	action_end();
}