extends Control

func _ready() -> void:
	pass
	#MusicPlayer.play_certain_track(1)

func _on_new_game_pressed() -> void:
	get_tree().change_scene_to_file("res://Assets/Scenes/Levels/level1.tscn")
	IntroMusic.queue_free()
	GameMusic.play()

func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://Assets/Scenes/UI Elements/settings_menu.tscn")
