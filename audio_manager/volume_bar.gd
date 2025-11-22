extends Control

var my_bus_name : String
var my_bus_number : int
@onready var volume_slider : Slider = %VolumeSlider

func set_data(a_bus_name, a_bus_number):
	my_bus_name = a_bus_name
	my_bus_number = a_bus_number
	if(is_inside_tree()):
		_set_bus_name()
		_set_initial_volume()

func _ready() -> void:
	_set_bus_name()
	_set_initial_volume()
	volume_slider.value_changed.connect(_on_volume_slider_value_changed)

func _set_bus_name():
	%AudioBusDispName.text = tr(my_bus_name).to_lower()

func _set_initial_volume():
	volume_slider.value = db_to_linear(AudioServer.get_bus_volume_db(my_bus_number))

func _reset_slider_disp():
	_set_initial_volume()

func _on_volume_slider_value_changed(value: float) -> void:
	AudioManager.audio_volume_changed(my_bus_number, value)
