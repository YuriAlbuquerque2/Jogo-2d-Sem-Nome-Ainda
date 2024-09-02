/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

randomize();

//Criando a câmera
var _cam = instance_create_layer(x, y, layer, obj_camera);
_cam.alvo = id;

// Inherit the parent event
event_inherited();

max_velh = 4;
max_velv = 7;
dash_vel = 6;
dash = true;

mostra_estado = false;

dano = noone;
ataque = 1;
posso = true;	
invulneravel = false;
tempo_invulneravel = 0;

timer = -1;

pause_active = false; // Controla se o menu de pausa está ativo
pause_sel = 0; // Controla a seleção no menu de pausa
pause_options = ["Voltar ao jogo", "Carregar último save", "Controles", "Sair do jogo"]; // Opções do menu
confirm_exit = false; // Controla se a confirmação de saída está ativa
confirm_sel = 0; // Controle da seleção na confirmação de saída
show_no_save_message = false; // Controla se a mensagem "Não existe jogo salvo!" deve ser exibida
no_save_timer = 0; // Controla o tempo restante para a exibição da mensagem
control_type = global.controle; // 0 para 'Moderno', 1 para 'Clássico'

key_up = vk_up;
key_down = vk_down;
key_select = vk_enter;
key_back = vk_escape;