extends Area2D

@export var max_speed = 800 # How fast the player will move (pixels/sec).
@export var player_y = 0
var screen_size # Size of the game window.
var velocity

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity = Vector2.ZERO
	screen_size = get_viewport_rect().size
	position = Vector2(screen_size.x / 2, player_y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("turn_left"):
		velocity.x -= 0.01
	elif Input.is_action_pressed("turn_right"):
		velocity.x += 0.01
	else:
		if velocity.x > 0:
			velocity.x -= 0.005
		elif velocity.x < 0:
			velocity.x += 0.005
	
	velocity = velocity.clamp(Vector2(-1, 0), Vector2(1, 0))
	
	var dv = velocity * delta * max_speed
	
	position += dv
	position = position.clamp(Vector2.ZERO, screen_size)
	
	var dx = position.x - screen_size.x / 2
	var dy = player_y
	var theta = atan2(dy, dx) - PI / 2
	rotation = theta

func set_y(new_y) -> void:
	player_y = new_y
	position.y = player_y
