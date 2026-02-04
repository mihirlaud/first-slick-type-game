extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	
	$Label.add_theme_font_size_override("font_size", 16)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_game_game_over() -> void:
	visible = true

func _on_game_game_start() -> void:
	visible = false
