extends Node2D

var screen_size # Size of the game window.
var spawner_x
var rng
var road_width
var t
@export var road_line_scene: PackedScene
@export var road_barrier_scene: PackedScene
@export var frequency = 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	road_width = screen_size.x * 0.3
	spawner_x = screen_size.x * 0.5
	$Player.set_y(screen_size.y * 0.8)
	
	rng = FastNoiseLite.new()
	rng.noise_type = FastNoiseLite.TYPE_PERLIN
	rng.frequency = frequency
	t = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	t += delta
	spawner_x = rng.get_noise_1d(t) * (screen_size.x * 0.5 - road_width * 0.5) + screen_size.x * 0.5

func _on_road_line_timer_timeout() -> void:
	var road_line = road_line_scene.instantiate()
	var left_barrier = road_barrier_scene.instantiate()
	var right_barrier = road_barrier_scene.instantiate()
	
	road_line.position.y = 0
	road_line.position.x = spawner_x
	
	add_child(road_line)

func _on_road_barrier_timer_timeout() -> void:
	var left_barrier = road_barrier_scene.instantiate()
	var right_barrier = road_barrier_scene.instantiate()
	
	left_barrier.position.y = 0
	left_barrier.position.x = spawner_x - road_width * 0.5
	right_barrier.position.y = 0
	right_barrier.position.x = spawner_x + road_width * 0.5
	
	add_child(left_barrier)
	add_child(right_barrier)
