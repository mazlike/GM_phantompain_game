if (!global.pause) exit
var ds_grid = menu_pages[page], ds_height = ds_grid_height(ds_grid)

if (inputting)
{
	switch(ds_grid[# 1, menu_option[page]])
	{
		case menu_element_type.shift:
			var hinput = RIGHT - LEFT
			if (hinput != 0)
			{
				ds_grid[# 3, menu_option[page]] += hinput
				ds_grid[# 3, menu_option[page]] = clamp(ds_grid[# 3, menu_option[page]], 0, array_length_1d(ds_grid[# 4, menu_option[page]])-1)
				
			}
		break
		case menu_element_type.slider:
		switch (menu_option[page])
		{
			case 0: if (!audio_is_playing(snd_select)){ audio_play_sound(snd_select,1,false) break }
			case 1: if (!audio_is_playing(snd_voice1)){ audio_play_sound(snd_voice1,1,false) break }
			case 2: if (!audio_is_playing(snd_voice2)){ audio_play_sound(snd_voice2,1,false) break }
		}
			var hinput = D - A
			if (hinput != 0)
			{
				ds_grid[# 3, menu_option[page]] += hinput * 0.01
				ds_grid[# 3, menu_option[page]] = clamp(ds_grid[# 3, menu_option[page]], 0, 1)
				script_execute(ds_grid[# 2, menu_option[page]], ds_grid[# 3, menu_option[page]])
			}
		break
		case menu_element_type.toggle:
			var hinput = RIGHT - LEFT
			if (hinput != 0)
			{
				ds_grid[# 3, menu_option[page]] += hinput
				ds_grid[# 3, menu_option[page]] = clamp(ds_grid[# 3, menu_option[page]], 0, 1)
				
			}
		break
	}
	
} else {
	var ochange = DOWN - UP
	if (ochange != 0)
	{
		menu_option[page] += ochange	
		if (menu_option[page] > ds_height-1) { menu_option[page] = 0}
		if (menu_option[page] < 0) { menu_option[page] = ds_height - 1}
	}
}
if ENTER 
{
	switch(ds_grid[# 1, menu_option[page]])
	{
		case menu_element_type.script_runner: script_execute(ds_grid[# 2, menu_option[page]]) break
		case menu_element_type.page_transfer: page = ds_grid[# 2, menu_option[page]] break
		case menu_element_type.shift:
		case menu_element_type.slider:
		if (inputting)
		{
			if (ds_grid[# 0, menu_option[page]] == "MASTER")
			{
				ini_open("savedata.ini")
				ini_write_real("Test","MASTER", ds_grid[# 3, menu_option[page]])
				ini_close()
			}
			else if (ds_grid[# 0, menu_option[page]] == "SOUNDS")
			{
				ini_open("savedata.ini")
				ini_write_real("Test","SOUNDS", ds_grid[# 3, menu_option[page]])
				ini_close()
			}
			else if (ds_grid[# 0, menu_option[page]] == "MUSIC")
			{
				ini_open("savedata.ini")
				ini_write_real("Test","MUSIC", ds_grid[# 3, menu_option[page]])
				ini_close()
			}
		}
		inputting = !inputting
		break
		case menu_element_type.toggle: 
		if (inputting) 
		{
			script_execute(ds_grid[# 2, menu_option[page]], ds_grid[# 3, menu_option[page]])
		}
		inputting = !inputting
		break
	}
	
	//audio
}