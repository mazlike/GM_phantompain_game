if(keyboard_check_pressed(ord("C")) && !instance_exists(obj_dialogue) && isNotMoving && distance_to_object(obj_player) < 8)
{
	create_dialogue("testing.yarn")
	ChatterboxAddFunction("goodkarma", add_good_karma)
	ChatterboxAddFunction("badkarma", add_bad_karma)
	ChatterboxAddFunction("getFurySoul", add_fury_soul)
}
