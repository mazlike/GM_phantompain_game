/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе
if tpl = sel0 { DrawText(x,y,sel_color,"Start game",sel0) } else { DrawText(x,y,def_color,"Start game",sel0) } // Если выделен пункт sel0 то рисуем его с цветом выделения, иначе рисуем его с цветом по умолчанию!
if tpl = sel1 { DrawText(x,y,sel_color,"Settings", sel1) } else { DrawText(x,y,def_color,"Settings",sel1) }  
if tpl = sel2 { DrawText(x,y,sel_color,"Load", sel2) } else { DrawText(x,y,def_color,"Load",sel2) }  
if tpl = sel3 { DrawText(x,y,sel_color,"Save", sel3) } else { DrawText(x,y,def_color,"Save",sel3) }  
if tpl = sel4 { DrawText(x,y,sel_color,"Exit", sel4) } else { DrawText(x,y,def_color,"Exit",sel4) }  

draw_sprite_ext(spr_pointer,0,x-20,y+tpl+15,2,2,0,c_white,100); // рисуем стрелку которая будет сбоку от выделенного текста!