if keyboard_check_pressed(vk_space) && distance_to_object(obj_player) < 5 && isNotMoving
{
	NewEncounter([global.enemies.golem, global.enemies.golem], spr_black)
}
