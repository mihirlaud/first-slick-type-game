extends Node2D

signal score_changed(new_value)
signal mult_changed(new_value)
signal speed_changed(new_value)
signal game_over
signal game_start
signal pause_signal(is_paused)
signal stop_sound(stop)
signal help_opened(is_opened)
signal credits_opened(is_opened)
signal settings_opened(is_opened)

var screen_size # Size of the game window.
var road_width
@export var road_line_scene: PackedScene
@export var car_scene: PackedScene
@export var oil_scene: PackedScene
@export var truck_scene: PackedScene
@export var swerving_car_scene: PackedScene
@export var boost_scene: PackedScene
@export var frequency = 0.75
var score
var mult
var global_speed
var paused
var help_open
var game_done
var credits_open
var settings_open
var start = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Player.visible = false
	$Sidebar.visible = false
	help_open = false
	credits_open = false
	settings_open = false

func start_game() -> void:
	$RoadLineTimer.start()
	$ObstacleTimer.start()
	$ScoreTimer.start()
	$MultTimer.start()
	$SpeedTimer.start()
	$Player.visible = true
	$Sidebar.visible = true
	$Player.z_index = -1
	
	paused = false
	game_done = false
	randomize()
	
	add_to_group("game")
	
	screen_size = get_viewport_rect().size
	road_width = screen_size.x * 2 / 3
	$Player.set_y(screen_size.y * 0.8)
	$Player.set_x(screen_size.x / 3 + road_width * 0.5)
	
	score = 0
	mult = 1.0
	global_speed = 500
	
	var road_line = road_line_scene.instantiate()
	var gap = road_line.speed * $RoadLineTimer.wait_time
	for i in screen_size.y / gap:
		for j in 4:	
			road_line = road_line_scene.instantiate()
			
			road_line.position.y = i * gap
			road_line.position.x = screen_size.x / 3 + (j + 1) * road_width / 5
			road_line.add_to_group("moving")
			road_line.z_index = -1
	
			add_child(road_line)
	
	game_start.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	screen_size = get_viewport_rect().size
	road_width = screen_size.x * 2 / 3
	$Player.set_y(screen_size.y * 0.8)
	if not start and Input.is_action_just_pressed("restart"):
		restart()
	
	if not start and Input.is_action_just_pressed("help"):
		if help_open:
			close_help()
		else:
			open_help()
	
	if not start and Input.is_action_just_pressed("pause") and not game_done:
		if paused:
			unpause()
		else:
			pause()

func _on_road_line_timer_timeout() -> void:
	for j in 4:	
		var road_line = road_line_scene.instantiate()
	
		road_line.position.y = -30
		road_line.position.x = screen_size.x / 3 + (j + 1) * road_width / 5
		road_line.add_to_group("moving")
		road_line.z_index = -1
	
		add_child(road_line)
		
func _on_obstacle_timer_timeout() -> void:
	var selection = randi() % 100
	if selection < 40:
		var car = car_scene.instantiate()
		var lane = randi() % 5
	
		car.speed = global_speed
		car.position.y = -50
		car.position.x = screen_size.x / 3 + road_width * 0.1 + road_width * 0.2 * lane
		car.add_to_group("moving")
		car.add_to_group("obstacle")
		car.z_index = -1
		
		add_child(car)
	elif selection < 60:
		var truck = truck_scene.instantiate()
		var lane = randi() % 5
		
		truck.speed = global_speed
		truck.position.y = -100
		truck.position.x = screen_size.x / 3 + road_width * 0.1 + road_width * 0.2 * lane
		truck.add_to_group("moving")
		truck.add_to_group("obstacle")
		truck.z_index = -1
		
		add_child(truck)
	elif selection < 70:
		var swerving_car = swerving_car_scene.instantiate()
		var lane = randi() % 4
		
		swerving_car.speed = global_speed
		swerving_car.position.y = -50
		swerving_car.position.x = screen_size.x / 3 + road_width * 0.1 + road_width * 0.2 * lane
		swerving_car.start_x = swerving_car.position.x
		swerving_car.lane_width = road_width * 0.2
		swerving_car.add_to_group("moving")
		swerving_car.add_to_group("obstacle")
		swerving_car.z_index = -1
		
		add_child(swerving_car)
	elif selection < 80:
		var boost = boost_scene.instantiate()
		var lane = randi() % 4
		
		boost.speed = global_speed
		boost.position.y = -50
		boost.position.x = screen_size.x / 3 + road_width * 0.1 + road_width * 0.2 * lane
		boost.add_to_group("moving")
		boost.add_to_group("boost")
		boost.z_index = -1
		
		add_child(boost)
	else:
		var oil = oil_scene.instantiate()
		var lane = randi() % 5

		oil.speed = global_speed
		oil.position.y = -50
		oil.position.x = screen_size.x / 3 + road_width * 0.1 + road_width * 0.2 * lane
		oil.add_to_group("moving")
		oil.z_index = -1
		
		add_child(oil)

func stop_moving() -> void:
	$RoadLineTimer.stop()
	$ObstacleTimer.stop()
	$ScoreTimer.stop()
	$MultTimer.stop()
	$SpeedTimer.stop()
	$Player.pause()
	$Player.stop_boost()
	
	game_done = true
	game_over.emit()

func pause_core() -> void:
	$RoadLineTimer.stop()
	$ObstacleTimer.stop()
	$ScoreTimer.stop()
	$MultTimer.stop()
	$SpeedTimer.stop()
	$Player.pause()
	
	var movers = get_tree().get_nodes_in_group("moving")
	for mover in movers:
		if not mover.is_in_group("game"):
			mover.stop_moving()
	
	stop_sound.emit(true)

func unpause_core() -> void:
	$RoadLineTimer.start()
	$ObstacleTimer.start()
	$ScoreTimer.start()
	$MultTimer.start()
	$SpeedTimer.start()
	$Player.unpause()
	
	var movers = get_tree().get_nodes_in_group("moving")
	for mover in movers:
		if not mover.is_in_group("game"):
			mover.start_moving()
	
	stop_sound.emit(false)

func pause() -> void:
	paused = true
	
	pause_core()
	
	pause_signal.emit(true)

func unpause() -> void:
	paused = false
	
	unpause_core()
	
	pause_signal.emit(false)

func open_help() -> void:
	help_open = true
	
	pause_core()
	
	help_opened.emit(true)

func close_help() -> void:
	help_open = false
	
	unpause_core()
	
	help_opened.emit(false)

func open_credits() -> void:
	credits_open = true
	
	pause_core()
	
	credits_opened.emit(true)

func close_credits() -> void:
	credits_open = false
	
	unpause_core()
	
	credits_opened.emit(false)

func open_settings() -> void:
	settings_open = true
	
	pause_core()
	
	settings_opened.emit(true)

func close_settings() -> void:
	settings_open = false
	
	unpause_core()
	
	settings_opened.emit(false)

func restart() -> void:
	var movers = get_tree().get_nodes_in_group("moving")
	for mover in movers:
		mover.queue_free()
		
	$Player.set_x($Player.start_x)
	$Player.speed_mult = 0.0
	unpause()
	$Sidebar.reset()
	start_game()

func increase_score(increment) -> void:
	score += increment * mult
	score_changed.emit(score)

func change_mult(new_value) -> void:
	mult = new_value
	mult_changed.emit(new_value)

func increase_speed(increment) -> void:
	global_speed += increment
	speed_changed.emit(global_speed)

func _on_score_timer_timeout() -> void:
	increase_score(10)

func _on_mult_timer_timeout() -> void:
	change_mult(1.0 + round(10 * $Player.speed_mult) / 10.0)

func _on_speed_timer_timeout() -> void:
	if global_speed < 2000:
		increase_speed(100)

func _on_start_screen_start_game() -> void:
	start_game()
	start = false

func _on_sidebar_pause_clicked() -> void:
	pause()

func _on_sidebar_help_clicked() -> void:
	if help_open:
		close_help()
	else:
		open_help()

func _on_sidebar_credits_clicked() -> void:
	if credits_open:
		close_credits()
	else:
		open_credits()

func _on_credits_screen_credits_closed() -> void:
	if credits_open:
		close_credits()
	else:
		open_credits()

func _on_help_screen_help_closed() -> void:
	if help_open:
		close_help()
	else:
		open_help()

func _on_sidebar_settings_clicked() -> void:
	if settings_open:
		close_settings()
	else:
		open_settings()

func _on_settings_screen_settings_closed() -> void:
	if settings_open:
		close_settings()
	else:
		open_settings()
