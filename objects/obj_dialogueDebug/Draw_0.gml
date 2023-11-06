if ChatterboxIsStopped(chatterbox)
{
	global.moveble = true
	instance_destroy()
}
else
{
	draw_sprite_stretched(spr_box, 0, diabox_x,diabox_y, diabox_width, diabox_height)
	draw_sprite_stretched(spr_heading_box, 0, headbox_x, headbox_y, headbox_width, headbox_height)
	
	var speaker = scribble(_speaker)
	speaker.align(fa_center,fa_center)
	speaker.blend(c_rye,1)
	speaker.draw(diabox_x + diabox_width*0.5, diabox_y - speaker.get_height());
	
	speech = scribble(_speech)
	speech.wrap(text_line_length, diabox_height-text_y_offset) 
	speech.draw(diabox_x + text_x_offset, diabox_y + text_y_offset, typist);
	var optCnt = ChatterboxGetOptionCount(chatterbox)
	
	if optCnt > 0
	{	// if speech typing is done => showing options
		if (typist.get_state() == 1)
		{
			for (var _i = 0; _i < optCnt; _i++)
			{
			
				var _option = "- " + ChatterboxGetOption(chatterbox, _i);
				option = scribble(_option) 
				if (hover == _i)
				{
					option.blend(#fcdd76,1)
				}
				else
				{
					option.blend(c_white,1)	
				}
				// drawing options
				option.draw(diabox_x + text_x_offset, diabox_y + text_y_offset + speech.get_height() + _i*20)
			}
		}
	}
}
