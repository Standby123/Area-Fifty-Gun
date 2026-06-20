extends RigidBody2D

var is_first_shot:bool = true

var recoil : int = 20

@onready var collider: CollisionPolygon2D = $Collider

@onready var muzzle: Node2D = $Muzzle


func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("Shoot"):
		var pos = muzzle.transform[2]
		var dir = -1* Vector2(transform.x.x, transform.x.y)
		
		apply_impulse(dir * recoil, pos)
		angular_damp = 2
		if abs(angular_velocity) > 8:
			angular_velocity = 8
