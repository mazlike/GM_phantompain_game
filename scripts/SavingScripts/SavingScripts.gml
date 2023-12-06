function save_to_json(data, file_path) 
{
	//Turn our data into a string 
	var json_str = json_stringify(data, true); 

	//Create our buffer and write to it 
	var len = string_byte_length(json_str); 
	var buff = buffer_create(len, buffer_fixed, 1); 
	buffer_write(buff, buffer_text, json_str); 

	//Save and delete 
	buffer_save(buff, file_path);
	buffer_delete(buff); 
}

function load_from_json(file_path) 
{ 
	//Loads the buffer from file; this creates buffer 
	var buff = buffer_load(file_path); 

	//Convert the data into a string 
	var str = buffer_read(buff, buffer_text); 

	//Convert our JSON string into GML data 
	var data = json_parse(str); 

	//All done; delete our buffer and return the data
	buffer_delete(buff); 

	return data; 
}

function load_master()
{
	ini_open("savedata.ini")
	master = ini_read_real("Test", "MASTER", 0.1)
	ini_close()	
	return master
}

function load_sounds()
{
	ini_open("savedata.ini")
	sounds = ini_read_real("Test", "SOUNDS", 0.1)
	ini_close()	
	return sounds
}

function load_music()
{
	ini_open("savedata.ini")
	music = ini_read_real("Test", "MUSIC", 0.1)
	ini_close()	
	return music
}

function save_game()
{
	if file_exists("savedata.json")
		global.game_data = load_from_json("savedata.json")
	var _array = []
	with obj_player
	{
		var _struct = 
		{
			object: object_get_name(object_index),
			x:	x,
			y:	y
		}
		array_push(_array, _struct)
	}
	
	with obj_golem
	{
		var _struct =
		{
			object: object_get_name(object_index),
			x:	x,
			y:	y
		}
		array_push(_array, _struct)
	}
	
	struct_set(global.game_data.room_data, room_get_name(room), _array)
	struct_set(global.game_data.player_data, "player", global.party.player)
	save_to_json(global.game_data, game_save_id + "savedata.json")
}

function load()
{
	if file_exists("savedata.json")
	{
		global.game_data = load_from_json("savedata.json")
	
		var _array = struct_get( global.game_data.room_data, room_get_name(room))
		if (_array != undefined)
		{
			instance_destroy( obj_player)
			instance_destroy( obj_golem)
			
			for (var i = 0; i < array_length(_array); i += 1)
			{
				var _struct = _array[i]
				instance_create_layer(_struct.x, _struct.y, "Instances", asset_get_index(_struct.object))
			}
			
		}
		var data = struct_get(global.game_data.player_data, "player")
		global.party.player = data
	}

}
