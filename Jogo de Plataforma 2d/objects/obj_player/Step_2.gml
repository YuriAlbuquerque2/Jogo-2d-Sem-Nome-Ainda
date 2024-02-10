/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//fazendo a colisão horizontal
var _col = instance_place(x + velh, y, obj_chao);
if (_col) {
	if (velh > 0) {
		x = _col.bbox_left + (x - bbox_right);
	}
	
	if (velh < 0) {
		x = _col.bbox_right + (x - bbox_left);
	}
	
	velh = 0;
}

//fazendo a colisão vertical
var _col = instance_place(x, y + velv, obj_chao);
if (_col) {
	if (velv > 0) {
		y = _col.bbox_top + (y - bbox_bottom);
	}
	
	if (velv < 0) {
		y = _col.bbox_bottom + (y - bbox.top);
	}
	
	velv = 0;
}
	

x += velh;
y += velv;