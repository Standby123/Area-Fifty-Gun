extends RigidBody2D

var recoil : int = 20
var shot_allowed : bool = true
signal shot_fired

@onready var collider: CollisionPolygon2D = $Collider

@onready var muzzle: Node2D = $Muzzle

func _physics_ready():
	pass
	
func _physics_process(delta: float) -> void:
	angular_damp = 2
	
	if abs(angular_velocity) > 10:
		angular_velocity *= 0.7 # joe slowed this from 0.9 to 0.7 :)
	
	if Input.is_action_pressed("Rotate Left"):
		angular_velocity = -8
		
	if Input.is_action_pressed("Rotate Right"):
		angular_velocity = 8
		
	if shot_allowed == true:
		if Input.is_action_just_pressed("Shoot"):
			shot_fired.emit() # emit a signal to say a shot was fired
			shot_allowed = false
			linear_velocity = Vector2(0,0) # set velocity to zero to allow snappy mid air turnarounds
			var pos = muzzle.transform[2] # Get Muzzle Position
			var dir = -1* Vector2(transform.x.x, transform.x.y) # Get direction to shoot
			
			# Physics Stuff
			apply_impulse(dir * recoil, pos)

func _on_timer_timeout() -> void:
	# allow another shot after cooldown times out
	shot_allowed = true # Replace with function body.
