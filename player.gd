extends Area2D

@export var max_speed = 1000 # How fast the player will move (pixels/sec).
@export var player_y = 0
@export var start_x: int
var screen_size # Size of the game window.
var velocity
var control_lost = false
var paused = false
var speed_mult = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity = Vector2.ZERO
	screen_size = get_viewport_rect().size
	position = Vector2(start_x, player_y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if paused:
		return
	
	if not control_lost:
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
	position = position.clamp(Vector2(screen_size.x / 3, player_y), Vector2(screen_size.x, player_y))
	
	if not control_lost:
		var dx = position.x - start_x
		var dy = player_y
		var theta = atan2(dy, dx) - PI / 2
		rotation = theta
	else:
		rotation += 0.05
	
	var speed_factor = abs(velocity.x) * 4.0
	if speed_factor > 0.1:
		speed_mult += 0.001 * speed_factor
	else:
		speed_mult -= 0.002
	
	speed_mult = max(0.0, min(4.0, speed_mult))
	
	if control_lost:
		speed_mult = 0.0

func set_y(new_y) -> void:
	player_y = new_y
	position.y = player_y
	
func set_x(new_x) -> void:
	start_x = new_x
	position.x = start_x

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("oil"):
		control_lost = true
		$ControlLossTimer.start()
	elif area.is_in_group("obstacle"):
		var moving = get_tree().get_nodes_in_group("moving")
		for node in moving:
			node.stop_moving()
		
		var game = get_tree().get_first_node_in_group("game")
		game.stop_moving()

func _on_control_loss_timer_timeout() -> void:
	control_lost = false

func pause() -> void:
	paused = true

func unpause() -> void:
	paused = false
