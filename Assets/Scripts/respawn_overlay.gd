extends Control

@onready var animation_player: AnimationPlayer = $"Settings Text/AnimationPlayer"

func _ready() -> void:
	visible = false
	animation_player.stop()
	
var count: int = 0
func _process(delta: float) -> void:
	if not IsAlive.alive and count == 0:
		IsAlive.death_noise()
		visible = true
		animation_player.play("Respawn Text")
		#get_tree().paused = true
		count += 1


func _on_level_reset_pressed() -> void:
	get_tree().change_scene_to_file.call_deferred(get_tree().current_scene.scene_file_path)
	IsAlive.alive = true
	visible = false
	animation_player.stop()
	get_tree().paused = false

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file.call_deferred("res://Assets/Scenes/UI Elements/Main Menu.tscn")
	visible = false
	animation_player.stop()
	get_tree().paused = false
