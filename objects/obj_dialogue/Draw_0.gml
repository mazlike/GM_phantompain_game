if page == maxpage
{
	global.moveble = true
	instance_destroy()
}
else // needed for check - is message over?
{
	messageSize = string_length(speakLine[page].message)
}

draw_sprite_stretched(spr_box,0,textbox_x,textbox_y,textbox_width,textbox_height) 

draw_set_font(fnt_battleMenu)
draw_set_halign(fa_left)
draw_set_valign(fa_top)
set_default_txt_settings()

if page < maxpage
{
	// drawing name of speaker
	var name = speakLine[page].speaker.name
	draw_text_ext_color(textbox_x + text_x_offset,textbox_y + heading_y_offset,name,10,string_width(name),clr_heading,clr_heading,clr_heading,clr_heading,100)
	
	text = speakLine[page].message
	colour = speakLine[page].colours
	shake = speakLine[page].shakes
	
	set_dialogue_pref(text,colour,shake)
	
	if (speakLine[page].hasChoice)
	{
		draw_sprite_stretched(spr_box,0,textbox_x,textbox_y-50,textbox_width,textbox_height/4)
		set_dialogue_pref(speakLine[page].choices[0].text,speakLine[page].choices[0].colour,speakLine[page].choices[0].shake)
	}
	
	
	for (var c = 0; c < drawchar; c++)
	{
		var shakeX = 0;
		var shakeY = 0;
		if(shakeText[c][page])
		{
			shakeTimer[c][page]--;
			if(shakeTimer[c][page] <= 0)
			{
				shakeTimer[c][page] = irandom_range(4,8); // restart the count down with a bit of randomization	
				shakeDirection[c][page] = random(360);
			}
			if(shakeTimer[c][page] <= 3){
				shakeX = lengthdir_x(1, shakeDirection[c][page]);
				shakeY = lengthdir_y(1, shakeDirection[c][page]);
			}
		}
		
		draw_text_color(
		characterXCoords[c][page]+shakeX, characterYCoords[c][page]+shakeY,
		chars[c][page], 
		clrTL[c][page], clrTR[c][page], clrBR[c][page], clrBL[c][page], 1)
		
	}	
}

