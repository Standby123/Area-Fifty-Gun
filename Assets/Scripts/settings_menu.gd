extends Control

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://Assets/Scenes/UI Elements/Main Menu.tscn")

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Assets/Scenes/UI Elements/Main Menu.tscn")
