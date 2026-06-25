extends RayCast2D

# Player Collision Level

@export var max_length: float = 1000
@export var speed: float = 3000

# Particle Effects
@onready var beam_particles: GPUParticles2D = $"Beam Particles"
@onready var collision_particles: GPUParticles2D = $"Collision Particles"
@onready var cast_particles: GPUParticles2D = $"Cast Particles"

# Timer
@export var indefinite: bool = false
@export var wake_time := 3
@onready var sleep_timer: Timer = $"Sleep Time"
var visibility: bool = true
var sleep_time

var elapsed_time :float = 0
var charge: bool = false
var reverse_charge: bool = false
var power_off: bool = false

# Gun Names
var gun_names: Array = ["Gunther", "Shotto"]

func  _ready() -> void:
	
	set_colour(colour)
	set_is_casting(is_casting)

func _physics_process(delta: float) -> void:
	main_thread(delta)
	
	if not indefinite:
		if elapsed_time >= wake_time:
			disappear()
			set_collision_mask_value(1, false)
			visibility = false
			elapsed_time = 0.0
		
		if not visibility:
			#sleep_timer.start()
			sleep_time = sleep_timer.wait_time
			
			# Power Down
			reverse_charge = true
			await get_tree().create_timer(1, true, true).timeout
			reverse_charge = false
			
			# Power Off
			power_off = true
			await get_tree().create_timer(sleep_time, true, true).timeout
			power_off = false
			#sleep_timer.stop()
			
			# Power On
			charge = true
			await  get_tree().create_timer(1, true, true).timeout
			charge = false
			
			appear()
			set_collision_mask_value(1, true)
			visibility = true
			elapsed_time = 0.0
			
		elapsed_time += delta
		
func main_thread(delta):
	target_position.x = move_toward(
		target_position.x,
		max_length,
		speed*delta
	)
	
	var laser_end_pos := target_position
	force_raycast_update() #Up to date collision data
	if is_colliding():
		laser_end_pos = to_local(get_collision_point())
		for gun in gun_names:
			if gun == str(get_collider().name):
				get_collider().death()
	
	laser_look.points[1] = laser_end_pos
	collision_particles.position = laser_end_pos
	
	var laser_start_pos := laser_look.points[0]
	beam_particles.position = laser_start_pos + (laser_end_pos - laser_start_pos)*0.5
	beam_particles.process_material.emission_box_extents.x = laser_end_pos.distance_to(laser_start_pos) *0.5

	

@export var is_casting: bool = false: set = set_is_casting

func set_is_casting(new_value):
	if is_casting == new_value:
		return
		
	is_casting = new_value
	
	set_physics_process(is_casting)
	
	if not laser_look:
		return
	
	if not is_casting:
		target_position.x = 0.0
		disappear()
		
	else:
		appear()
		
# Laser looks
@onready var laser_look: Line2D = $"Laser Look"
@onready var line_width:= laser_look.width

@export var colour := Color.WHITE: set = set_colour

func set_colour(new_colour: Color) -> void:
	colour = new_colour
	
	if laser_look == null:
		return
	laser_look.modulate = new_colour
	beam_particles.modulate = new_colour
	collision_particles.modulate = new_colour
	cast_particles.modulate = new_colour

@export var growth_time := 0.1
var tween: Tween = null

func appear() -> void:
	
	laser_look.visible = true
	if tween and tween.is_running():
		tween.kill()
	tween = create_tween()
	tween.tween_property(laser_look, "width", line_width, growth_time).from(0.0)
	
	collision_particles.visible = true
	beam_particles.visible = true
	cast_particles.visible = true
	
func disappear() -> void:
	if tween and tween.is_running():
		tween.kill()
	tween = create_tween()
	tween.tween_property(laser_look, "width", 0.0, growth_time).from_current()
	tween.tween_callback(laser_look.hide)
	
	collision_particles.visible = false
	beam_particles.visible = false
	cast_particles.visible = false
