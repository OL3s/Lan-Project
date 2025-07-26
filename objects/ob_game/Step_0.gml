if state == "start" {

	// player join / leave
	for (var i = 0; i < 4; ++i) {
		var input = global.service_gamepad.get_buttons(i);
		
		if is_undefined(input) break;
		
		if (input.btn_a) global.service_gamepad.set_enable(i);
		if (input.btn_b) global.service_gamepad.set_disable(i)
	}

}