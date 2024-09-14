extends Area2D

class_name pickup
@export var node_type : ResourceNodeType
signal money_change

func _on_body_entered(body: Node2D) -> void:
	$Timer.start()
	print(node_type.item_name)
	print(node_type.value)
	
func _on_body_exited(body: Node2D) -> void:
	$Timer.stop()

func _on_timer_timeout() -> void:
	if Input.is_action_pressed("interact"):
		emit_signal("money_change", node_type.value)
		queue_free()
	
func _on_area_entered(area: Area2D) -> void:
	$Timer.start()
	print(node_type.item_name)
	print(node_type.value)

func _on_area_exited(area: Area2D) -> void:
	$Timer.stop()
