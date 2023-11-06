// disable player movement
global.moveble = false

ChatterboxLoadFromFile("testing.yarn");
scribble_font_set_default("fnt_battleMenu")
chatterbox = ChatterboxCreate("testing.yarn");
// Initialise Chatterbox by jumping to a node
ChatterboxJump(chatterbox,"Start");
// Get Content from Chatterbox
_speaker	= ChatterboxGetContentSpeaker(chatterbox,0)	
_speech		= ChatterboxGetContentSpeech(chatterbox,0)

typist = scribble_typist();
typist.in(0.5, 0);


// indicator of optionality 
hover			= 0
page			= 0
// settings for dialog box 
diabox_height   = 105
diabox_width    = 400
diabox_x		= camera_get_view_x(view_camera[0]) + 120
diabox_y		= camera_get_view_y(view_camera[0]) + 250

headbox_x		= diabox_x + diabox_width*0.5 - 50
headbox_y		= diabox_y - 30
headbox_height  = 25
headbox_width   = 100

// settings for text location
text_x_offset	 = 20
text_y_offset	 = 10
text_line_length = diabox_width - text_x_offset*2
