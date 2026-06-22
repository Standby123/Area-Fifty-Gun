extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var played_before = false

func _on_body_entered(body: Node2D) -> void:
	if not played_before:
		played_before = true
		animated_sprite_2d.play()
		var num_child: int = get_child_count()
		
		for child_index in range(2, num_child): # Skip the first 2 children
			get_child(child_index).move()
