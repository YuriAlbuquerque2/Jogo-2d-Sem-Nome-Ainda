/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor





// Inherit the parent event
event_inherited();

dano = false;
morto = false;

muda_sprite = function(_sprite) {
	//checa se tá com a sprite certa
	if (sprite_index != _sprite) {
		sprite_index = _sprite;
		image_index = 0;
	}
}