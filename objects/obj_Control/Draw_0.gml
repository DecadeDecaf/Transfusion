var info = ""

switch (global.Level) {
	case 1: info = "Level 1#Click on a character to select them. Click somewhere else to move them."; break
	case 2: info = "Level 2#Not all characters can swim."; break
	case 3: info = "Level 3#Right click on a character to transfuse with them. Right click on the body to undo."; break
	case 4: info = "Level 4#Transfused characters can carry bodies by left clicking them. Right click on the ground to drop the body."; break
	case 5: info = "Level 5"; break
	case 6: info = "Level 6"; break
	case 7: info = "Level 7#All toll booths must be satisfied to continue."; break
	case 8: info = "Level 8#Characters may unfuse on any dead body."; break
	case 9: info = "Level 9"; break
	case 10: info = "Level 10#Nobody can pass through lava."; break
	case 11: info = "Level 11"; break
	case 12: info = "Level 12#This is the last level. Good luck."; break
	case 13: info = "This game was made in 48 hours for the Ludum Dare 44 compo. Hope you enjoyed!"; break
}

draw_set_font(fnt_Font)
draw_set_color(c_black)
draw_text(8, 10, string_hash_to_newline(info))
draw_set_color(c_white)
draw_text(10, 8, string_hash_to_newline(info))

if (room != rm_Menu) {
	draw_set_color(c_black)
	draw_text(8, 854, string_hash_to_newline("You can press R to restart a level."))
	draw_set_color(c_white)
	draw_text(10, 852, string_hash_to_newline("You can press R to restart a level."))
} else {
	draw_set_color(c_black)
	draw_text(8, 854, string_hash_to_newline("Made in 48 hours for the Ludum Dare 44 compo."))
	draw_set_color(c_white)
	draw_text(10, 852, string_hash_to_newline("Made in 48 hours for the Ludum Dare 44 compo."))
}