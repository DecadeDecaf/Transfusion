if (room == rm_Menu) {
	exit
}

var bglay = layer_get_id("Background")
var bg = layer_background_get_id(bglay)
layer_background_index(bg, global.Level)

global.PitMap = mp_grid_create(0, 0, 16, 9, 100, 100)
global.WaterMap = mp_grid_create(0, 0, 16, 9, 100, 100)
global.WallMap = mp_grid_create(0, 0, 16, 9, 100, 100)

global.FlyMap = mp_grid_create(0, 0, 16, 9, 100, 100)
global.SwimMap = mp_grid_create(0, 0, 16, 9, 100, 100)
global.DigMap = mp_grid_create(0, 0, 16, 9, 100, 100)

var lay = layer_get_id("Tiles")
var map = layer_tilemap_get_id(lay)

for (var ix = 0; ix < 16; ix++) {
	for (var iy = 0; iy < 9; iy++) {
		if (tilemap_get(map, ix, iy) == 1) {
			mp_grid_add_cell(global.WaterMap, ix, iy)
			mp_grid_add_cell(global.FlyMap, ix, iy)
			mp_grid_add_cell(global.DigMap, ix, iy)
		} else if (tilemap_get(map, ix, iy) == 2) {
			mp_grid_add_cell(global.WallMap, ix, iy)
			mp_grid_add_cell(global.FlyMap, ix, iy)
			mp_grid_add_cell(global.SwimMap, ix, iy)
		} else if (tilemap_get(map, ix, iy) == 3) {
			mp_grid_add_cell(global.PitMap, ix, iy)
			mp_grid_add_cell(global.SwimMap, ix, iy)
			mp_grid_add_cell(global.DigMap, ix, iy)
		} else if (tilemap_get(map, ix, iy) == 4) {
			mp_grid_add_cell(global.PitMap, ix, iy)
			mp_grid_add_cell(global.WaterMap, ix, iy)
			mp_grid_add_cell(global.WallMap, ix, iy)
			mp_grid_add_cell(global.FlyMap, ix, iy)
			mp_grid_add_cell(global.SwimMap, ix, iy)
			mp_grid_add_cell(global.DigMap, ix, iy)
		}
	}
}