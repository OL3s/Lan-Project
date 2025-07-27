global.service_mob = {

	/// @function in_range
	/// @desc Check if nearest target is within range.
	/// @param {Id.Instance} _self
	/// @param {real} range
	/// @param {Asset.Object} target
	/// @return {bool}
	in_range: function(_self, range, target) {
		if (!instance_exists(_self)) return false;		
		var nearest = instance_nearest(_self.x, _self.y, target);
		if (nearest == noone) return false;

		with (_self) {
			return distance_to_object(nearest) < range;
		}
	},

	/// @function get_animate_movement
	/// @desc Return animated offset angle and jump based on timer.
	/// @param {real} timer
	get_animate_movement: function(timer) {
		var period_angle = 40, max_angle = 10;
		var period_jump = 15, max_jump = 3;

		var offset_angle = sin((2 * pi * timer) / period_angle) * max_angle;
		var offset_jump = abs(sin((pi * timer) / period_jump)) * max_jump;

		return {
			offset_angle: offset_angle,
			offset_jump: offset_jump
		}
	},
	
	get_animate_timer: function(animate_struct) {
		return animate_struct.timer	
	},
	
	create_animate_struct: function(scale) {
		return {
			timer: 0,
			xscale: scale,
			yscale: scale,
			angle: 0,
			xscale_target: scale,
			yscale_target: scale,
			scale: scale
		}
	},
	
	add_animate_squish: function(animate_struct, strength) {
		animate_struct.xscale -= strength * animate_struct.xscale_target;
		animate_struct.yscale += strength * animate_struct.yscale_target;
	},
	
	add_animate_flick: function(animate_struct, strength) {
		animate_struct.angle -= strength * animate_struct.xscale_target;
	},
	
	step_animate_struct: function(animate_struct, timer_add, timer_reset) {
		animate_struct.timer = (timer_reset) ? 0 : (animate_struct.timer + (timer_add == true));
		animate_struct.xscale = lerp(animate_struct.xscale, animate_struct.xscale_target, .1);
		animate_struct.yscale = lerp(animate_struct.yscale, animate_struct.yscale_target, .1);
		animate_struct.angle = lerp(animate_struct.angle, 0, .1)
	},
	
	set_animate_xscale: function(animate_struct, value) {
		animate_struct.xscale_target = value;
	},
	
	draw_shadow: function(instance) {
		if !instance_exists(instance) return;
		draw_set_alpha(0.4); draw_set_color(c_black);
		draw_rectangle(instance.bbox_left - 1, instance.bbox_bottom - 1, instance.bbox_right, instance.bbox_bottom, false)
		draw_set_alpha(1); draw_set_color(c_white);
	},
	
	/// @param {real} x - xpos
	/// @param {real} y - ypos
	/// @param {real} length - length of the bar
	/// @param {array<real>|undefined} health - health[current, max]
	/// @param {array<real>|undefined} stamina - stamina[current, max]
	/// @param {array<real>|undefined} mana - mana[current, max]
	draw_healthbarr: function(x, y, length, health, stamina = undefined, mana = undefined) {
		
		x = [x - (length/2), x + (length/2)]
		y = [y, y - 1, y - 2]
		
		if !is_undefined(health) {
			draw_line_width_color(x[0], y[0], x[1], y[0], 1, c_black, c_black);
			draw_line_width_color(x[0], y[0], x[0] + ((x[1] - x[0]) * (health[0]/health[1])), y[0], 1, c_red, c_red);
		}
		if !is_undefined(stamina) {
			draw_line_width_color(x[0], y[1], x[1], y[1], 1, c_black, c_black);
			draw_line_width_color(x[0], y[1], x[0] + ((x[1] - x[0]) * (stamina[0]/stamina[1])), y[1], 1, c_lime, c_lime);
		}
		if !is_undefined(mana) {
			draw_line_width_color(x[0], y[2], x[1], y[2], 1, c_black, c_black);
			draw_line_width_color(x[0], y[2], x[0] + ((x[1] - x[0]) * (mana[0]/mana[1])), y[2], 1, c_aqua, c_aqua);
		}
	}
}
