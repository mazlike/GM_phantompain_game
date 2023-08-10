// Ресурсы скриптов были изменены для версии 2.3.0, подробности см. по адресу
// https://help.yoyogames.com/hc/en-us/articles/360005277377
function DrawText(X,Y, colour,txt, space) {
	var corX = X
	var corY = Y
	var name = txt
	var selspace =  space
	var col = colour
	draw_set_font(fnt_menu)
	draw_set_color(col)
	draw_text(corX,corY + selspace, name)
}