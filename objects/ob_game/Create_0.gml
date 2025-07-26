state = "start";
draw_set_font(fnt_def)
#macro start_scale 2
#macro start_yoffset 32

draw_gamepad_idle = function(gamepad_index, offset, _x, _y) {
	draw_set_halign(fa_center);
	draw_text_transformed(_x, _y - start_yoffset, $"p{gamepad_index + 1}\n\n\n\nready", start_scale, start_scale, 0)
	draw_sprite_ext(sp_temp_8, 0, _x, _y, start_scale, start_scale, 0, global.service_gamepad.get_color(gamepad_index), 1);
	draw_set_halign(fa_left);
};
draw_gamepad_join = function(offset, _x, _y) {
	draw_set_halign(fa_center);
	draw_text_transformed(_x, _y - start_yoffset, "press\n\n\n\njoin", start_scale, start_scale, 0)
	draw_sprite_ext(sp_icon_gamepad, 0, _x, _y + sin(current_time/160), start_scale, start_scale, 0, c_white, 1);
	draw_set_halign(fa_left);
};

global.service_gamepad.enabled = [0, 0, 1, 0]