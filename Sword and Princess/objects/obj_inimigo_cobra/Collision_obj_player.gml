/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

if (!other.invulneravel == true) {

	with (other) {
		if (obj_inimigo_cobra.estado != "dead" && estado != "dead" && room != rm_tutorial) {
		global.vida_atual = global.vida_atual - 1 * global.dificuldade;
		estado = "hit";	
		image_index = 0;
		}
	}
}