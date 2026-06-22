extends RigidBody2D

var shot_allowed : bool = true
var recoil : int = 20
signal shot_fired
var shoot_anim_ended : bool = true

@onready var _animated_sprite = $Sprite_Animation

@onready var collider: CollisionPolygon2D = $Collider

@onready var muzzle: Node2D = $Muzzle

# Bullet and Entity
const BULLET = preload("res://Assets/Scenes/bullet.tscn")
var shot_count: int = 0
@onready var bullet_handler: Node = %"Bullet Handler"


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var muzzle_flash: AnimatedSprite2D = $"Muzzle Flash"

func _physics_process(delta: float) -> void:
	if shoot_anim_ended == true:
		_animated_sprite.play("idle")
	
	angular_damp = 2
	if abs(angular_velocity) > 10:
		angular_velocity *= 0.7
	
	if Input.is_action_pressed("Rotate Left"):
		angular_velocity = -8
		
	if Input.is_action_pressed("Rotate Right"):
		angular_velocity = 8
	
			
	if shot_allowed == true and not animation_player.is_playing():
		
		if Input.is_action_just_pressed("Shoot"):
			shoot_anim_ended = false
			#_animated_sprite.stop()
			shot_allowed = false
			_animated_sprite.play("shoot")
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
	shot_count += 1
	
	var new_bullet = BULLET.instantiate()
	new_bullet.position = muzzle.global_position
	new_bullet.angle = muzzle.global_rotation
	new_bullet.name = "Bullet " + str(shot_count)
	bullet_handler.add_child(new_bullet)
	bullet_handler.Clear_Bullets(shot_count)
	
	muzzle_flash.visible = true
	muzzle_flash.play("default")
	animation_player.play("Pistol Shot")
	


func _on_sprite_animation_animation_finished() -> void:
	if _animated_sprite.animation == "shoot":
		shoot_anim_ended = true
