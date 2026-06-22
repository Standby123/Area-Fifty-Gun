extends Node

var max_bullets: int = 10

func Clear_Bullets(num_shots):
	if num_shots > max_bullets:
		get_child(0).queue_free()
