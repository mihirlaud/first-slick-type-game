extends Control

var hi_score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var screen_size = get_viewport_rect().size
	hi_score = 0
	
	$ScoreLabel.text = "SCORE:\n0"
	$ScoreLabel.size = Vector2(screen_size.x / 3, 80)
	
	$HiScoreLabel.text = "HI SCORE:\n0"
	$HiScoreLabel.size = Vector2(screen_size.x / 3, 80)
	$HiScoreLabel.position.y = 90
	
	$ColorRect.size = Vector2(screen_size.x / 3, screen_size.y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_game_mult_changed(new_value: Variant) -> void:
	pass

func _on_game_score_changed(new_value: Variant) -> void:
	$ScoreLabel.text = str("SCORE:\n", int(round(new_value)))
	if new_value > hi_score:
		$HiScoreLabel.text = str("HI SCORE:\n", int(round(new_value)))
		hi_score = new_value

func reset() -> void:
	$ScoreLabel.text = "SCORE:\n0"

func _on_game_speed_changed(new_value: Variant) -> void:
	pass
