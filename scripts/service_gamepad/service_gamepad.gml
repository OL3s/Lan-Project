global.service_gamepad = {
	
	// variables
	enabled: array_create(4, false),
	deadzone: .1,
	
	/// @function get_stick
	/// @desc Get analog stick or keyboard movement input as a struct with x, y, direction, strength.
	/// @param {real} gamepad_index - Gamepad index [0–3]
	/// @param {bool} is_left - (def: true) - true = left stick / WASD, false = right stick / arrow keys
	/// @param {bool} is_keyboard - (def: false) - true = use keyboard instead of gamepad
	get_stick: function(gamepad_index, is_left = true, is_keyboard = false) {
		var xaxis, yaxis;

		if (is_keyboard) {
			if (is_left) {
				xaxis = keyboard_check(ord("D")) - keyboard_check(ord("A"));
				yaxis = keyboard_check(ord("S")) - keyboard_check(ord("W"));
			} else {
				xaxis = keyboard_check(vk_right) - keyboard_check(vk_left);
				yaxis = keyboard_check(vk_down) - keyboard_check(vk_up);
			}
		} else {
			xaxis = gamepad_axis_value(gamepad_index, is_left ? gp_axislh : gp_axisrh);
			yaxis = gamepad_axis_value(gamepad_index, is_left ? gp_axislv : gp_axisrv);
		}

		var dir = 0;
		var str = 0;
		var above_deadzone = abs(xaxis) > self.deadzone || abs(yaxis) > self.deadzone;

		if (above_deadzone) {
			dir = point_direction(0, 0, xaxis, yaxis);
			str = point_distance(0, 0, xaxis, yaxis);
			str = clamp((str - self.deadzone) / (1 - self.deadzone), 0, 1);
			xaxis = lengthdir_x(str, dir);
			yaxis = lengthdir_y(str, dir);
		}

		return {
			active: above_deadzone,
			xaxis: above_deadzone ? xaxis : 0,
			yaxis: above_deadzone ? yaxis : 0,
			direction: dir,
			strength: str
		};
	},


	/// @function get_buttons
	/// @desc Get basic face button states (A, B, X, Y).
	/// @param {real} gamepad_index - Gamepad index [0–3]
	get_buttons: function(gamepad_index) {
		
		// return if missing gamepad
		if !self.get_enable(gamepad_index) return {
			btn_a: false,
			btn_b: false,
			btn_x: false,
			btn_y: false
		}
		
		// return buttons
		return {
			btn_a: gamepad_button_check(gamepad_index, gp_face1),
			btn_b: gamepad_button_check(gamepad_index, gp_face2),
			btn_x: gamepad_button_check(gamepad_index, gp_face3),
			btn_y: gamepad_button_check(gamepad_index, gp_face4)
		}
		
	},
	
	/// @function get_count
	/// @desc Get number of enabled gamepads.
	/// @return {real}
	get_count: function() {
		var count = 0;
		for (var i = 0; i < array_length(self.enabled); ++i) {
		    count += (self.enabled[i] == true)
		}
		return count
	},
	
	/// @function set_enable
	/// @desc Enable gamepad by index.
	/// @param {real} gamepad_index - Gamepad index [0–3]
	set_enable: function(gamepad_index) {
		try {
			self.enabled[gamepad_index] = true;
		} catch (e) {
			show_debug_message("warning: gamepad set_enable out of bounds")
		}
	},

	/// @function set_disable
	/// @desc Disable gamepad by index.
	/// @param {real} gamepad_index - Gamepad index [0–3]
	set_disable: function(gamepad_index) {
		try {
			self.enabled[gamepad_index] = false;
		} catch (e) {
			show_debug_message("warning: gamepad set_disable out of bounds")
		}
	},
	
	/// @function get_enabled
	/// @desc Return array of enabled gamepad indexes.
	/// @return {array<real>}
	get_enabled: function() {
		var enabled = []
		for (var i = 0; i < array_length(self.enabled); ++i) {
		    if (self.enabled[i] == true)
			array_push(enabled, i)
		}
		return enabled;
	},
	
	/// @function get_enable
	/// @desc Check if gamepad index is enabled.
	/// @param {real} gamepad_index - Gamepad index [0–3]
	/// @return {bool}
	get_enable: function(gamepad_index) {
		
		// get enable bool 
		try {
			return (self.enabled[gamepad_index]) ?? false
			
		// return false if try/catch fail
		} catch (e) {
			show_debug_message("warning: gamepad index out oof bounds in get_enable")
			return false
		}
	},
	
	/// @function get_color
	/// @desc Return a unique color for each gamepad index (0–3). Defaults to white.
	/// @param {real} gamepad_index - Gamepad index [0–3]
	/// @return {color} Color constant (e.g., c_aqua, c_lime, etc.)
	get_color: function(gamepad_index) {
		switch (gamepad_index) {
			case 0: return c_aqua;
			case 1: return c_lime;
			case 2: return c_yellow;
			case 3: return c_purple;
			default: return c_white;
		}
	} 
	
}