///@param dialogueFile
function create_dialogue(_dialogueFile)
{
	with instance_create_depth(
		camera_get_view_x(view_camera[0]),
		camera_get_view_y(view_camera[0]),
		99999,
		obj_dialogue,
		{file: _dialogueFile, init: "Start"}
	)
	{
		chatterbox = ChatterboxCreate(file);
		// Initialise Chatterbox by jumping to a node
		ChatterboxJump(chatterbox,init);
		// Get Content from Chatterbox
		_speaker	= ChatterboxGetContentSpeaker(chatterbox,0)	
		_speech		= ChatterboxGetContentSpeech(chatterbox,0)
	}
}

function add_good_karma()
{
	global.party[0].karma += 1
}

function add_bad_karma()
{
	global.party[0].karma -= 1
}
