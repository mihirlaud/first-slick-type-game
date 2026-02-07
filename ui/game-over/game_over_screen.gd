extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var screen_size = get_viewport_rect().size
	
	$ForwardLabel.position.x = 0
	$ForwardLabel.position.y = screen_size.y / 2 - 40
	
	$MiddleLabel.position.x = 10
	$MiddleLabel.position.y = screen_size.y / 2 - 50
	
	$BackLabel.position.x = 20
	$BackLabel.position.y = screen_size.y / 2 - 60
	
	visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_game_game_over() -> void:
	visible = true

func _on_game_game_start() -> void:
	visible = false
