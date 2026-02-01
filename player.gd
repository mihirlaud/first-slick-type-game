extends Area2D

@export var max_speed = 800 # How fast the player will move (pixels/sec).
@export var max_rot_speed = 0.025
var screen_size # Size of the game window.
var velocity
var rotational_velocity

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity = 0
	rotational_velocity = 0
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("accel"):
		velocity += 0.01
	else:
		velocity -= 0.005
	
	if Input.is_action_pressed("brake"):
		velocity -= 0.01
	
	velocity = max(0, min(1, velocity))
	
	if Input.is_action_pressed("turn_left"):
		rotational_velocity -= 0.01
	elif Input.is_action_pressed("turn_right"):
		rotational_velocity += 0.01
	else:
		if rotational_velocity > 0:
			rotational_velocity -= 0.008
		elif rotational_velocity < 0:
			rotational_velocity += 0.008
	
	rotational_velocity = max(-1, min(1, rotational_velocity))
	
	rotation += rotational_velocity * max_rot_speed * velocity
	
	var dv = Vector2(velocity * delta * max_speed, 0)
	
	position += dv.rotated(rotation)
	position = position.clamp(Vector2.ZERO, screen_size)
