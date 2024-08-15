if (global.boss_morto && !instance_exists(obj_player)) {
	instance_create_layer(1248, 570, "Player", obj_player);	
} else if (!global.boss_morto && !instance_exists(obj_player)) {
	instance_create_layer(720, 570, "Player", obj_player);	
}