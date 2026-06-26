extends AudioStreamPlayer2D

const game = preload("res://Assets/Audio/Music/Game music.mp3")
const menu = preload("res://Assets/Audio/Music/Title music.mp3")

func play_certain_track(track_number: int):
	# Stop the player to prevent overlapping audio
	stop()
	
	# Assign the specific track
	if track_number == 1:
		stream = menu
	elif track_number == 2:
		stream = game
		
	# Start playing the newly assigned track
	play()
