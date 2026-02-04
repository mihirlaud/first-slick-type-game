extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anchor_top = 0
	anchor_left = 0
	anchor_right = 1.0 / 3.0
	anchor_bottom = 1.0
	
	$ScoreLabel.text = "Score: 0"
	$MultLabel.text = "Mult: 1.0"
	$SpeedLabel.text = "Speed: 50"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_game_mult_changed(new_value: Variant) -> void:
	$MultLabel.text = str("Mult: ", new_value)

func _on_game_score_changed(new_value: Variant) -> void:
	$ScoreLabel.text = str("Score: ", int(round(new_value)))

func reset() -> void:
	$ScoreLabel.text = "Score: 0"
	$MultLabel.text = "Mult: 1.0"
	$SpeedLabel.text = "Speed: 50"

func _on_game_speed_changed(new_value: Variant) -> void:
	$SpeedLabel.text = str("Speed: ", int(new_value / 10.0))
