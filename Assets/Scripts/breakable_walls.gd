extends Node2D

@onready var detector = get_node("Sprite2D/Area2D/CollisionShape2D")
@onready var collider = get_node("Sprite2D/StaticBody2D/CollisionShape2D")
@onready var shard_emitter = get_node("Sprite2D/ShardEmitter")

@onready var glass_shatter_noise: AnimationPlayer = $"Glass Shatter Noise"

func _on_area_2d_body_entered(body: Node2D) -> void:
		if (body.linear_velocity.y > 10):
			detector.set_deferred("disabled",true)
			collider.set_deferred("disabled",true)
			shard_emitter.call_deferred("shatter")
			glass_shatter_noise.play("Noise")
			
