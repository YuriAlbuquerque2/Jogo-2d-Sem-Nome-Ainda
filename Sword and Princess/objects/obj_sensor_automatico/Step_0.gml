/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//Checar se estou colidindo com o player
var _player = place_meeting(x, y, obj_player);

//O player está colidindo comigo
if (_player) {
	salvar_direcao("direcao.ini", obj_player.xscale);
	
	//Código da transição
	var _tran = instance_create_layer(0, 0, layer, obj_transicao);
		
		
	_tran.destino = destino;
	_tran.destino_x = destino_x;
	_tran.destino_y = destino_y;
}
