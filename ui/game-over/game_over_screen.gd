extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var screen_size = get_viewport_rect().size
	
	$ColorRect.anchor_right = 1.0
	$ColorRect.anchor_bottom = 1.0
	
	visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_game_game_over() -> void:
	visible = true

func _on_game_game_start() -> void:
	visible = false
