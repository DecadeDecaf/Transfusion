var lay = layer_get_id("Tiles")
var map = layer_tilemap_get_id(lay)

if (tilemap_get_at_pixel(map, x - 40, y) == 1 && tilemap_get_at_pixel(map, x + 40, y) == 1 && tilemap_get_at_pixel(map, x, y - 20) == 1 && tilemap_get_at_pixel(map, x, y + 20) == 1) {
	if (FrameCount % 5 == 0) {
		var bubble = instance_create_depth(x + random_range(-35, 35), y + random_range(-35, 35), depth, obj_Particle)
		bubble.sprite_index = spr_Bubble
		bubble.image_xscale = random_range(0.5, 1)
		bubble.image_yscale = bubble.image_xscale
	}
	exit
} else if (tilemap_get_at_pixel(map, x, y) == 2) {
	if (FrameCount % 5 == 0) {
		var rubble = instance_create_depth(x + random_range(-35, 35), y + random_range(-35, 35), depth, obj_Particle)
		rubble.sprite_index = spr_Rubble
		rubble.image_xscale = random_range(0.5, 1)
		rubble.image_yscale = rubble.image_xscale
	}
	exit
} else {
	draw_set_alpha(0.25)
	draw_set_color(c_black)
	draw_ellipse(x - 40, y - 20, x + 40, y + 20, false)

	draw_set_alpha(1)

	draw_self()	
}