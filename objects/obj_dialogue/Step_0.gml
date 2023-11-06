if ChatterboxIsWaiting(chatterbox)
{
	// if we are want next to dialogue
	if (SPACE) && typist.get_state() == 1 
	{
		// next text line in .yarn file
		ChatterboxContinue(chatterbox)
		// receiving new datas 
		_speaker	= ChatterboxGetContentSpeaker(chatterbox,0)	
		_speech		= ChatterboxGetContentSpeech(chatterbox,0)
	}
	else if SPACE && typist.get_state() != 1
	{
		typist.skip()
	}
 }
else
{
	if (ChatterboxGetOptionCount(chatterbox)) //If Chatterbox is presenting the user with some options, check for that
	{
		var _select = undefined; // What the user selected.
		
		hover += UP - DOWN
		if (hover > ChatterboxGetOptionCount(chatterbox) -1) 
			hover = 0
		if (hover < 0) 
			hover = ChatterboxGetOptionCount(chatterbox) - 1
			
		//If we've pressed a button and text have typed, select that option
		if SPACE && typist.get_state() == 1 
			_select = hover
		
		if (_select != undefined) 
		{
			// next text line in .yarn file, which are	according to dialogue options are selected
			ChatterboxSelect(chatterbox, _select)
			// receiving new datas 
			_speaker	= ChatterboxGetContentSpeaker(chatterbox,0)	
			_speech		= ChatterboxGetContentSpeech(chatterbox,0)
		} 
	}
}

