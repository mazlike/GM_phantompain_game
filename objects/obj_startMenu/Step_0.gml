/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе
if keyboard_check_pressed(vk_down) then
begin
  if tpl = max_tpl then { tpl = min_tpl } // если дальше нет пунктов то возвращаемся на первый пункт.
  else // когда ниже есть пункт то
  {
  tpl += sel_space; // перемещаемся на указанный пробел между пунктами вниз.
  }
   
end;
if keyboard_check_pressed(vk_up) then
begin
  if tpl = min_tpl then { tpl = max_tpl } // если выше нет пунктов то переходим на последний пункт.
  else // когда выше есть пункт
  {
  tpl -= sel_space; // перемещаемся на указанный пробел между пунктами вверх.
  }

end;

if keyboard_check_pressed(vk_enter) then  
begin
	if tpl = sel0 { room_goto(rLvlOne)}
	if tpl = sel1 {  }
	if tpl = sel2 {  }
	if tpl = sel3 {  }
	if tpl = sel4 { game_end() }
end