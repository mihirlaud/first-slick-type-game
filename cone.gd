extends Area2D

@export var speed = 500
var moving = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if moving:
		position.y += speed * delta

func stop_moving() -> void:
	moving = false
	
func start_moving() -> void:
	moving = true

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
