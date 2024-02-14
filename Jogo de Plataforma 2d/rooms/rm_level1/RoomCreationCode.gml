//criando o objeto game_control se não existe um desse no jogo
if (!instance_exists(obj_game_control)) {
instance_create_depth(0, 0, 0, obj_game_control);
}