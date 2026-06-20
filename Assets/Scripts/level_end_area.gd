extends Area2D


func _on_body_entered(body: Node2D) -> void:
	body.queue_free() # Remove player from scene
	
	get_tree().change_scene_to_file('res://Assets/Scenes/Levels/level2.tscn')
