extends Control

func _ready() -> void:
	SneakingAudio.stop()

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://screens/scenes/outside_map.tscn")
