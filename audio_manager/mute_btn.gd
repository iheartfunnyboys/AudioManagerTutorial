extends EnhancedButton

var my_channel : int

func _ready() -> void:
	super._ready()
	toggled.connect(_on_toggled)
	my_channel = owner.my_bus_number
	button_pressed = AudioServer.is_bus_mute(my_channel)

func _on_toggled(toggled_on : bool) -> void:
	AudioManager.audio_muted(my_channel, toggled_on)
