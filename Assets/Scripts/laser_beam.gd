@tool
extends RayCast2D

@export var max_length: float = 1000
@export var speed: float = 3000

# Particle Effects
@onready var beam_particles: GPUParticles2D = $"Beam Particles"
@onready var collision_particles: GPUParticles2D = $"Collision Particles"
@onready var cast_particles: GPUParticles2D = $"Cast Particles"

func  _ready() -> void:
	set_colour(colour)
	set_is_casting(is_casting)

func _physics_process(delta: float) -> void:
	target_position.x = move_toward(
		target_position.x,
		max_length,
		speed*delta
	)
	
	var laser_end_pos := target_position
	force_raycast_update() #Up to date collision data
	if is_colliding():
		laser_end_pos = to_local(get_collision_point())
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
	tween.tween_property(laser_look, "width", line_width, growth_time * 2.0).from(0.0)
	
func disappear() -> void:
	if tween and tween.is_running():
		tween.kill()
	tween = create_tween()
	tween.tween_property(laser_look, "width", 0.0, growth_time).from_current()
	tween.tween_callback(laser_look.hide)
