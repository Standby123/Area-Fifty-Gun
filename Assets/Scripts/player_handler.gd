extends Node2D

const GUNTHER_1 = preload("res://Assets/Scenes/Gun Types/Gunther 1.tscn")
const SHOTTO_2 = preload("res://Assets/Scenes/Gun Types/Shotto 2.tscn")

const gun_array: Array = [GUNTHER_1, SHOTTO_2]

@export var gun_index: int = 1

func _ready() -> void:
	for gun_type in gun_array:
		if str(gun_type).to_int() == gun_index:
			var new_gun = gun_type.instantiate()
			add_child(new_gun)
	pass
