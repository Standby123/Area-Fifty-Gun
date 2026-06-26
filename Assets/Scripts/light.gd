extends AnimatedSprite2D

@export var energy: float = 1 ##
@export var can_break: bool = false ##
@export var time_to_break: float = 5 ##

@onready var point_light_2d: PointLight2D = $PointLight2D
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D

func _ready() -> void:
	play("On")
	point_light_2d.visible = true
	point_light_2d.energy = energy

func _process(delta: float) -> void:
	if can_break:
		await get_tree().create_timer(time_to_break).timeout
		play("Off")
		point_light_2d.visible = false
		gpu_particles_2d.emitting = true
		can_break = false
		
