extends Sprite2D

# Laser Properties
@export var is_casting: bool = false ##
@export var colour := Color.WHITE ##

# Laser Movement Controls
@export var Sweep = false ##
@export var Low_Angle := 0 ##
@export var High_Angle := 30 ##
@export var Duration := 1 ##

# Laser Settings
@export var Indefinite_Time := true ##
@export var Active_Time := 10 ##
@export var Inactive_Time := 10 ##

# Nodes
@onready var laser_extension: Sprite2D = $"Laser Extension"
@onready var laser_cannon: AnimatedSprite2D = $"Laser Extension/Laser Cannon"
@onready var laser_beam: RayCast2D = $"Laser Extension/Laser Cannon/Laser Beam"
@onready var sleep_time: Timer = $"Laser Extension/Laser Cannon/Laser Beam/Sleep Time"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sleep_time.wait_time = Inactive_Time
	laser_beam.modulate = colour
	laser_beam.is_casting = is_casting
	
	laser_beam.indefinite = Indefinite_Time
	laser_beam.wake_time = Active_Time
	
	laser_extension.rotation_degrees = Low_Angle
	if Sweep:
		laser_extension.start_rotation_loop(Low_Angle, High_Angle, Duration)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if laser_beam.visibility:
		laser_cannon.play("firing")
		
	
		
	elif not laser_beam.visibility:
		laser_cannon.play("default")
		
	elif not laser_beam.visibility and (sleep_time.wait_time - sleep_time.time_left) < 0.1:
		laser_cannon.play("charging")
		
	elif not laser_beam.visibility and sleep_time.time_left < 0.1:
		laser_cannon.play_backwards("charging")
