/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

var _outro;
var _outro_lista = ds_list_create();
var _quantidade = instance_place_list(x, y, obj_entidade, _outro_lista, 0);

//Adicionando todo mundo que eu toquei na lista de aplicar dano
for (var _i = 0; _i < _quantidade; _i++) {
	//Checando o atual
	var _atual = _outro_lista[| _i];
	
	//Checando se a colisão não é com um filho do meu pai
	if (object_get_parent(_atual.object_index) != object_get_parent(pai.object_index)) {
		//Checar se o atual já está na lista
		var _pos = ds_list_find_index(aplicar_dano, _atual);
		if (_pos == -1) {
			//O atual ainda não está na minha lista de dano
			//Adiciona o atual na minha lista de dano
			ds_list_add(aplicar_dano, _atual);
		}
	}
}

//Aplicando o dano
var _tam = ds_list_size(aplicar_dano);
for (var _i = 0; _i < _tam; _i++) {
	_outro = aplicar_dano[| _i].id;
	if (global.vida_atual > 0 && obj_player.invulneravel == false) {
			_outro.estado = "hit";
			_outro.image_index = 0;
			global.vida_atual -= dano;
	} 
	instance_destroy();
}



//Destruindo as minhas listas
ds_list_destroy(aplicar_dano);
ds_list_destroy(_outro_lista);

instance_destroy();


/*//Se eu estou tocando em alguém
if (_outro) {
	//Se eu não estou tocando no meu pai
	if (_outro.id != pai) {
		
		var _papi = object_get_parent(_outro.object_index);
		if (_papi != object_get_parent(pai.object_index)) {
			
			if (_outro.vida_atual > 0) {
				_outro.estado = "hit";
				_outro.image_index = 0;
				_outro.vida_atual -= dano;
				instance_destroy();
			}
		}
	}
}