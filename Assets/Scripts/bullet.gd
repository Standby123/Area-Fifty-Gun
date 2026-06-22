extends RigidBody2D

const speed = 500

var angle #Angle in rads

var direction 

var velocity

const despawn_time = 1

var num_col: int = 0

var max_col: int = 4

var damp: float = 0.9

func _ready() -> void:
	angle += PI/2
	direction = Vector2(cos(angle), sin(angle))
	
	velocity = direction * speed
	#despawn()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)

	if collision:
		num_col += 1
		var reflect = collision.get_remainder().bounce(collision.get_normal())
		velocity = velocity.bounce(collision.get_normal())
		move_and_collide(reflect)
		
		var new_dir = velocity.normalized()
		rotation = velocity.angle()
		velocity *= damp

	elif num_col >= max_col:
		pass
		#queue_free()

func despawn():
	await get_tree().create_timer(despawn_time).timeout
	queue_free()
