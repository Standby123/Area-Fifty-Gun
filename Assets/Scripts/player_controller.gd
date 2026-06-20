extends RigidBody2D

var is_first_shot:bool = true

var recoil : int = 20
var cooldown : float = 0.4 # cooldown time between shots in seconds
var time_passed : float = 0 # time passed since last shot fired


@onready var collider: CollisionPolygon2D = $Collider

@onready var muzzle: Node2D = $Muzzle

func _physics_ready():
	pass
	

func _physics_process(delta: float) -> void:
	


	
	angular_damp = 2
	
	if abs(angular_velocity) > 10:
		angular_velocity *= 0.9
	
	if Input.is_action_pressed("Rotate Left"):
		angular_velocity = -8
		
	if Input.is_action_pressed("Rotate Right"):
		angular_velocity = 8
		
#<<<<<<< HEAD
	if Input.is_action_just_pressed("Shoot"):
		linear_velocity = Vector2(0,0)
		var pos = muzzle.transform[2] # Get Muzzle Position
		var dir = -1* Vector2(transform.x.x, transform.x.y) # Get direction to shoot
		
		# Physics Stuff
		apply_impulse(dir * recoil, pos)
#=======
	# increase time passed
	if time_passed < cooldown:
		time_passed += delta
	# if cooldown time has passed - allow a shot	
	elif time_passed >= cooldown:
		if Input.is_action_just_pressed("Shoot"):
			time_passed = 0
			linear_velocity = Vector2(0,0)
			var pos = muzzle.transform[2] # Get Muzzle Position
			var dir = -1* Vector2(transform.x.x, transform.x.y) # Get direction to shoot
			
			# Physics Stuff
			apply_impulse(dir * recoil, pos)


	
#>>>>>>> 4e466632182f7bb4b64fc2bd3fdfaabe5d15d193
