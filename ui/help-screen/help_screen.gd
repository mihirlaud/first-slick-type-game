extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	
	var screen_size = get_viewport_rect().size
	
	position.x = screen_size.x / 2 - $ColorRect.size.x / 2
	position.y = screen_size.y / 2 - $ColorRect.size.y / 2
	
	$CloseButton.position.y = 10
	$CloseButton.position.x = $ColorRect.size.x - $CloseButton.size.x + 5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_close_button_pressed() -> void:
	visible = false

func _on_game_help_opened(is_opened) -> void:
	visible = is_opened
