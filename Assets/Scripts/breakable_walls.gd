extends Node2D

@onready var detector = get_node("Sprite2D/Area2D/CollisionShape2D")
@onready var collider = get_node("Sprite2D/StaticBody2D/CollisionShape2D")
@onready var shard_emitter = get_node("Sprite2D/ShardEmitter")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
		if (body.linear_velocity.y > 10):
			detector.set_deferred("disabled",true)
			collider.set_deferred("disabled",true)
			shard_emitter.call_deferred("shatter")
			
