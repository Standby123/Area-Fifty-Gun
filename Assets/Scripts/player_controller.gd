extends RigidBody2D

var shot_allowed : bool = true
var recoil : int = 20
signal shot_fired

@onready var collider: CollisionPolygon2D = $Collider

@onready var muzzle: Node2D = $Muzzle

const BULLET = preload("res://Assets/Scenes/bullet.tscn")

func _physics_process(delta: float) -> void:
	
	angular_damp = 2
	
	if abs(angular_velocity) > 10:
		angular_velocity *= 0.7
	
	if Input.is_action_pressed("Rotate Left"):
		angular_velocity = -8
		
	if Input.is_action_pressed("Rotate Right"):
		angular_velocity = 8
	if shot_allowed == true:	
		if Input.is_action_just_pressed("Shoot"):
			shot_allowed = false
			shot_fired.emit() # emit a signal to say a shot was fired
			linear_velocity = Vector2(0,0)
			var pos = muzzle.transform[2] # Get Muzzle Position
			var dir = -1* Vector2(transform.x.x, transform.x.y) # Get direction to shoot
			
			# Physics Stuff
			apply_impulse(dir * recoil, pos)
			
			# Create Bullet
			shoot()
			

func _on_timer_timeout() -> void:
	# allow another shot after cooldown times out
	shot_allowed = true # Replace with function body.

func shoot():
	var dir = muzzle.global_rotation
	
	var new_bullet = BULLET.instantiate()
	new_bullet.position = muzzle.global_position
	new_bullet.angle = muzzle.global_rotation
	get_tree().root.add_child(new_bullet)
