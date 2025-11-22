extends Control

const vol_bar_hori = preload("volume_bar_hori.tscn")
const vol_bar_vert = preload("volume_bar_vert.tscn")

@export var override_volume_bar : PackedScene
@export var is_horizontal_sliders : bool = true

func _ready():
	AudioManager.detect_bus_data()
	var audio_buses = AudioManager.audio_bus_names
	for a_key in audio_buses.keys():
		var new_vol_bar
		if not override_volume_bar == null:
			new_vol_bar = override_volume_bar.instantiate()
		elif is_horizontal_sliders:
			new_vol_bar = vol_bar_hori.instantiate()
		else:
			new_vol_bar = vol_bar_vert.instantiate()
		new_vol_bar.set_data(audio_buses[a_key], a_key)
		add_child(new_vol_bar)
