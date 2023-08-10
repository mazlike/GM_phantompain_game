/// @description funcs of battle
instance_deactivate_all(true)

units = [] // massive for loop in battle

turn = 0
turnCount = 0
roundCount = 0
battleWaitTimeFrames = 15
battleWaitTimeRemaining = 0

currentUser = noone					// param
currentAction = -1					// for
currentTargets = noone				// switching

unitTurnOrder = [] // sorted line of creatures, which are in battle (need param "speed")
unitRenderOrder = [] // line of creatures for properly rendering(drawing) in battle
enemyDead = 0

// struct of cursor for switching targets in battle
cursor =
{
	activeUser: noone,
	activeTarget: noone,
	activeAction: -1,
	
	targetSide: -1,
	targetIndex: 0,
	targetAll: false,
	
	confirmDelay: 0,
	active: noone,
};

//Make enemies
for (var i = 0; i < array_length(enemies); i++)
{
	enemyUnits[i] = instance_create_depth(x+390+(i*20), y+150+(i*40),depth-10,obj_battleUnitEnemy,enemies[i])
	array_push(units,enemyUnits[i])
}

//Make party
for (var i = 0; i < array_length(global.party); i++)
{
	partyUnits[i] = instance_create_depth(x+250+(i*10), y+170+(i*15),depth-10,obj_battleUnitPC,global.party[i])
	array_push(units,partyUnits[i])
}

//Shuffle turn order
unitTurnOrder = array_shuffle(units)

//Get render order
RefreshRenderOrder = function()
{
	unitRenderOrder = []
	array_copy(unitRenderOrder,0,units,0,array_length(units))
	array_sort(unitRenderOrder,function(_1,_2)
	{
		return _1.y - _2.y
	})
}
RefreshRenderOrder()

function BattleStateSelectAction()
{
	if (!instance_exists(obj_battleMenu))
	{
		//Get current unit
		var _unit = unitTurnOrder[turn]
	
		//is the unit dead or unable to act?
		if (!instance_exists(_unit)) || (_unit.hp <= 0)
		{
			enemyDead++ // if numeral are equal enemyUnits => end of battle
			battleState = BattleStateVictoryCheck
			exit
		}
	
		//Select an action to perform
		//BeginAction(_unit.id, global.actionLibrary.attack, _unit.id)
	
		//if unit is PC
		if (_unit.object_index == obj_battleUnitPC)
		{
			//Compile the action menu
			var _menuOptions = []
			var _subMenus = {}
			
			var _actionList = _unit.actions
			
			for (var i = 0; i < array_length(_actionList); i++)
			{
				var _action = _actionList[i]
				var _available = true
				var _nameAndCount = _action.name
				if (_action.subMenu == -1)
				{
					array_push(_menuOptions, [_nameAndCount, MenuSelectAction, [_unit, _action], _available])
				}
				else
				{
					//create or add to a submenu
					if (is_undefined(_subMenus[$ _action.subMenu]))
					{
						variable_struct_set(_subMenus, _action.subMenu, [[_nameAndCount, MenuSelectAction, [_unit, _action], _available]])
					}
					else
					{
						array_push(_subMenus[$ _action.subMenu], [_nameAndCount, MenuSelectAction,[_unit, _action], _available])
					}
				}
				
			}
			//turn sub menus into an array
			var _subMenusArray = variable_struct_get_names(_subMenus)
			for (var i = 0; i < array_length(_subMenusArray); i++)
			{
				//sort submenu if needed
				//(here)
					
				//add back option at the end of each submenu
				array_push(_subMenus[$ _subMenusArray[i]], ["Back", MenuGoBack, -1, true])
					
				//add submenu into main menu
				array_push(_menuOptions, [_subMenusArray[i], SubMenu,[_subMenus[$ _subMenusArray[i]]],true])
			}

			Menu(x+10, y+210, _menuOptions, , 74, 60)
		}
		else
		{
			//if unit is AI
			var _enemyAction = _unit.AIscript()
			if	(_enemyAction != -1) BeginAction(_unit.id, _enemyAction[0], _enemyAction[1])
		}
	}
}

function BeginAction(_user, _action, _targets)
{
	currentUser = _user
	currentAction = _action
	currentTargets = _targets
	if (!is_array(currentTargets)) currentTargets = [currentTargets]
	battleWaitTimeRemaining = battleWaitTimeFrames
	with (_user)
	{
		acting = true
		//play user animation if is defined for that action, and that user
		if (!is_undefined(_action[$ "userAnimation"])) && (!is_undefined(_user.sprites[$ _action.userAnimation]))
		{
			sprite_index = sprites [$ _action.userAnimation]
			image_index = 0
		}
	}
	battleState = BattleStatePerformAction
}

function BattleStatePerformAction()
{
	//if animation etc is still playing
	if (currentUser.acting)
	{
		//when it ends, perform action effect if it exists
		if (currentUser.image_index >= currentUser.image_number -1)
		{
			with (currentUser)
			{
				sprite_index = sprites.idle
				image_index = 0
				acting = false
			}
			
			if (variable_struct_exists(currentAction, "effectSprite"))
			{
				if (currentAction.effectOnTarget == MODE.ALWAYS) || ( (currentAction.effectOnTarget == MODE.VARIES) && (array_length(currentTargets) <= 1) )
				{
					for (var i = 0; i < array_length(currentTargets); i++)
					{
						instance_create_depth(currentTargets[i].x, currentTargets[i].y, currentTargets[i].depth - 1, obj_battleEffect, {sprite_index : currentAction.effectSprite} )
						
					}
				}
				else //play it at 0,0
				{
					var _effectSprite = currentAction.effectSprite
					if (variable_struct_exists(currentAction, "effectSpriteNoTarget")) _effectSprite = currentAction.effectSpriteNoTarget
					instance_create_depth(x,y,depth-100,obj_battleEffect, {sprite_index : _effectSprite})
				}	
			}
			
			currentAction.func(currentUser, currentTargets)
		}
	}
	else // wait for delay and then end the turn
	{
		if (!instance_exists(obj_battleEffect))
		{
			battleWaitTimeRemaining--
			if (battleWaitTimeRemaining == 0)
			{
				battleState = BattleStateVictoryCheck
			}
		}
	}
}

function BattleStateVictoryCheck()
{
	if (enemyDead == array_length(enemyUnits))
	{
		instance_activate_all()
		instance_destroy(creator)
		instance_destroy()
	}
	else
		battleState = BattleStateTurnProgression
}

function BattleStateTurnProgression()
{
	turnCount++
	turn++
	//Lopp turns
	if (turn > array_length(unitTurnOrder) - 1)
	{
		turn = 0
		roundCount++
	}
	battleState = BattleStateSelectAction;
}



battleState = BattleStateSelectAction