extends Area2D

@export var door_type : DoorNodeType

signal house1_entered
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print("body entered")
		$Sprite2D.texture = load(door_type.highlight)
		$Timer.start()

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		print("body exited")
		$Sprite2D.texture = load(door_type.base_door)
		$Timer.stop()
		
func _on_timer_timeout() -> void:
	if Input.is_action_pressed("interact"):
		emit_signal("house_entered", true)
		get_tree().change_scene_to_file(door_type.level_scene)
		
