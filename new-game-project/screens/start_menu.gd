extends Control

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://screens/outside_map.tscn")
