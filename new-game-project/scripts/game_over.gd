extends Control

func _process(delta: float) -> void:
	pass
	
func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://screens/scenes/outside_map.tscn")

func _on_quit_game_pressed() -> void:
	get_tree().change_scene_to_file("res://screens/scenes/start_menu.tscn")
