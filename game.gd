extends Node2D

var screen_size # Size of the game window.
var rng
var road_width
var t
@export var road_line_scene: PackedScene
@export var cone_scene: PackedScene
@export var oil_scene: PackedScene
@export var roadblock_scene: PackedScene
@export var frequency = 0.75

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	
	add_to_group("game")
	
	screen_size = get_viewport_rect().size
	road_width = screen_size.x * 2 / 3
	$Player.set_y(screen_size.y * 0.8)
	$Player.set_x(screen_size.x / 3 + road_width * 0.5)
	
	rng = FastNoiseLite.new()
	rng.noise_type = FastNoiseLite.TYPE_PERLIN
	rng.frequency = frequency
	rng.seed = randi()
	t = 0
	
	var road_line = road_line_scene.instantiate()
	var gap = road_line.speed * $RoadLineTimer.wait_time
	for i in screen_size.y / gap:
		for j in 4:	
			road_line = road_line_scene.instantiate()
			
			road_line.position.y = i * gap
			road_line.position.x = screen_size.x / 3 + (j + 1) * road_width / 5
	
			add_child(road_line)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	t += delta
	
	if Input.is_action_just_pressed("restart"):
		restart()

func _on_road_line_timer_timeout() -> void:
	for j in 4:	
		var road_line = road_line_scene.instantiate()
	
		road_line.position.y = 0
		road_line.position.x = screen_size.x / 3 + (j + 1) * road_width / 5
		road_line.add_to_group("moving")
	
		add_child(road_line)
		
func _on_obstacle_timer_timeout() -> void:
	var selection = randi() % 100
	if selection < 60:
		var cone = cone_scene.instantiate()
		var lane = randi() % 5
	
		cone.position.y = 0
		cone.position.x = screen_size.x / 3 + road_width * 0.1 + road_width * 0.2 * lane
		cone.add_to_group("moving")
		cone.add_to_group("obstacle")
		
		add_child(cone)
	elif selection < 80:
		var road_block = roadblock_scene.instantiate()
		var lane = randi() % 3 + 1
		
		road_block.position.y = 0
		road_block.position.x = screen_size.x / 3 + road_width * 0.1 + road_width * 0.2 * lane
		road_block.add_to_group("moving")
		road_block.add_to_group("obstacle")
		
		add_child(road_block)
	else:
		var oil = oil_scene.instantiate()
		var lane = randi() % 5
	
		oil.position.y = 0
		oil.position.x = screen_size.x / 3 + road_width * 0.1 + road_width * 0.2 * lane
		oil.add_to_group("moving")
		
		add_child(oil)

func stop_moving() -> void:
	$RoadLineTimer.stop()
	$ObstacleTimer.stop()
	$Player.pause()

func restart() -> void:
	var movers = get_tree().get_nodes_in_group("moving")
	for mover in movers:
		mover.queue_free()
		
	$Player.set_x($Player.start_x)
	$RoadLineTimer.start()
	$ObstacleTimer.start()
	$Player.unpause()
	_ready()
