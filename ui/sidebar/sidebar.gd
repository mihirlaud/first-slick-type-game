extends Control

signal pause_clicked
signal help_clicked
signal credits_clicked
signal settings_clicked

var hi_score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var screen_size = get_viewport_rect().size
	hi_score = 0
	
	$ScoreLabel.text = "SCORE:\n0"
	$ScoreLabel.size = Vector2(screen_size.x / 3, 80)
	$ScoreLabel.position.y = 10
	
	$HiScoreLabel.text = "HI SCORE:\n0"
	$HiScoreLabel.size = Vector2(screen_size.x / 3, 80)
	$HiScoreLabel.position.y = 100
	
	$ColorRect.size = Vector2(screen_size.x / 3, screen_size.y)
	
	$PauseButton.position.x = 10
	$PauseButton.position.y = screen_size.y - 10 - $PauseButton.size.y
	
	$HelpButton.position.x = 10 + $PauseButton.size.x + 10
	$HelpButton.position.y = screen_size.y - 10 - $HelpButton.size.y
	
	$SettingsButton.position.x = 10 + $HelpButton.size.x + 10 + $PauseButton.size.x + 10
	$SettingsButton.position.y = screen_size.y - 10 - $SettingsButton.size.y
	
	$CreditsButton.position.x = 10 + $SettingsButton.size.x + 10 + $HelpButton.size.x + 10 + $PauseButton.size.x + 10
	$CreditsButton.position.y = screen_size.y - 10 - $CreditsButton.size.y

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

func _on_pause_button_pressed() -> void:
	pause_clicked.emit()

func _on_help_button_pressed() -> void:
	help_clicked.emit()

func _on_credits_button_pressed() -> void:
	credits_clicked.emit()

func _on_settings_button_pressed() -> void:
	settings_clicked.emit()
