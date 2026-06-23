extends HSlider

@export var bus_name: String

var bus_index: int

var audio_manager: String = "res://Assets/Audio/Audio_Manager.txt"

func _ready() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)
	value_changed.connect(_on_value_changed)
	
	var content = load_from_file()
	var num = file_parse(content, bus_name) # >100
	value = float(num)/100 # convert to float 0.0 > x > 1.0
	#value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))
	
func _on_value_changed(new_value: float) -> void:
	AudioServer.set_bus_volume_db(
		bus_index,
		linear_to_db(new_value)
	)
	
	var content = load_from_file()
	file_parse(content, bus_name, int(new_value*100))


func save_to_file(content):
	var file = FileAccess.open(audio_manager, FileAccess.WRITE)
	file.store_string(content)

func load_from_file():
	var file = FileAccess.open(audio_manager, FileAccess.READ)
	var content = file.get_as_text()
	return content

func file_parse(content, key, write=""):
	var new_data: String = "" # The new data
	var new_content: String = "" # New content to be saved
	
	for s in content: # Looping through contents
		if s == "\n": # Finds the new lines
			if new_data.contains(key): 
				var key_value = new_data.to_int()
				if len(str(write)) == 0:
					return key_value
				else:
					new_data = new_data.replace(str(key_value), str(write)) # Replacing old value
			
			new_content += new_data + "\n"
			new_data = ""
			
		else: # Adds data until new line
			new_data += s
			
	if len(str(write)) != 0:
		save_to_file(new_content)
