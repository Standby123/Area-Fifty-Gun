extends RigidBody2D

var is_first_shot:bool = true

var knockback_force : int = 1

@onready var collider: CollisionPolygon2D = $Collider

@onready var muzzle: Node2D = $Muzzle

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("Shoot"):
		var x_dir = muzzle.transform[0]
		var y_dir = muzzle.transform[1]
		var pos = muzzle.transform[2]
		
		print(pos)
		apply_impulse(Vector2i.UP * 10, pos)
