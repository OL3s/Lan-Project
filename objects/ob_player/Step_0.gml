var spd = .6,
	input_stick = global.service_gamepad.get_stick(0, true, true);
	
hspeed += input_stick.xaxis;
vspeed += input_stick.yaxis;
speed = clamp(speed - .4, 0, spd)

timer = (input_stick.active) ? timer + 1 : 0