extends Sprite2D

# Laser Properties
@export var is_casting: bool = false
@export var colour := Color.WHITE

# Laser Movement Controls
@export var Sweep = false
@export var Low_Angle := 0
@export var High_Angle := 30
@export var Duration := 1

# Laser Settings
@export var Indefinite_Time := true
@export var Active_Time := 10
@export var Inactive_Time := 10

# Nodes
@onready var laser_extension: Sprite2D = $"Laser Extension"
@onready var laser_cannon: AnimatedSprite2D = $"Laser Extension/Laser Cannon"
@onready var laser_beam: RayCast2D = $"Laser Extension/Laser Cannon/Laser Beam"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	laser_beam.modulate = colour
	laser_beam.is_casting = is_casting
	
	start_rotation_loop()
	laser_extension.rotation_degrees = Low_Angle


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_rotation_loop() -> void:
	# Initialize starting angle
	rotation_degrees = Low_Angle
	
	# Create a looping tween
	var tween = create_tween().set_loops()
	
	# Rotate to max angle
	tween.tween_property(self, "rotation_degrees", High_Angle, Duration)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		
	# Rotate back to min angle
	tween.tween_property(self, "rotation_degrees", Low_Angle, Duration)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
