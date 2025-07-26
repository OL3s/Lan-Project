global.service_mob = {

	/// @function in_range
	/// @desc Check if nearest target is within range.
	/// @param {instance} _self
	/// @param {real} range
	/// @param {object_index} target
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
		var period_jump = 15, max_jump = 2;

		var offset_angle = sin((2 * pi * timer) / period_angle) * max_angle;
		var offset_jump = abs(sin((pi * timer) / period_jump)) * max_jump;

		return {
			offset_angle: offset_angle,
			offset_jump: offset_jump
		}
	},
	
	draw_shadow: function(instance) {
		if !instance_exists(instance) return;
		draw_set_alpha(0.4); draw_set_color(c_black);
		draw_rectangle(instance.bbox_left - 1, instance.bbox_bottom - 1, instance.bbox_right, instance.bbox_bottom, false)
		draw_set_alpha(1); draw_set_color(c_white);
	}
}
