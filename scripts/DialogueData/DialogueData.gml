var _choices =
{
	devour:
	{
		text: "I wish to devour you...",
		colour: [[10,23,c_darkbordo]],
		shake: [[17,23]]
	},
	
	symbiosis:
	{
		text: "I think, i can work with you!",
		colour: -1,
		shake: -1
	}
	
}

#region extending colours

#macro c_darkbordo #290009


#endregion

#region list of speakers

var _speakers =
{
	player:
	{
		name: "Player",
		image: spr_playerIdleSide
		
	},
	aiden:
	{
		name: "Aiden",
		image: spr_aiden
	}

}

#endregion

global.dialogue = {}

#region aiden meeting
global.dialogue.aiden_meet =
[
	{
		speaker: _speakers.aiden,
		message: "He-e-elp! I don't know, where I am... ",
		colours: [[0,9,c_darkbordo]],
		shakes: [[0,9]],
		hasChoice: false
	},
	
	{
		speaker: _speakers.player,
		message: "I'm here, I can help you!",
		colours: -1,
		shakes: -1,
		hasChoice: false
	},
	{
		speaker: _speakers.aiden,
		message: "Can we make a alliance???",
		colours: -1,
		shakes: -1,
		hasChoice: true,
		choices: [_choices.devour,_choices.symbiosis]
		
	}
]

#endregion