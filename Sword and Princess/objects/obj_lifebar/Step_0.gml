/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

life_feedback = approach(life_feedback, life, 0.2);

if (obj_controller.game_over) {
	instance_destroy();	
}