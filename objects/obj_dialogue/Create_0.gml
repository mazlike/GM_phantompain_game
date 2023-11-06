// disable player movement
global.moveble = false

ChatterboxLoadFromFile(file);
scribble_font_set_default("fnt_battleMenu")

typist = scribble_typist();
typist.in(0.5, 0);
typist.character_delay_add(".",500)
typist.character_delay_add(",",500)
typist.character_delay_add("?",500)
typist.character_delay_add("!",500)

// indicator of optionality 
hover			= 0

// settings for dialog box 
diabox_height   = 105
diabox_width    = 400
diabox_x		= display_get_gui_width()/2 - 200
diabox_y		= display_get_gui_height()/2 + 70

headbox_x		= diabox_x + diabox_width*0.5 - 50
headbox_y		= diabox_y - 30
headbox_height  = 25
headbox_width   = 100

// settings for text location
text_x_offset	 = 20
text_y_offset	 = 10
text_line_length = diabox_width - text_x_offset*2
