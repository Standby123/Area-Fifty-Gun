extends RigidBody2D

var is_first_shot:bool = true

var recoil : int = 20

@onready var collider: CollisionPolygon2D = $Collider

@onready var muzzle: Node2D = $Muzzle

func _physics_ready():
	pass

func _physics_process(delta: float) -> void:
	
	angular_damp = 2

	if Input.is_action_pressed("Rotate Left"):
		angular_velocity -= 5
		
		angular_velocity = 8
		
	if Input.is_action_just_pressed("Shoot"):
		print(angular_velocity, angular_damp)	
		var pos = muzzle.transform[2] # Get Muzzle Position
		var dir = -1* Vector2(transform.x.x, transform.x.y) # Get direction to shoot
		
		# Physics Stuff
		apply_impulse(dir * recoil, pos)


	
