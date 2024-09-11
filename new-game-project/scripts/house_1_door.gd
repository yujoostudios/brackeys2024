extends Area2D

var highlight = preload("res://assets/art/house-1-door-highlighted.png")
var base_door = preload("res://assets/art/house-1-door.png")

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print("body entered")
		$Sprite2D.texture = highlight
		$Timer.start()

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		print("body exited")
		$Sprite2D.texture = base_door
		$Timer.stop()
		
func _on_timer_timeout() -> void:
	if Input.is_action_pressed("interact"):
		get_tree().change_scene_to_file("res://screens/scenes/house_1_level.tscn")
		
