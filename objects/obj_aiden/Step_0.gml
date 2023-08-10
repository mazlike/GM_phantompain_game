if(keyboard_check_pressed(ord("C")) && !instance_exists(obj_dialogue) && isNotMoving && distance_to_object(obj_player) < 8)
{
	NewConversation(global.dialogue.aiden_meet)
}
