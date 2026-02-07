extends Node2D

@export var driving_sfx: AudioStreamPlayer2D
@export var crash_sfx: AudioStreamPlayer2D

func _on_start_screen_start_game():
	driving_sfx.play()

func _on_main_game_over():
	crash_sfx.play()
	driving_sfx.stop()

func _on_main_stop_sound(stop: Variant) -> void:
	if stop :
		driving_sfx.stop()
	else:
		driving_sfx.play()
