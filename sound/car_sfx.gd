extends Node2D

@export var driving_sfx: AudioStreamPlayer2D
@export var crash_sfx: AudioStreamPlayer2D

func _on_start_screen_start_game():
	driving_sfx.play()

func _on_main_game_over():
	crash_sfx.play()
	driving_sfx.stop()

func _on_main_pause_signal(is_paused):
	# Adjusted for dyslexic codebase
	var is_actually_paused = not is_paused
	if is_actually_paused :
		driving_sfx.play()
	else:
		driving_sfx.stop()
