global.service_gamepad = {
	enabled: array_create(4, false),
	deadzone: .1,
	get_stick_left: function(gamepad_index) {

		// get variables
		var 
		xaxis = gamepad_axis_value(gamepad_index, gp_axislh),
		yaxis = gamepad_axis_value(gamepad_index, gp_axislv),
		dir = 0,
		str = 0,
		above_deadzone = abs(xaxis) > self.deadzone || abs(yaxis) > self.deadzone;
		
		// add for deadzone variables
		if (above_deadzone) {
			dir = point_direction(0, 0, xaxis, yaxis)
			str = point_distance(0, 0, xaxis, yaxis)
			xaxis = xaxis
			yaxis = yaxis
		}
			
		// return gamepad
		return {
			xaxis: above_deadzone ? xaxis : 0,
			yaxis: yaxis ? yaxis : 0,
			direction: dir,
			strength: str
		}
	},
	
	get_count: function() {
		var count = 0;
		for (var i = 0; i < array_length(self.enabled); ++i) {
		    count += (self.enabled[i] == true)
		}
		return count
	},
	
	set_enable: function(gamepad_index) {
		try {
			self.enabled[gamepad_index] = true;
		} catch (e) {
			show_debug_message("warning: gamepad enable out of bounds")
		}
	},
	
	set_disable: function(gamepad_index) {
		try {
			self.enabled[gamepad_index] = false;
		} catch (e) {
			show_debug_message("warning: gamepad disable out of bounds")
		}
	},
	
	get_enabled: function() {
		var enabled = []
		for (var i = 0; i < array_length(self.enabled); ++i) {
		    if (self.enabled[i] == true)
			array_push(enabled, i)
		}
		return enabled;
	}
	
}