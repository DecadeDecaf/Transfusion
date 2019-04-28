image_index = max(0, Toll)

depth = -y

var cont = true

with (obj_Toll) {
	if (Toll > 0) {
		cont = false
	}
}

if (cont && alarm[0] == -1) {
	alarm[0] = 60
}