#autoload AudioManager
extends Node

var audio_bus_names = {
	0 : "Master",
}

func audio_volume_changed(a_bus, a_volume_linear):
	var vol_db = linear_to_db(a_volume_linear)
	AudioServer.set_bus_volume_db(a_bus, vol_db)

func audio_muted(a_bus, an_is_muted):
	AudioServer.set_bus_mute(a_bus, an_is_muted)

func register_audio_bus(a_name : String, a_number : int):
	if(audio_bus_names.has(a_number)):
		return false
	audio_bus_names.merge({a_number : a_name})
	return true

func detect_bus_data():
	for an_index in AudioServer.bus_count:
		var bus_name : String = AudioServer.get_bus_name(an_index)
		register_audio_bus(bus_name, an_index)

func load_save_data(a_dict : Dictionary) -> void:
	for a_bus_num in AudioServer.bus_count:
		var bus_key = str(a_bus_num)
		if a_dict.has(bus_key):
			AudioServer.set_bus_volume_db(a_bus_num, float(a_dict[bus_key]["volume_db"]))
			AudioServer.set_bus_mute(a_bus_num, a_dict[bus_key]["muted"])

func get_save_data() -> Dictionary:
	var a_dict : Dictionary = {}
	for a_bus_num in AudioServer.bus_count:
		a_dict.merge({
			str(a_bus_num) : {
				"volume_db" : AudioServer.get_bus_volume_db(a_bus_num),
				"muted" : AudioServer.is_bus_mute(a_bus_num)
			}
		})
	return a_dict
