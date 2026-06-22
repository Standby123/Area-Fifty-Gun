extends Control

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Assets/Scenes/UI Elements/Main Menu.tscn")
