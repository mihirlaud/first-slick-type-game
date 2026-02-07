extends Control

signal start_game
var started

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = true
	started = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not started and Input.is_action_just_pressed("start_game"):
		started = true
		start_game.emit()
		visible = false
