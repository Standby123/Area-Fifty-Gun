extends Sprite2D

func start_rotation_loop(Low_Angle, High_Angle, Duration) -> void:
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
