/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


//desenhando a quantidade de vida
var _x = 20;
var _y = 40;
var _qtd = 45;

//desenhando um coração por vida
repeat(global.vida) {
	desenha_coracao(_x, _y);	
	
	//o x aumenta em 1td
	_x += _qtd;
}

