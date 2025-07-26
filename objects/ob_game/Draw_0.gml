switch (state) {
	case "start":
		var count = global.service_gamepad.get_count();
		var total = min(count + 1, 4);
		var enabled = global.service_gamepad.get_enabled();

		for (var i = 0; i < total; i++) {
			var _x = (i + 1) * room_width / (total + 1);
			var _y = room_height / 2;

			if (i < count) {
				draw_gamepad_idle(enabled[i], i, _x, _y);
			} else {
				draw_gamepad_join(i, _x, _y);
			}
		}
		break;
}
