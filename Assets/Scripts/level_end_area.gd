extends Area2D

func _on_body_entered(body: Node2D) -> void:
	body.queue_free() # Remove player from scene
	var current = get_tree().current_scene.scene_file_path
	var next_scene = "res://Assets/Scenes/Levels/level" + str(current.to_int()+1) + ".tscn"
	get_tree().change_scene_to_file.call_deferred(next_scene)
