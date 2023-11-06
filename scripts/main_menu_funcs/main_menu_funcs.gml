///@arg ["Name1",type1,entries1...]
///@arg ["Name2",type2,entries2...]
function create_menu_page()
{
	var arg, i = 0;
	repeat(argument_count)
	{
		arg[i] = argument[i]
		i++
	}

	var ds_grid_id = ds_grid_create(5,argument_count)
	i = 0
	repeat (argument_count)
	{
		var array = arg[i]
		var array_len = array_length_1d(array)
	
		var xx = 0
		repeat(array_len)
		{
			ds_grid_id[# xx, i] = array[xx]
			xx++
		}
	
		i++
	}

	return ds_grid_id
}

function change_window_mode()
{
	switch(argument0)
	{
		case 0: window_set_fullscreen(false) break
		case 1: window_set_fullscreen(true) break
	}
}

function change_resolution()
{
	switch(argument0)
	{
		case 0: window_set_size(1280,720) break
		case 1: window_set_size(1920,1080) break
		case 2: window_set_size(2560,1440) break
	}
}

function change_volume()
{
	var type = menu_option[page]
	
	switch(type)
	{
		case 0: audio_master_gain(argument0) break
		case 1: audio_group_set_gain(audiogroup_soundeffects, argument0,0) break
		case 2: audio_group_set_gain(audiogroup_music, argument0,0) break
	}
}

function resume_game()
{
	instance_destroy()
}

function continue_game()
{
	instance_destroy()
}

function load_game()
{
	instance_destroy()
}

function new_game()
{
	room_goto_next()
}

function exit_game()
{
	game_end()
}