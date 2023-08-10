// Ресурсы скриптов были изменены для версии 2.3.0, подробности см. по адресу
// https://help.yoyogames.com/hc/en-us/articles/360005277377
function PlayerCollision(_xspd,_yspd,_spd)
{
	xs = _xspd
	ys = _yspd
	s = _spd
	move_and_collide(xs,ys,obj_collider,8,0,0,s,s);
}