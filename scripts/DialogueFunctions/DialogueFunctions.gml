///@param speakLine
function NewConversation(_speakLine)
{
	instance_create_depth(
		camera_get_view_x(view_camera[0]),
		camera_get_view_y(view_camera[0]),
		-99999,
		obj_dialogue,
		{speakLine: _speakLine}
	)
}

function  set_char_colour(_beginChar, _endChar, _clr)
{
	for (var c = _beginChar; c < _endChar; c++)
	{
		clrTL[c][page] = _clr
		clrTR[c][page] = _clr
		clrBR[c][page] = _clr
		clrBL[c][page] = _clr
	}
}

function set_char_shake(_beginChar, _endChar){
	for(var c = _beginChar; c < _endChar; c++){
		shakeText[c][page] = true
	}
}

function make_choice(_bad,_good)
{
	
	
}

function set_dialogue_pref(_text,_colour,_shake)
{
	for(var c = 0; c < messageSize; c++){
		var characterPosition = c + 1;
			
		// store individual characters in the characters array
		chars[c][page] = string_char_at(_text, characterPosition)
			
		// get current width of line
		var textUpToChar = string_copy(_text, 1, characterPosition)
		var currentTextWidth = string_width(textUpToChar) - string_width(chars[c][page])
			
		// get the last free space
		var characterToLookFor = " "; // in case you don't like ending on spaces :)
		if(chars[c][page]==" ") {
			lastSeenSpacePosition = characterPosition + string_length(characterToLookFor)
		}
			
		// get the line breaks
		var currentTextIsGreaterThanAvailableWidth = currentTextWidth - lineBreakOffset[page] > text_line_length
		if(currentTextIsGreaterThanAvailableWidth){
			/*
				Assuming our maximum line width could only hold "Hi!" of the string "Hi! I'm NPC 1.", we're essentially going to grab "Hi! I"
				Then manipulate the string for the offset down to just "Hi! ", this prevents us from starting the next line with a space.
					
				Another possible improvement here is inserting line breaks into the string, then drawing the string in one go if you run into performance issues.
				However, this system is explicitly designed to support DRAMA in your dialog presentation layer, so that's for another tutorial.
			*/ 
			lineBreakPosition[lineBreakNumber[page]][page] = lastSeenSpacePosition
			lineBreakNumber[page]++
			var textUpToLastSpace = string_copy(_text, 1, lastSeenSpacePosition)
			var lastFreeSpaceString = string_char_at(_text, lastSeenSpacePosition)
			lineBreakOffset[page] = string_width(textUpToLastSpace) - string_width(lastFreeSpaceString)
		}
	}
	// getting each characters coordinates
	for(var c = 0; c < messageSize; c++){
		var characterPosition = c + 1
		var textX = textbox_x + text_x_offset
		var textY = textbox_y + text_y_offset
			
		// get current width of line
		var textUpToChar = string_copy(_text, 1, characterPosition)
		var currentTextWidth = string_width(textUpToChar) - string_width(chars[c][page])
			
		var textLine = 0;
			
		// compensate for string breaks
		for(var lineBreak = 0; lineBreak < lineBreakNumber[page]; lineBreak++){
			if(characterPosition >= lineBreakPosition[lineBreak][page]){
				var strCopy = string_copy(_text, lineBreakPosition[lineBreak][page], characterPosition - lineBreakPosition[lineBreak][page])
				currentTextWidth = string_width(strCopy)
				textLine = lineBreak + 1
			}
		}
		// add to the x and y coordinates based on the new info
		characterXCoords[c][page] = textX + currentTextWidth
		characterYCoords[c][page]= textY + textLine * lineSpacing
	}
	
	if (_colour != -1)
	{
		for (var l = 0; l < array_length(_colour); l++)
		{
			set_char_colour(_colour[l][0],_colour[l][1],_colour[l][2])
		}
	}
	if (_shake != -1)
	{
		for (var l = 0; l < array_length(_shake); l++)
		{
			set_char_shake(_shake[l][0],_shake[l][1])
		}
	}	
}

function set_default_txt_settings()
{
	#region line break information
	lineBreakPosition[0][page] = 999
	lineBreakNumber[page] = 0
	lineBreakOffset[page] = 0
	#endregion
	
	isOptions[page] = false
	
	#region individual letter customization
	for(var c = 0; c < messageSize; c++)
	{
		clrTL[c][page] = c_white
		clrTR[c][page] = c_white
		clrBR[c][page] = c_white
		clrBL[c][page] = c_white
		shakeText[c][page] = false
		shakeDirection[c][page] = irandom(360)
		shakeTimer[c][vk_pagedown] = irandom(4)
	}
	#endregion
	
}

