extends Control

func _ready() -> void:
	SneakingAudio.play_menu_music()

func _on_start_button_pressed() -> void:
	SneakingAudio.play_sneaking_music()
	get_tree().change_scene_to_file("res://screens/scenes/outside_map.tscn")
