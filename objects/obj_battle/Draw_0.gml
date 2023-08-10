/// @description drawing battle environment
//Draw background
draw_sprite(bg,0,x,y)

//Draw units in depth order
var _unitWithCurrentTurn = unitTurnOrder[turn].id
for (var i = 0; i < array_length(unitRenderOrder); i++)
{
	with (unitRenderOrder[i])
	{
		draw_self()
	}
}

//Draw UI boxes
draw_sprite_stretched(spr_box,0,x+230,y+235,300,100)
draw_sprite_stretched(spr_box,0,x+130,y+235,90,100)

//Draw headings
draw_set_font(fnt_battleMenu)
draw_set_halign(fa_left)
draw_set_valign(fa_top)
draw_set_color(c_gray)
draw_text(x+153,y+240,"ENEMY")
draw_text(x+270,y+240,"NAME")
draw_text(x+370,y+240,"HP")
draw_text(x+450,y+240,"MP")

//Draw enemy names
draw_set_color(c_white)
var _drawLimit = 3
var _drawn = 0
for (var i = 0; (i < array_length(enemyUnits)) && (_drawn < _drawLimit); i++)
{
	var _char = enemyUnits[i]
	if (_char.hp > 0)
	{
		_drawn++
		draw_set_color(c_white)
		if (_char.id == _unitWithCurrentTurn) draw_sprite(spr_pointer,0 ,x + 140,y+268+(i*15))
		draw_text(x + 153,y+260+(i*18),_char.name)
	}
}

//Draw party info
for (var i = 0; i < array_length(partyUnits); i++)
{
	draw_set_halign(fa_left)
	draw_set_color(c_white)
	var _char = partyUnits[i]
	if (_char.id == _unitWithCurrentTurn) draw_sprite(spr_pointer,0 ,x+250,y+268+(i*12))
	if (_char.hp <= 0) draw_set_color(c_red)
	draw_text(x+263,y+260+(i*12),_char.name)
	draw_set_halign(fa_right)
	
	draw_set_color(c_white)
	if (_char.hp < (_char.hpMax * 0.5)) draw_set_color(c_orange)
	if (_char.hp <= 0) draw_set_color(c_red)
	draw_text(x+400,y+260+(i*12),string(_char.hp)+ "/" + string(_char.hpMax))
	
	
	draw_set_color(c_white)
	if (_char.mp < (_char.mpMax * 0.5)) draw_set_color(c_orange)
	if (_char.mp <= 0) draw_set_color(c_red)
	draw_text(x+480,y+260+(i*12),string(_char.mp)+ "/" + string(_char.mpMax))
	
	draw_set_color(c_white)
}


// draw cursor
if (cursor.active)
{
	with (cursor)
	{
		if (activeTarget != noone)
		{
			if (!is_array(activeTarget))
			{
				// if spell has single enemy
				draw_sprite(spr_pointer,0,activeTarget.x-35,activeTarget.y)
			}
			else
			{
				// if spell has are a lot of targets
				draw_set_alpha(sin(get_timer()/50000)+1)
				for (var i = 0; i < array_length(activeTarget); i++)
				{
					draw_sprite(spr_pointer,0,activeTarget[i].x-35,activeTarget[i].y)
				}
				draw_set_alpha(1.0)
			}
		}
	}
}


	