extends Control

signal credits_closed

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
	var screen_size = get_viewport_rect().size
	
	position.x = screen_size.x / 2 - $ColorRect.size.x / 2
	position.y = screen_size.y / 2 - $ColorRect.size.y / 2
	
	$CloseButton.scale = Vector2(2, 2)
	$CloseButton.position.y = 10
	$CloseButton.position.x = $ColorRect.size.x - $CloseButton.size.x * 2 - 10

func _on_main_credits_opened(is_opened: Variant) -> void:
	visible = is_opened

func _on_texture_button_pressed() -> void:
	visible = false
	credits_closed.emit()
