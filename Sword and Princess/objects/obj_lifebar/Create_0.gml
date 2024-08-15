/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

view_w = camera_get_view_width(view_camera[0]);
view_h = camera_get_view_height(view_camera[0]);

life_max = 15 * global.dificuldade;
life = life_max;
life_feedback = life_max;
lifebar_w = 800;
lifebar_h = 20;


color1 = make_color_rgb(255, 0, 64);
color2 = make_color_rgb(19, 19, 19);