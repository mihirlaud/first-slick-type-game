extends Control

signal settings_closed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	
	var screen_size = get_viewport_rect().size
	
	position.x = screen_size.x / 2 - $ColorRect.size.x / 2
	position.y = screen_size.y / 2 - $ColorRect.size.y / 2
	
	$CloseButton.scale = Vector2(2, 2)
	$CloseButton.position.y = 10
	$CloseButton.position.x = $ColorRect.size.x - $CloseButton.size.x * 2 - 10


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_master_volume_slider_value_changed(value: float) -> void:
	var bus_index = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))

func _on_main_settings_opened(is_opened: Variant) -> void:
	visible = is_opened

func _on_close_button_pressed() -> void:
	visible = false
	settings_closed.emit()

func _on_sfx_volume_slider_value_changed(value: float) -> void:
	var bus_index = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value) - 7.0)

func _on_music_volume_slider_value_changed(value: float) -> void:
	var bus_index = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value) - 7.0)
