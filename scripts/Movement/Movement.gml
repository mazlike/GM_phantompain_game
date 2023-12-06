// Ресурсы скриптов были изменены для версии 2.3.0, подробности см. по адресу
// https://help.yoyogames.com/hc/en-us/articles/360005277377
function Movement()
{
	if global.moveble
	{	
		xDir = D - A
		yDir = S - W
		
		xSpd = xDir * spd;
		ySpd = yDir * spd;
		
		
		PlayerCollision(xSpd,ySpd,spd);
	
		
		if (W = 1)
		{
			sprite_index = spr_playerRunUp	
		}
		else if (A = 1)
		{
			sprite_index = spr_playerRunSide
			image_xscale = 1
		}
		else if (S = 1)
		{
			sprite_index = spr_playerRunDown
		}
		else if (D = 1)
		{
			sprite_index = spr_playerRunSide
			image_xscale = -1
		}
	
		if keyboard_check_released(ord("W"))
			sprite_index = spr_playerIdleUp
		if keyboard_check_released(ord("A")){
			sprite_index = spr_playerIdleSide
			image_xscale = 1}
		if keyboard_check_released(ord("S"))
			sprite_index = spr_playerIdleDown
		if keyboard_check_released(ord("D"))
		{
			sprite_index = spr_playerIdleSide
			image_xscale = -1
		}
	}	
}