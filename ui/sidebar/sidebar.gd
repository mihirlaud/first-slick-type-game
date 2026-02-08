extends Control

signal pause_clicked
signal help_clicked
signal credits_clicked
signal settings_clicked

var hi_score
var speed_dash_angle = -70
var mult_dash_angle = -140
var t

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	t = 0
	var screen_size = get_viewport_rect().size
	hi_score = 0
	
	$ScoreLabel.text = "SCORE:\n0"
	$HiScoreLabel.text = "HI SCORE:\n0"
	
	$PauseButton.scale = Vector2(2, 2)
	$PauseButton.position.x = 10
	$PauseButton.position.y = screen_size.y - 10 - $PauseButton.size.y * 2
	
	$HelpButton.scale = Vector2(2, 2)
	$HelpButton.position.x = 10 + $PauseButton.size.x * 2 + 10
	$HelpButton.position.y = screen_size.y - 10 - $HelpButton.size.y * 2
	
	$SettingsButton.scale = Vector2(2, 2)
	$SettingsButton.position.x = 10 + $HelpButton.size.x * 2 + 10 + $PauseButton.size.x * 2 + 10
	$SettingsButton.position.y = screen_size.y - 10 - $SettingsButton.size.y * 2
	
	$CreditsButton.scale = Vector2(2, 2)
	$CreditsButton.position.x = 10 + $SettingsButton.size.x * 2 + 10 + $HelpButton.size.x * 2 + 10 + $PauseButton.size.x * 2 + 10
	$CreditsButton.position.y = screen_size.y - 10 - $CreditsButton.size.y * 2
	
	$SpeedNeedleSprite.position.x = screen_size.x / 6 - 70
	$SpeedNeedleSprite.position.y = screen_size.y / 2 + 40
	
	$MultNeedleSprite.position.x = screen_size.x / 6 + 70
	$MultNeedleSprite.position.y = screen_size.y / 2 + 40
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	t += delta
	$SpeedNeedleSprite.rotation_degrees = speed_dash_angle + sin(2*t) * 5

func _on_game_mult_changed(new_value: Variant) -> void:
	mult_dash_angle = (new_value - 1.0) / (10.0 - 1.0) * (140 - -140) + -140
	$MultNeedleSprite.rotation_degrees = mult_dash_angle

func _on_game_score_changed(new_value: Variant) -> void:
	$ScoreLabel.text = str("SCORE:\n", int(round(new_value)))
	if new_value > hi_score:
		$HiScoreLabel.text = str("HI SCORE:\n", int(round(new_value)))
		hi_score = new_value

func reset() -> void:
	$ScoreLabel.text = "SCORE:\n0"
	speed_dash_angle = -70
	mult_dash_angle = -140
	$MultNeedleSprite.rotation_degrees = mult_dash_angle
	$SpeedNeedleSprite.rotation_degrees = speed_dash_angle

func _on_game_speed_changed(new_value: Variant) -> void:
	var actual_value = new_value / 10.0
	speed_dash_angle = (actual_value - 50.0) / (200.0 - 50.0) * (140 - -70) + -70
	$SpeedNeedleSprite.rotation_degrees = speed_dash_angle

func _on_pause_button_pressed() -> void:
	pause_clicked.emit()

func _on_help_button_pressed() -> void:
	help_clicked.emit()

func _on_credits_button_pressed() -> void:
	credits_clicked.emit()

func _on_settings_button_pressed() -> void:
	settings_clicked.emit()
