extends Control

signal start_game
var started

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = true
	started = false
	
	var screen_size = get_viewport_rect().size
	
	$ForwardLabel.position.x = 0
	$ForwardLabel.position.y = screen_size.y / 2 - 140
	
	$MiddleLabel.position.x = 10
	$MiddleLabel.position.y = screen_size.y / 2 - 150
	
	$BackLabel.position.x = 20
	$BackLabel.position.y = screen_size.y / 2 - 160

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not started and Input.is_action_just_pressed("start_game"):
		started = true
		start_game.emit()
		visible = false
