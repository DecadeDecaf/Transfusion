var cont = true

with (obj_Toll) {
	if (Toll > 0) {
		cont = false
	}
}

if (cont) {
	scr_NextLevel()
}