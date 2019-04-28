FrameCount += 1

var roundedX = 50 + (round((mouse_x - 50) / 100) * 100)
var roundedY = 50 + (round((mouse_y - 50) / 100) * 100)

var spd = 8

var sprite = ""

if (Fly && !Swim && !Dig) {
	sprite = "spr_Bird"
} else if (Fly && !Swim && Dig) {
	sprite = "spr_BirdRodent"
} else if (!Fly && !Swim && Dig) {
	sprite = "spr_Rodent"
} else if (!Fly && Swim && Dig) {
	sprite = "spr_RodentFish"
} else if (!Fly && Swim && !Dig) {
	sprite = "spr_Fish"
} else if (Fly && Swim && !Dig) {
	sprite = "spr_FishBird"
}

if (Sleeping || Tolled) {
	sprite += "Sleeping"
}

sprite_index = asset_get_index(sprite)

depth = -y

if (path_index != -1) {
	if (x < path_get_point_x(path_index, path_position)) {
		Flip = -1
	} else if (x > path_get_point_x(path_index, path_position)) {
		Flip = 1
	}
}

if (Selected) {
	image_xscale = (0.85 + (FrameCount % 30) / 100) * Flip
	image_yscale = 1.15 - (FrameCount % 30) / 100
} else {
	image_xscale = Flip
	image_yscale = 1
}

if (Carried > -1) {
	x += (Carried.x - x) / 5
	y += (Carried.y - 25 - y) / 5
	exit
}

var lay = layer_get_id("Tiles")
var tilemap = layer_tilemap_get_id(lay)

var sound

var path = path_add()
var map
if (Fly && !Swim && !Dig) {
	map = global.FlyMap
	sound = snd_Bird
} else if (Fly && !Swim && Dig) {
	map = global.WaterMap
	sound = snd_Rodent
} else if (!Fly && !Swim && Dig) {
	map = global.DigMap
	sound = snd_Rodent
} else if (!Fly && Swim && Dig) {
	map = global.PitMap
	sound = snd_Fish
} else if (!Fly && Swim && !Dig) {
	map = global.SwimMap
	sound = snd_Fish
} else if (Fly && Swim && !Dig) {
	map = global.WallMap
	sound = snd_Bird
}

if (!Selected) {
	if (!Sleeping) {
		if (position_meeting(roundedX, roundedY, id) && mouse_check_button_pressed(mb_left)) {
			with (par_Character) {
				if (Selected) {
					Selected = false
					Goal = ""
					path_end()
					x = 50 + (round((x - 50) / 100) * 100)
					y = 50 + (round((y - 50) / 100) * 100)
				}
			}
			Selected = true
			audio_play_sound(sound, 0, false)
			if (Tolled) {
				var toll = instance_nearest(x, y, obj_Toll)
				toll.Toll += 1
				Tolled = false
			}
		}
	}
} else {
	if (!Tolled && position_meeting(roundedX, roundedY, obj_Toll) && (mouse_check_button_pressed(mb_left) || mouse_check_button_pressed(mb_right))) {
		if (mp_grid_path(map, path, x, y, roundedX, roundedY, true)) {
			Goal = "Toll"
			GoalTarget = instance_nearest(roundedX, roundedY, obj_Toll)
			GoalX = roundedX
			GoalY = roundedY
			path_set_kind(path, 1)
			path_set_precision(path, 4)
			path_start(path, spd, path_action_stop, true)
		}
	} else if (!Tolled && !position_meeting(roundedX, roundedY, id) && position_meeting(roundedX, roundedY, par_Character) && mouse_check_button_pressed(mb_left)) {
		if (tilemap_get_at_pixel(tilemap, roundedX, roundedY) == 0 && mp_grid_path(map, path, x, y, roundedX, roundedY, true)) {
			if (Merged && Carrying == -1) {
				Goal = "Pickup"
				GoalTarget = instance_nearest(roundedX, roundedY, par_Character)
				GoalX = roundedX
				GoalY = roundedY
				path_set_kind(path, 1)
				path_set_precision(path, 4)
				path_start(path, spd, path_action_stop, true)
			}
		}
	} else if (!Tolled && !position_meeting(roundedX, roundedY, id) && position_meeting(roundedX, roundedY, par_Character) && mouse_check_button_pressed(mb_right)) {
		if (tilemap_get_at_pixel(tilemap, roundedX, roundedY) == 0 && mp_grid_path(map, path, x, y, roundedX, roundedY, true)) {
			if (!Merged) {
				Goal = "Merge"
				GoalTarget = instance_nearest(roundedX, roundedY, par_Character)
				GoalX = roundedX
				GoalY = roundedY
				path_set_kind(path, 1)
				path_set_precision(path, 4)
				path_start(path, spd, path_action_stop, true)
			} else if (Carrying == -1) {
				Goal = "Unmerge"
				GoalTarget = instance_nearest(roundedX, roundedY, par_Character)
				GoalX = roundedX
				GoalY = roundedY
				path_set_kind(path, 1)
				path_set_precision(path, 4)
				path_start(path, spd, path_action_stop, true)
			}
		}
	} else if (!position_meeting(roundedX, roundedY, par_Character) && mouse_check_button_pressed(mb_left)) {
		mp_grid_path(map, path, x, y, roundedX, roundedY, true)
		path_set_kind(path, 1)
		path_set_precision(path, 4)
		path_start(path, spd, path_action_stop, true)
	} else if (!position_meeting(roundedX, roundedY, par_Character) && mouse_check_button_pressed(mb_right)) {
		if (tilemap_get_at_pixel(tilemap, roundedX, roundedY) == 0 && mp_grid_path(map, path, x, y, roundedX, roundedY, true)) {
			if (Carrying > -1) {
				Goal = "Drop"
				GoalTarget = Carrying
				GoalX = roundedX
				GoalY = roundedY
				path_set_kind(path, 1)
				path_set_precision(path, 4)
				path_start(path, spd, path_action_stop, true)
			}
		}
	}
}

if (point_distance(x, y, GoalX, GoalY) < 8) {
	if (Goal == "Merge") {
		if (!GoalTarget.Sleeping && !GoalTarget.Tolled && !GoalTarget.Merged) {
			audio_play_sound(snd_Fuse, 0, false)
			Selected = false
			Sleeping = true
			if (Fly) {
				GoalTarget.Fly = true
			}
			if (Swim) {
				GoalTarget.Swim = true
			}
			if (Dig) {
				GoalTarget.Dig = true
			}
			GoalTarget.Selected = true
			GoalTarget.Merged = true
		}
	} else if (Goal == "Pickup") {
		GoalTarget.Carried = id
		Carrying = GoalTarget.id
	} else if (Goal == "Unmerge") {
		if (GoalTarget.Sleeping) {
			audio_play_sound(snd_Unfuse, 0, false)
			GoalTarget.Sleeping = false
			if (object_index == obj_Bird) {
				Swim = false
				Dig = false
			} else if (object_index == obj_Fish) {
				Fly = false
				Dig = false
			} else if (object_index == obj_Rodent) {
				Fly = false
				Swim = false
			}
			Merged = false
		}
	} else if (Goal == "Drop") {
		Carrying = -1
		with (GoalTarget) {
			if (Carried > -1) {
				x = other.GoalX
				y = other.GoalY
				Carried = -1
			}
		}
	} else if (Goal == "Toll") {
		audio_play_sound(snd_Fuse, 0, false)
		Tolled = true
		Selected = false
		GoalTarget.Toll -= 1
	} else {
		exit
	}
	if (Goal != "Pickup") {
		if (tilemap_get_at_pixel(tilemap, x, y + 100) == 0 && !position_meeting(GoalX, GoalY + 100, par_Character) && !position_meeting(GoalX, GoalY + 100, obj_Toll)) {
			mp_grid_path(map, path, x, y, x, y + 100, true)
			path_set_kind(path, 1)
			path_set_precision(path, 4)
			path_start(path, spd, path_action_stop, true)
		} else if (tilemap_get_at_pixel(tilemap, x, y - 100) == 0 && !position_meeting(GoalX, GoalY - 100, par_Character) && !position_meeting(GoalX, GoalY - 100, obj_Toll)) {
			mp_grid_path(map, path, x, y, x, y - 100, true)
			path_set_kind(path, 1)
			path_set_precision(path, 4)
			path_start(path, spd, path_action_stop, true)
		} else if (tilemap_get_at_pixel(tilemap, x + 100, y) == 0 && !position_meeting(GoalX + 100, GoalY, par_Character) && !position_meeting(GoalX + 100, GoalY, obj_Toll)) {
			mp_grid_path(map, path, x, y, x + 100, y, true)
			path_set_kind(path, 1)
			path_set_precision(path, 4)
			path_start(path, spd, path_action_stop, true)
		} else if (tilemap_get_at_pixel(tilemap, x - 100, y) == 0 && !position_meeting(GoalX - 100, GoalY, par_Character) && !position_meeting(GoalX - 100, GoalY, obj_Toll)) {
			mp_grid_path(map, path, x, y, x - 100, y, true)
			path_set_kind(path, 1)
			path_set_precision(path, 4)
			path_start(path, spd, path_action_stop, true)
		}
	}
	Goal = ""
	GoalTarget = -1
}