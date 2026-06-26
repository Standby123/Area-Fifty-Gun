extends Sprite2D


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	IntroMusic.playing = true
	get_tree().change_scene_to_file("res://Assets/Scenes/UI Elements/Main Menu.tscn")
