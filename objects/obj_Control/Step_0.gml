if (keyboard_check_pressed(ord("F"))) {
	if (window_get_fullscreen()) {
		window_set_fullscreen(false)
	} else {
		window_set_fullscreen(true)
	}
}

if (keyboard_check_pressed(vk_escape)) {
	if (room == rm_Menu) {
		game_end()
	} else {
		game_restart()
	}
}

if (keyboard_check_pressed(ord("M"))) {
	if (global.Mute) {
		audio_master_gain(1)
		global.Mute = false
	} else {
		audio_master_gain(0)
		global.Mute = true
	}
}

if (room != rm_Menu) {
	if (keyboard_check_pressed(ord("S"))) {
		scr_NextLevel()
	}

	if (keyboard_check_pressed(ord("R"))) {
		room_restart()
	}
}

if (mouse_check_button_pressed(mb_left) && room == rm_Menu) {
	audio_stop_all()
	audio_play_sound(snd_Game, 1, true)
	scr_NextLevel()
}