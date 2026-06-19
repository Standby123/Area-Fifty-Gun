extends RigidBody2D

var is_first_shot:bool = true

var knockback_force : int = 1

@onready var collider: CollisionPolygon2D = $Collider

@onready var muzzle: Node2D = $Muzzle

func impulse():
	muzzle.get_angle_to(Vector2i.RIGHT)
	#collider.Apply_impulse()
