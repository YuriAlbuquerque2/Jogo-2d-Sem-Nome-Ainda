/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

if (mudei) {
	alpha -= .05;
	 show_debug_message("Reduzindo alpha: " + string(alpha));
} else {
	alpha += .05;
	show_debug_message("Aumentando alpha: " + string(alpha));
}

//Quando o alpha passar de 1, mudo de room
if (alpha >= 1) {
	 show_debug_message("Mudando de room para: " + string(destino));
	 if (instance_exists(obj_player)) {
		instance_destroy(obj_player);
	 }
	 instance_create_layer(obj_sensor_automatico.destino_x, obj_sensor_automatico.destino_y - 90, layer, obj_player);
	 carregar_direcao("direcao.ini");
	 room_goto(destino);	
	
	//controlando a posição do player
	 obj_player.x = destino_x;
	 obj_player.y = destino_y;
}

//me destruindo
if (mudei && alpha <= 0) {
	 show_debug_message("Destruindo objeto de transição");
	instance_destroy();	
}