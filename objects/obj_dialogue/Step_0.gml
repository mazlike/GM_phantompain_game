
if (SPACE) && !isOptions[page]
{
	if drawchar == messageSize
	{
		if (page < maxpage)
		{
			page++
			drawchar = 0
		}
	}
	else
	{
		drawchar = messageSize	
	}
}


if (textPauseTimer <= 0)
{
	if drawchar <= messageSize
	{
		drawchar = drawchar + messageSpeed
		drawchar = clamp(drawchar,0,messageSize)
		var checkChar = string_char_at(text, drawchar);
			if(checkChar == "." || checkChar == "," || checkChar == "!" || checkChar == "?"){
				textPauseTimer = textPauseTime;
			}
	}
}
else
{
	textPauseTimer--	
}