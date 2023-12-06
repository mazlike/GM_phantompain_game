
function Menu(_x, _y, _options, _description = -1, _width = undefined, _height = undefined)
{	
	with (instance_create_depth(_x, _y, -99999, obj_battleMenu))
	{
		options = _options
		description = _description
		var _optionsCount = array_length(_options)
		visibleOptionsMax = _optionsCount
		
		//Set up size
		xmargin = 10
		ymargin = 8
		draw_set_font(fnt_battleMenu)
		heightLine = 12
		
		//Auto width
		if (_width == undefined)
		{
			width = 1
			if (description != -1) width = max(width, string_width(_description))
			for (var i = 0; i < _optionsCount; i++)
				width = max(width, string_width(_options[i][0]))
			widthFull = width + xmargin * 2
				
		}	else widthFull = _width
		
		//Auto height
		if (_height == undefined)
		{
			height = heightLine * (_optionsCount*2 + !(description = -1))
			heightFull = height + ymargin * 2
		}
		else
		{
			heightFull = _height
			//scrolling?
			if (heightLine * (_optionsCount + !(description == -1)) > _height - (ymargin*2))
			{
				scrolling = true
				visibleOptionsMax = (_height - ymargin * 2) div heightLine
			}
		}
	}
}


function SubMenu(_options)
{
	//store old options in array and increase submenu level
	optionsAbove[subMenuLevel] = options
	subMenuLevel++
	options = _options
	hover = 0
}

function MenuGoBack()
{
	subMenuLevel--
	options = optionsAbove[subMenuLevel]
	hover = 0
}


function MenuSelectAction(_user, _action)
{
	with (obj_battleMenu)
	{
		active = false
	}
	//MenuSelectEnemy(oBattle.x,oBattle.y,oBattle.enemyUnits,_user,_action)
	with (obj_battle)
	{
		if (_action.targetRequired)
		{
			with (cursor)
			{
				active = true;
				activeAction = _action
				targetAll = _action.targetAll
				if (targetAll == MODE.VARIES) targetAll = true
				activeUser = _user
				
				//Which side to target by default?
				if (_action.targetEnemyByDefault)
				{
					targetIndex = 0
					targetSide = obj_battle.enemyUnits
					activeTarget = obj_battle.enemyUnits[targetIndex]
				}
				else // target self by default
				{
					targetSide = obj_battle.partyUnits
					activeTarget = activeUser
					var _findSelf = function(_element)
					{
						return (_element == activeTarget)
					}
					targetIndex = array_find_index(obj_battle.partyUnits, _findSelf)
				}
			}
		}
		else
		{
			//If no target needed? begin the action and end the menu
			BeginAction(_user,_action,-1)
			with (obj_battleMenu) instance_destroy()
		}
	}		
}


