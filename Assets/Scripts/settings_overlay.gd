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
			
