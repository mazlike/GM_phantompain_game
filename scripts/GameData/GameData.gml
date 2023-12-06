global.game_data = 
{	
	room_data: {},
	player_data: {}
}

enum MODE
{
	NEVER = 0,
	ALWAYS = 1,
	VARIES = 2
}

//Action Library
global.actionLibrary =
{
	attack :
	{
		name: "Attack",
		description: "{0} attacks!",
		subMenu: -1,
		mpCost: 0,
		targetRequired: true,
		targetEnemyByDefault: true,
		targetAll: MODE.NEVER,
		userAnimation: "attack",
		effectSprite: spr_hitEffect,
		effectOnTarget: MODE.ALWAYS,
		func : function(_user, _targets)
		{
			var _damage = ceil(_user.strength + random_range(-_user.strength * 0.25, _user.strength * 0.25))
			BattleChangeHP(_targets[0], -_damage,	0)
		}
	},
	ice : 
	{
		name : "Ice",
		description : "{0} casts Ice!",
		subMenu : "Magic",
		mpCost : 13,
		targetRequired: true,
		targetEnemyByDefault: true,
		targetAll: MODE.VARIES,
		userAnimation : "cast",
		effectSprite: spr_golemEffectAttack,
		effectOnTarget: MODE.ALWAYS,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
				var _damage = irandom_range(41,42)
				if (array_length(_targets)> 1) _damage = ceil(_damage*0.75)
				BattleChangeHP(_targets[i], -_damage)
				BattleChangeMP(_user,mpCost)
			}
		}
	},
	fury:
	{
		name : "Fury",
		description: "{0} transiting to fury soul",
		subMenu : "Souls",
		mpCost : 10,
		targetRequired: true,
		targetEnemyByDefault: false,
		targetAll: MODE.NEVER,
		userAnimation: "transition",
		effectSprite: spr_furySoul,
		effectOnTarget: MODE.ALWAYS,
		func: function(_user)
		{
			var _damage = irandom_range(7,14)
			BattleChangeHP(_user, -_damage)
			BattleChangeMP(_user,mpCost)
			BattleChangeStrength(_user, 10)
		}
	}
}


//Party data
global.party = 
{
	player:
	{
		name: "Player",
		xp: 0,
		karma: 0,
		hp: 89,
		hpMax: 89,
		mp: 25,
		mpMax: 25,
		strength: 6,
		sprites : { idle: spr_playerIdleSide, attack: spr_mainSideAttack},
		actions : ["attack","ice"]
	}
}

global.souls = 
{
	aiden:
	{
		name: "Aiden",
		gainedHp: 25,
		mp: 5,
		gainedStr: 10
	},
	
	rin:
	{
		name: "Rin",
		gainedHp: 50,
		mp: 5,
		gainedStr: 5
	}	
}

//Enemy Data
global.enemies =
{
	golem: 
	{
		name: "Golem",
		hp: 30,
		hpMax: 30,
		mp: 0,
		mpMax: 0,
		strength: 5,
		sprites: { idle: spr_golem, attack: spr_golemAttack},
		actions: [global.actionLibrary.attack],
		xpValue : 15,
		AIscript : function()
		{
			var _action = actions[0]
			var _possibleTargets = array_filter(obj_battle.partyUnits, function(_unit, _index)
			{
				return (_unit.hp > 0)
			})
			var _target = _possibleTargets[irandom(array_length(_possibleTargets)-1)]
			return [_action, _target]
		}
	}
	
}





