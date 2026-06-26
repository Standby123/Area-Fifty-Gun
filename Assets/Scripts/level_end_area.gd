extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_body_entered(body: Node2D) -> void:
	body.queue_free() # Remove player from scene
	var before = MusicPlayer.volume_linear
	MusicPlayer.volume_linear = before * 0.5
	animation_player.play("Area Cleared")
	
	await get_tree().create_timer(2).timeout
	
	MusicPlayer.volume_linear = before
	var current = get_tree().current_scene.scene_file_path
	var next_scene = "res://Assets/Scenes/Levels/level" + str(current.to_int()+1) + ".tscn"
	get_tree().change_scene_to_file.call_deferred(next_scene)
