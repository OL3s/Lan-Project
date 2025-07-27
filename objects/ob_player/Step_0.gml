var spd = .6,
	input_stick = global.service_gamepad.get_stick(0, true, true);
	
hspeed += input_stick.xaxis;
vspeed += input_stick.yaxis;
speed = clamp(speed - .4, 0, spd)

global.service_mob.step_animate_struct(animate, input_stick.active, !input_stick.active)
if hspeed != 0 {global.service_mob.set_animate_xscale(animate, sign(hspeed))}

if keyboard_check_pressed(vk_space) {
	global.service_mob.add_animate_squish(animate, .9)
}

if keyboard_check_pressed(vk_control)
	global.service_mob.add_animate_flick(animate, 30)