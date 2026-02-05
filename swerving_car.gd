extends Area2D

@export var speed = 500
var moving = true
var t
@export var start_x: float
@export var lane_width: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	t = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	t += delta
	if moving:
		position.y += speed * delta
		position.x = start_x + lane_width * sin(t / 0.5)

func stop_moving() -> void:
	moving = false

func start_moving() -> void:
	moving = true

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
