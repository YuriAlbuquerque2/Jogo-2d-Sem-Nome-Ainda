/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
sel = 0;
marg_sel = 32;
marg_total = 32;

pag = 0;

tutorial = false;
tutorial_sel = 0;
tutorial_opcoes = ["Sim", "Não"];

confirmar_saida = false;
saida_sel = 0;

checar_save = false; // Controla a exibição do aviso sobre o save
checar_save_sel = 0;
apagar_save = false; // Controla o processo de apagar o save
apagar_save_opcoes = ["Sim", "Não"];

transicao_ativa = false;
transicao_alpha = 0;

existe_save = false;

chamou_sem_save = false;

#region métodos

//Desenha menu
desenha_menu = function(_menu) {
	draw_set_font(fnt_menu);
	define_align(1, 0);
	//Desenhando o menu
	var _qtd = array_length(_menu);
	var _alt = display_get_gui_height();
	var _larg = display_get_gui_width();

	var _espaco_y = string_height("I") + 16;
	var _alt_menu = _espaco_y * _qtd;
	
	draw_set_color(-1);



	for (var _i = 0; _i < _qtd; _i++) {
		var _cor = c_black, _marg_x = 0;
	
		var _texto = _menu[_i][0];
	
		if (menus_sel[pag] == _i) {
			_cor = c_yellow;
			_marg_x = marg_sel;
		}
	
		draw_text_color(20 + _marg_x, (_alt / 2) - _alt_menu/2 + (_i * _espaco_y), _texto, _cor, _cor, _cor, _cor, 1);
	}
	
	for (var _i = 0; _i < _qtd; _i++) {
		switch (_menu[_i][1]) {
			case MENU_ACOES.AJUSTES_MENU :
			{
				var _indice = _menu[_i][3];
				var _txt = _menu[_i][4][_indice];
				
				var _esq = _indice > 0 ? "<< " : "";
				var _dir = _indice < array_length(_menu[_i][4]) - 1 ? " >>" : "";
				
				var _cor = c_black;
				if (alterando && menus_sel[pag] == _i) {
					_cor = c_red;	
				}
				
				draw_text_color(_larg / 2, (_alt / 2) - _alt_menu/2 + (_i * _espaco_y), _esq + _txt + _dir, _cor, _cor, _cor, _cor, 1);
				draw_set_font(-1);
				break;
				}
			}
		}
		draw_set_font(fnt_normal);
		draw_set_color(c_black);
		draw_sprite(spr_cima, -1, (_larg / _larg) + 1000, _alt - 80);
		draw_text((_larg / _larg) + 1025, _alt - 68, "Cima");
		draw_sprite(spr_baixo, -1, (_larg / _larg) + 1115, _alt - 80);
		draw_text((_larg / _larg) + 1140, _alt - 68, "Baixo");
		draw_sprite(spr_enter, -1, (_larg / _larg) + 1245, _alt - 80);
		draw_text((_larg / _larg) + 1275, _alt - 68, "Confirma");
		draw_text((_larg / _larg) + 1000, _alt - 40, "Recomendado jogar em tela cheia");
		draw_set_font(-1);
		draw_set_color(-1);
		define_align(-1, -1);	
	}
	


controla_menu = function(_menu) {
	var _up, _down, _avanca, _recua, _left, _right;
	
	var _sel = menus_sel[pag];
	
	static _animar = false;

	_up = keyboard_check_pressed(vk_up);
	_down = keyboard_check_pressed(vk_down);
	_avanca = keyboard_check_released(vk_enter);
	_recua = keyboard_check_released(vk_escape);
	_left = keyboard_check_pressed(vk_left);
	_right = keyboard_check_pressed(vk_right);

	if (transicao_ativa) {
		transicao_alpha += 0.05;
		if (transicao_alpha >= 1) {
			if (confirmar_saida) {
				game_end();
			} else {
				room_goto(rm_explicacao);
				instance_create_layer(640, 520, layer, obj_player);
			}
		}
		return;
	}
	
	if (checar_save) {
        if (_up || _down) {
			audio_play_sound(snd_navega, 2, false);
            checar_save_sel = !checar_save_sel; // Alterna entre 0 (Sim) e 1 (Não)
        }

        if (_avanca) {
			audio_play_sound(snd_confirma, 2, false);
            if (checar_save_sel == 0) { // "Sim"
				apaga_save_e_mostra_tutorial();
            } else { // "Não"
               checar_save = false;
            }
        }
        return;
    }
	
	if (confirmar_saida) {
        if (_up || _down) {
			audio_play_sound(snd_navega, 2, false);
            saida_sel = !saida_sel; // Alterna entre 0 (Sim) e 1 (Não)
        }

        if (_avanca) {
			audio_play_sound(snd_confirma, 2, false);
            if (saida_sel == 0) { // "Sim"
                transicao_ativa = true;
            } else { // "Não"
                confirmar_saida = false;
            }
        }
        return;
    }

	 if (tutorial) {
		// Controle para a seleção do tutorial
		 if (_up || _down) {
			 audio_play_sound(snd_navega, 2, false);
            tutorial_sel = !tutorial_sel; // Alterna entre 0 (Sim) e 1 (Não)
        }

        if (_avanca) {
			audio_play_sound(snd_confirma, 2, false);
			transicao_ativa = true;
            if (tutorial_sel == 0) {
               room_goto(rm_tutorial);
            } else {
				transicao_ativa = true;
                room_goto(rm_explicacao);
            }
            
        }
        return;
    }
		else {
		if (!alterando) {
			if (_up || _down) {
				audio_play_sound(snd_navega, 2, false);
				menus_sel[pag] += _down - _up;
	
				var _tam = array_length(_menu) - 1;
				menus_sel[pag] = clamp(menus_sel[pag], 0, _tam);
		
				_animar = true;
			}	
		} else {
			_animar = false;
		
			if (_right || _left) {
				audio_play_sound(snd_navega, 2, false);
				var _limite = array_length(_menu[_sel][4]) - 1;
			
				menus[pag][_sel][3] += _right - _left;
			
				menus[pag][_sel][3] = clamp(menus[pag][_sel][3], 0, _limite);
			}
		}
	
		if (_avanca) {
			audio_play_sound(snd_confirma, 2, false);
			switch(_menu[_sel][1]) {
				case MENU_ACOES.RODA_METODO: _menu[_sel][2](); break;		
				case MENU_ACOES.CARREGA_MENU:	pag = _menu[_sel][2]; break;	
				case MENU_ACOES.AJUSTES_MENU: 
					alterando = !alterando; 
				
					if (!alterando) {
						var _arg = _menu[sel][3];
						_menu[_sel][2](_arg);	
					}
				
					break;
			}
		}
	
		if (_animar) {
			marg_sel = marg_total * valor_ac(ac_margem, _up ^^ _down);
		}
	}
}


sem_save = function() {
	draw_set_font(fnt_normal);
	draw_set_color(c_black);
	
	var _larg = display_get_gui_width();
	var _alt = display_get_gui_height();
	
	draw_text(_larg - 300, _alt - 1000, "Não existe jogo salvo!");
	
	draw_set_font(-1);
	draw_set_color(-1);	
} 

apaga_save_e_mostra_tutorial = function() {
    if (file_exists("save.ini")) {
        file_delete("save.ini");
    }
    checar_save = false; // Reseta a flag de checagem de save
    tutorial = true; // Mostra a pergunta sobre o tutorial
};

checar_outra_acao = function() {
    checar_save = true; // Exibe o aviso sobre o save
};

inicia_jogo = function() {
	global.carregando = true;
	
	if (file_exists("save.ini")) {
        checar_save = true; // Exibe a pergunta sobre apagar o save
    } else {
        tutorial = true; // Vai direto para a pergunta do tutorial
    }
}

carrega_jogo = function() {
	if (file_exists("save.ini")) {
		existe_save = true;
		if (existe_save) {
			sys_load("save.ini");	
		}
	} else {
		global.carregando = false;
		chamou_sem_save = true;
	}
}

fecha_jogo = function() {
	confirmar_saida = true;
}

ajusta_tela = function(_valor) {
		switch (_valor) {
			//tela cheia
			case 0:	window_set_fullscreen(true); break;
			//restaurado
			case 1: window_set_fullscreen(false); break;
		}
}

ajusta_dificuldade = function(_valor) {
	switch (_valor) {
		case 0: global.dificuldade = .5; break;
		case 1: global.dificuldade = 1; break;
		case 2: global.dificuldade = 1.5; break;
		case 3: global.dificuldade = 3; break;
	}
}

teste = function() {
	show_message("teste");	
}

#endregion


menu_principal = [
					["Novo Jogo", MENU_ACOES.RODA_METODO, inicia_jogo],
					["Continuar", MENU_ACOES.RODA_METODO, carrega_jogo],
					["Opções", MENU_ACOES.CARREGA_MENU, MENUS_LISTA.OPCOES],
					["Sair", MENU_ACOES.RODA_METODO, fecha_jogo]
				 ];
				 
menu_opcoes = [
				["Tipo de janela", MENU_ACOES.CARREGA_MENU, MENUS_LISTA.TELA],
				["Dificuldade", MENU_ACOES.CARREGA_MENU, MENUS_LISTA.DIFICULDADE],
				["Voltar", MENU_ACOES.CARREGA_MENU, MENUS_LISTA.PRINCIPAL]
			  ];

menu_dificuldade = [
						["Dificuldade", MENU_ACOES.AJUSTES_MENU, ajusta_dificuldade, 1, ["Fácil", "Normal", "Difícil", "Impossível"]],
						["Voltar", MENU_ACOES.CARREGA_MENU, MENUS_LISTA.OPCOES]
				   ];

menu_tela = [
				["Tipo de tela", MENU_ACOES.AJUSTES_MENU, ajusta_tela, 1, ["Tela cheia", "Janela"]],
				["Voltar", MENU_ACOES.CARREGA_MENU, MENUS_LISTA.OPCOES]
		    ];


menus = [menu_principal, menu_opcoes, menu_tela, menu_dificuldade];

menus_sel = array_create(array_length(menus), 0);

alterando = false;