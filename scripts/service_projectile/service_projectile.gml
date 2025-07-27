global.service_projectile = {
	
	get_linear_height: function(timer, duration, height) {
		var strength = 2, // power of smooth curve
			smooth = 60; // time for smoothing in frames
		return height * (1 - power(max(0, timer - duration)/smooth, strength))
	},
	
	get_linear_angle: function(timer, duration, height) {
		var strength = 2;
		var smooth = 60;
		var a = 1000; // amplifier for angle

		if (timer <= duration) return 0;

		var base = (timer - duration) / smooth;
		return -a * height * strength / smooth * power(base, strength - 1);
	},
	
	get_curve_height: function(timer, duration, height) {
		return ((4*height*timer)/duration) * (1-(timer/duration))
	},
	
	get_curve_angle: function(timer, duration, height) {
		var a = 1000; // amplifier for angle
		return a * (4 * height / duration) * (1 - (2 * timer / duration));
	}

	
}