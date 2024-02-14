/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


//se tá usando sprite de dano e a animação acabou, morre
if (sprite_index == spr_inimigo_scorpion_dano) {
	morto = true;
}

if (sprite_index == spr_inimigo_scorpion_morto) {
	image_speed = 0;
	image_index = 19;
}

