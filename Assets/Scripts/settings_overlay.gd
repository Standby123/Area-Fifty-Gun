extends Control

@onready var animation_player: AnimationPlayer = $"Settings Text/AnimationPlayer"

func _ready() -> void:
	visible = false
	animation_player.stop()
	
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if visible:
			visible = false
			animation_player.stop()
			get_tree().paused = false
			
		else:
			visible = true
			animation_player.play("Write Text")
			get_tree().paused = true
			



func _on_level_reset_pressed() -> void:
	get_tree().change_scene_to_file.call_deferred(get_tree().current_scene.scene_file_path)
	visible = false
	animation_player.stop()
	get_tree().paused = false

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file.call_deferred("res://Assets/Scenes/Levels/level1.tscn")
	visible = false
	animation_player.stop()
	get_tree().paused = false
