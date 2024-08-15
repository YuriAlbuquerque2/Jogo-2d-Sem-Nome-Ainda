/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

with (other) {
	global.som_cura++;
	if (global.vida_atual < 9) {
		global.vida_atual += 2;
		
	} else {
		global.vida_atual++;	
		
	}
	instance_destroy(obj_cura.id);
}